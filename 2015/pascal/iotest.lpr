program day02;
{$mode ObjFPC}{$H+}
uses
  SysUtils,
  Classes,
  streamex,
  Math;

type
  TData = record
    l, w, h: integer;
  end;

var
  fileStream: TStream;
  reader:     TStreamReader;
  data:       TData;
  line:       string;
  sum1:       integer = 0;
  sum2:       integer = 0;
  a, b, c, l, w, h, m: integer;

begin
  fileStream := TFileStream.Create('../input/day-02.txt', fmOpenRead);
  reader     := TStreamReader.Create(fileStream);
  while not reader.EOF do
  begin
    line := reader.ReadLine;
    SScanf(line, '%dx%dx%d', [@data.l, @data.w, @data.h]);
    l    := data.l;
    h    := data.h;
    w    := data.w;
    a    := l * w;
    b    := w * h;
    c    := h * l;

    Inc(sum1, 2 * (a + b + c) + min(min(a, b), c));
    m := (l + w + h) - max(max(l, w), h);
    Inc(sum2, 2 * m + l * h * w);
  end;

  WriteLn(format('Part 1: %d, part 2: %d', [sum1, sum2]));
end.
// Part 1: 1606483, part 2: 3842356