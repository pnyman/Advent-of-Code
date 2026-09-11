program day01;
{$mode ObjFPC}{$H+}
uses
  SysUtils,
  Math,
  Generics.Collections;

const
  input = '../input/day-01.txt';

type
  TDirection = (N, E, S, W);

  TPoint = record
    x, y: integer;
  end;

  TDict = specialize TDictionary<string, boolean>;

var
  F:     TextFile;
  parts: array of string;
  dir:   TDirection;
  line, part: string;
  steps, i: integer;
  point, location: TPoint;
  dict:  TDict;
  found: boolean = False;

begin
  dir      := N;
  point    := default(TPoint);
  location := default(TPoint);
  dict     := TDict.Create;

  AssignFile(F, input);
  Reset(F);
  ReadLn(F, line);
  parts := line.split([', ']);
  Close(F);

  for part in parts do
  begin
    steps := StrToInt(Copy(part, 2));
    if part[1] = 'R' then
      dir := TDirection((Ord(dir) + 1) mod 4)
    else
      dir := TDirection((Ord(dir) + 3) mod 4);

    for i := 1 to steps do
    begin
      case dir of
        N: Inc(point.y);
        S: Dec(point.y);
        E: Inc(point.x);
        W: Dec(point.x);
      end;

      if not found then
        if not dict.TryAdd(format('%dx%d', [point.x, point.y]), True) then
        begin
          location := point;
          found    := True;
        end;
    end;
  end;

  WriteLn('Part 1: ', abs(point.y) + abs(point.x));
  WriteLn('Part 2: ', abs(location.y) + abs(location.x));
end.
