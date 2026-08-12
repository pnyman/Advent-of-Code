program day05;
{$mode ObjFPC}{$H+}

uses
  SysUtils;

const
  input = 'input/day-05.txt';

  function ContainsThreeWovels(const line: string): boolean;
  var
    vowels: set of char = ['a', 'e', 'i', 'o', 'u'];
    n:  integer = 0;
    ch: char;
  begin
    for ch in line do
      if ch in vowels then
        Inc(n);
    Result := n >= 3;
  end;

  function HasTwiceInARow(const line: string): boolean;
  var
    i: integer;
  begin
    for i := 1 to line.length - 1 do
      if line[i] = line[i + 1] then
        exit(True);
    Result := False;
  end;

  function NoFobiddenStrings(const line: string): boolean;
  var
    forbidden: array of string = ('ab', 'cd', 'pq', 'xy');
    x: string;
  begin
    for x in forbidden do
      if line.contains(x) then
        exit(False);
    Result := True;
  end;

  function HasNonOverlappingPairs(const line: string): boolean;
  var
    i: integer;
    head, rest: string;
  begin
    for i := 0 to line.length - 4 do
    begin
      head := line.substring(i, 2);
      rest := line.substring(i + 2);
      if rest.contains(head) then
        exit(True);
    end;
    Result := False;
  end;

  function HasRepeating(const line: string): boolean;
  var
    i: integer;
  begin
    for i := 1 to line.length - 2 do
      if line[i] = line[i + 2] then
        exit(True);
    Result := False;
  end;

var
  F:    Text;
  line: string;
  sum1: integer = 0;
  sum2: integer = 0;

begin
  AssignFile(F, input);
  Reset(F);

  try
    while not EOF(F) do
    begin
      ReadLn(F, line);
      if ContainsThreeWovels(line) and
        HasTwiceInARow(line) and
        NoFobiddenStrings(line) then
        Inc(sum1);
      if HasNonOverlappingPairs(line) and
        HasRepeating(line) then
        Inc(sum2);
    end;

    WriteLn('Part 1: ', sum1);
    WriteLn('Part 2:  ', sum2);

  finally
    Close(F);
  end;
end.
