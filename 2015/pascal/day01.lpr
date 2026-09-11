program day01;
{$mode ObjFPC}{$H+}
uses
  SysUtils;

var
  F:     file of char;
  c:     char;
  floor: integer = 0;
  pos:   integer = -1;

begin
  Assign(F, '../input/day-01.txt');
  Reset(F);
  while not EOF(F) do
  begin
    Read(F, c);
    if c = '(' then Inc(floor)
    else if c = ')' then Dec(floor);
    if (floor = -1) and (pos = -1) then pos := FilePos(F);
  end;
  Close(F);
  WriteLn('Part 1: ', floor, ', part 2: ', pos);
end.
