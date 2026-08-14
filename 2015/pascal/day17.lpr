program day17;
{$mode ObjFPC}{$H+}
{$WARN 6058 OFF}

uses
  SysUtils,
  Math,
  Generics.Collections;

const
  input = '../input/day-17.txt';

type
  TIntArray = array of integer;

  function combinations(arr: TIntArray; target: integer; ctr: integer = 0): TIntArray;
  begin
    if target = 0 then
      result := [ctr]
    else if (length(arr) = 0) or (target < 0) then
      result := nil
    else
      result := concat(
        combinations(copy(arr, 1), (target - arr[0]), (1 + ctr)),
        combinations(copy(arr, 1), target, ctr));
  end;

  function occurs(arr: TIntArray; val: integer): integer;
  var
    n: integer;
  begin
    result := 0;
    for n in arr do
      if n = val then
        Inc(result);
  end;

var
  F:     TextFile;
  line:  string;
  combs: TIntArray;
  containers: TIntArray = nil;

begin
  AssignFile(F, input);
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, line);
    SetLength(containers, length(containers) + 1);
    containers[high(containers)] := line.ToInteger;
  end;

  combs := combinations(containers, 150);
  WriteLn(format('Part 1: %d', [length(combs)]));
  WriteLn(format('Part 2: %d', [occurs(combs, MinValue(combs))]));
end.
