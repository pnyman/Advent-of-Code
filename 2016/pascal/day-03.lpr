program day03;
{$mode ObjFPC}{$H+}
uses
  SysUtils;

const
  input = '../input/day-03.txt';

type
  TRow  = array[0..2] of integer;
  TRows = array of TRow;

  function IsTriangle(a, b, c: integer): boolean;
  begin
    result := (a + b > c) and (a + c > b) and (b + c > a);
  end;

  function Solve1: integer;
  var
    F:    TextFile;
    line: string;
    row:  TStringArray;
  begin
    result := 0;
    AssignFile(F, input);
    Reset(F);

    while not EOF(F) do
    begin
      ReadLn(F, line);
      row := line.split(' ', TStringSplitOptions.ExcludeEmpty);
      if IsTriangle(row[0].ToInteger, row[1].ToInteger, row[2].ToInteger) then
        Inc(result);
    end;
    Close(F);
  end;

  function Solve2: integer;
  var
    F:      TextFile;
    line:   string;
    parts:  TStringArray;
    rows:   TRows;
    i, col: integer;
  begin
    result := 0;
    rows   := nil;
    AssignFile(F, input);
    Reset(F);

    while not EOF(F) do
    begin
      ReadLn(F, line);
      parts := line.Split([' '], TStringSplitOptions.ExcludeEmpty);
      SetLength(rows, length(rows) + 1);
      rows[high(rows)][0] := parts[0].ToInteger;
      rows[high(rows)][1] := parts[1].ToInteger;
      rows[high(rows)][2] := parts[2].ToInteger;
    end;
    Close(F);

    i := 0;
    while i + 2 <= high(rows) do
    begin
      for col := 0 to 2 do
        if IsTriangle(rows[i][col], rows[i + 1][col], rows[i + 2][col]) then
          Inc(result);
      Inc(i, 3);
    end;
  end;

begin
  WriteLn('Part 1:  ', solve1);
  WriteLn('Part 2: ', solve2);
end.
