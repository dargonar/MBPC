DROP TABLESPACE data INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
DROP TABLESPACE mbpc INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

--MOD:
create tablespace mbpc datafile 'e:/oraclexe/app/oracle/oradata/XE/mbpc.dbf'
size                                  10M
autoextend on maxsize                200M
extent management local uniform size  64K;