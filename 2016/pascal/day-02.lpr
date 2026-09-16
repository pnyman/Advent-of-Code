program day02;
{$mode ObjFPC}{$H+}
uses
  SysUtils;

const
  input = '../input/day-02.txt';

  keypad: array [1..3] of array [1..3] of string =
    (('1', '2', '3'), ('4', '5', '6'), ('7', '8', '9'));

  keypad2: array [1..5] of array [1..5] of string =
    (('', '', '1', '', ''),
    ('', '2', '3', '4', ''),
    ('5', '6', '7', '8', '9'),
    ('', 'A', 'B', 'C', ''),
    ('', '', 'D', '', ''));

  function solve1: string;
  var
    F:    TextFile;
    line: string;
    ch:   char;
    row, col: integer;
  begin
    result := '';
    row    := 2;
    col    := 2;

    AssignFile(F, input);
    Reset(F);

    while not EOF(F) do
    begin
      ReadLn(F, line);
      for ch in line do
        case ch of
          'R': if col < 3 then Inc(col);
          'L': if col > 1 then Dec(col);
          'D': if row < 3 then Inc(row);
          'U': if row > 1 then Dec(row);
        end;
      result += keypad[row][col];
    end;

    Close(F);
  end;

  function solve2: string;
  var
    F:    TextFile;
    line: string;
    ch:   char;
    row:  integer = 3;
    col:  integer = 1;
  begin
    result := '';
    AssignFile(F, input);
    Reset(F);

    while not EOF(F) do
    begin
      ReadLn(F, line);
      for ch in line do
        case ch of
          'R': if (col < 5) and not
              keypad2[row][succ(col)].IsEmpty then
              Inc(col);
          'L': if (col > 1) and not
              keypad2[row][pred(col)].IsEmpty then
              Dec(col);
          'D': if (row < 5) and not
              keypad2[succ(row)][col].Isempty then
              Inc(row);
          'U': if (row > 1) and not
              keypad2[pred(row)][col].IsEmpty then
              Dec(row);
        end;
      result += keypad2[row][col];
    end;

    Close(F);
  end;

begin
  WriteLn('Part 1: ', solve1);
  WriteLn('Part 2: ', solve2);
end.
