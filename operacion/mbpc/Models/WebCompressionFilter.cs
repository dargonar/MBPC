using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.IO.Compression;

namespace mbpc.Models
{
  public enum CompressionType
  {
    Deflate,
    GZip
  }

  public sealed class WebCompressionFilter : Stream
  {
    private readonly Stream _compSink;
    private readonly Stream _finalSink;
    public WebCompressionFilter(Stream stm, CompressionType comp)
    {
      switch (comp)
      {
        case CompressionType.Deflate:
          _compSink = new DeflateStream((_finalSink = stm), CompressionMode.Compress);
          break;
        case CompressionType.GZip:
          _compSink = new GZipStream((_finalSink = stm), CompressionMode.Compress);
          break;
        default:
          throw new ArgumentException();
      }
    }
    public Stream Sink
    {
      get
      {
        return _finalSink;
      }
    }
    public CompressionType CompressionType
    {
      get
      {
        return _compSink is DeflateStream ? CompressionType.Deflate : CompressionType.GZip;
      }
    }
    public override bool CanRead
    {
      get
      {
        return false;
      }
    }
    public override bool CanSeek
    {
      get
      {
        return false;
      }
    }
    public override bool CanWrite
    {
      get
      {
        return true;
      }
    }
    public override long Length
    {
      get
      {
        throw new NotSupportedException();
      }
    }
    public override long Position
    {
      get
      {
        throw new NotSupportedException();
      }
      set
      {
        throw new NotSupportedException();
      }
    }
    public override void Flush()
    {
      //We do not flush the compression stream. At best this does nothing, at worse it
      //loses a few bytes. We do however flush the underlying stream to send bytes down the
      //wire.
      _finalSink.Flush();
    }
    public override long Seek(long offset, SeekOrigin origin)
    {
      throw new NotSupportedException();
    }
    public override void SetLength(long value)
    {
      throw new NotSupportedException();
    }
    public override int Read(byte[] buffer, int offset, int count)
    {
      throw new NotSupportedException();
    }
    public override void Write(byte[] buffer, int offset, int count)
    {
      _compSink.Write(buffer, offset, count);
    }
    public override void WriteByte(byte value)
    {
      _compSink.WriteByte(value);
    }
    public override void Close()
    {
      _compSink.Close();
      _finalSink.Close();
      base.Close();
    }
    protected override void Dispose(bool disposing)
    {
      if (disposing)
      {
        _compSink.Dispose();
        _finalSink.Dispose();
      }
      base.Dispose(disposing);
    }
  }

}