program day06;
{$mode ObjFPC}{$H+}
uses
  SysUtils;

const
  input = '../input/day-06.txt';

var
  F:       TextFile;
  freq:    array[1..8] of array['a'..'z'] of integer;
  c, x, y: char;
  i, max, min: integer;
  line, mes1, mes2: string;

begin
  FillChar(freq, SizeOf(freq), 0);

  Assign(F, input);
  Reset(F);
  while not EOF(F) do
  begin
    ReadLn(F, line);
    for i := 1 to 8 do
      Inc(freq[i][line[i]]);
  end;
  Close(F);

  mes1 := '';
  mes2 := '';

  for i := 1 to 8 do
  begin
    max := 0;
    min := high(integer);
    for c in ['a'..'z'] do
    begin
      if freq[i][c] > max then
      begin
        max := freq[i][c];
        x   := c;
      end;
      if (0 < freq[i][c]) and (freq[i][c] < min) then
      begin
        min := freq[i][c];
        y   := c;
      end;
    end;

    mes1 += x;
    mes2 += y;
  end;

  WriteLn('Part 1: ', mes1);
  WriteLn('Part 2: ', mes2);
end.
