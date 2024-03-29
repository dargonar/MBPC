﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace MvcMiniProfiler.SqlFormatters
{
    /// <summary>
    /// Formats SQL server queries with a DECLARE up top for parameter values
    /// </summary>
    public class SqlServerFormatter : ISqlFormatter
    {

        static readonly Dictionary<DbType, Func<SqlTimingParameter, string>> paramTranslator;

        static Func<SqlTimingParameter, string> GetWithLenFormatter(string native)
        {
            var capture = native;
            return p => {
                if (p.Size < 1) { return capture; } else { return capture + "(" + (p.Size > 8000 ? "max" : p.Size.ToString()) + ")"; }
            };
        }

        static SqlServerFormatter()
        {   
            paramTranslator = new Dictionary<DbType, Func<SqlTimingParameter, string>>
            {
                {DbType.AnsiString, GetWithLenFormatter("varchar")},
                {DbType.String, GetWithLenFormatter("nvarchar")},
                {DbType.AnsiStringFixedLength, GetWithLenFormatter("char")},
                {DbType.StringFixedLength, GetWithLenFormatter("nchar")},
                {DbType.Byte, p => "tinyint"},
                {DbType.Int16, p => "smallint"},
                {DbType.Int32, p => "int"},
                {DbType.Int64, p => "bigint"},
                {DbType.DateTime, p => "datetime"},
                {DbType.Guid, p => "uniqueidentifier"},
                {DbType.Boolean, p => "bit"},
            };

        }

        /// <summary>
        /// Formats the SQL in a SQL-Server friendly way, with DECLARE statements for the parameters up top.
        /// </summary>
        /// <param name="timing">The SqlTiming to format</param>
        /// <returns>A formatted SQL string</returns>
        public string FormatSql(SqlTiming timing)
        {
            
            if (timing.Parameters == null || timing.Parameters.Count == 0)
            {
                return timing.CommandString;
            }

            StringBuilder buffer = new StringBuilder();

            buffer.Append("DECLARE ");

            bool first = true;
            foreach (var p in timing.Parameters)
            {
                if (first)
                {
                    first = false;
                }
                else
                {
                    buffer.AppendLine(",").Append(new string(' ', 8));
                }

                DbType parsed;
                string resolvedType = null;
                if (!EnumTryParse<DbType>(p.DbType, false, out parsed))
                {
                    resolvedType = p.DbType;
                }
                
                if (resolvedType == null)
                {
                    Func<SqlTimingParameter, string> translator; 
                    if (paramTranslator.TryGetValue(parsed, out translator))
                    {
                        resolvedType = translator(p);
                    }
                    resolvedType = resolvedType ?? p.DbType;
                }

                var niceName = p.Name;
                if (!niceName.StartsWith("@"))
                {
                    niceName = "@" + niceName;
                }

                buffer.Append(niceName).Append(" ").Append(resolvedType).Append(" = ").Append(PrepareValue(p));
            }

            return buffer
                .AppendLine()
                .AppendLine()
                .Append(timing.CommandString)
                .ToString();
        }

        private static bool EnumTryParse<TEnum>(string value, bool ignoreCase, out TEnum result) where TEnum : struct
        {
            // Taken from Mono: https://github.com/mono/mono/blob/master/mcs/class/corlib/System/Enum.cs
            Type tenum_type = typeof(TEnum);
            if (!tenum_type.IsEnum)
                throw new ArgumentException("TEnum is not an Enum type.", "enumType");

            result = default(TEnum);

            if (value == null || value.Trim().Length == 0)
                return false;

            result = (TEnum)Enum.Parse(tenum_type, value, ignoreCase);
            return true;
        }

        static readonly string[] dontQuote = new string[] {"Int16","Int32","Int64", "Boolean"};
        private string PrepareValue(SqlTimingParameter p)
        {
            if (p.Value == null)
            {
                return "null";
            }

            if (dontQuote.Contains(p.DbType))
            {
                return p.Value;
            }

            string prefix = "";
            if (p.DbType == "String" || p.DbType == "StringFixedLength")
            {
                prefix = "N";
            }

            return prefix + "'" + p.Value.Replace("'","''") + "'";
        }
    }
}
