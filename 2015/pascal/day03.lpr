program day03;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Generics.Collections;

const
  InputFile = '../input/day-03.txt';

type
  THouse = record
    x, y: integer;
  end;
  THouseArr    = array of THouse;
  TStrBoolDict = specialize TDictionary<string, boolean>;

  procedure advance(var houses: THouseArr; const ch: char);
  var
    next: THouse;
  begin
    next := houses[high(houses)];
    case ch of
      '>': Inc(next.x);
      '<': Dec(next.x);
      'v': Inc(next.y);
      '^': Dec(next.y);
    end;
    SetLength(houses, Length(houses) + 1);
    houses[High(houses)] := next;
  end;

  function CountHouses(const houses: THouseArr): integer;
  var
    dict:  TStrBoolDict;
    house: THouse;
  begin
    dict := TStrBoolDict.Create;
    try
      for house in houses do
        dict.AddOrSetValue(format('%d-%d', [house.x, house.y]), True);
      Result := dict.Count;
    finally
      dict.Free;
    end;
  end;

var
  input:  Text;
  ch:     char;
  turn:   integer = 0;
  origin: THouse;
  houses: THouseArr;
  santa:  THouseArr;
  robo:   THouseArr;

begin
  origin := default(THouse);
  houses := [origin];
  santa  := [origin];
  robo   := [origin];

  AssignFile(input, InputFile);
  Reset(input);

  try
    while not EOF(input) do
    begin
      Read(input, ch);
      advance(houses, ch);
      if turn mod 2 = 0 then
        advance(santa, ch)
      else
        advance(robo, ch);
      Inc(turn);
    end;
  finally
    Close(input);
  end;

  WriteLn(format('Part 1: %d',
    [CountHouses(houses)]));

  WriteLn(format('Part 2: %d',
    [CountHouses(Concat(santa, robo))]));
end.
