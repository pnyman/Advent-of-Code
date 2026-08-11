program day10;
{$mode ObjFPC}{$H+}

uses
  SysUtils;

type
  TAoI = array of integer;

  function LookAndSay(const input: TAoI): TAoI;
  var
    i, previous, ctr: integer;
  begin
    if length(input) = 1 then
      exit([1, input[0]]);

    result := nil;
    previous := input[low(input)];
    ctr := 1;

    for i := low(input) + 1 to high(input) do
      if input[i] = previous then
        Inc(ctr)
      else
      begin
        SetLength(result, length(result) + 2);
        result[high(result) - 1] := ctr;
        result[high(result)] := previous;
        previous := input[i];
        ctr := 1;
      end;

    SetLength(result, length(result) + 2);
    result[high(result) - 1] := ctr;
    result[high(result)]     := previous;
  end;

var
  input: TAoI = (1, 1, 1, 3, 1, 2, 2, 1, 1, 3);
  n:     integer;

begin
  for n := 1 to 40 do
    input := LookAndSay(input);
  WriteLn('Part 1:  ', length(input));

  for n := 1 to 10 do
    input := LookAndSay(input);
  WriteLn('Part 2: ', length(input));
end.
