program day13;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Math,
  Generics.Collections;

const
  input = '../input/day-13.txt';

type
  TNames    = array of string;
  TPerms    = array of TNames;
  TPeople   = specialize TDictionary<string, integer>;
  TSeatings = specialize TDictionary<string, TPeople>;

var
  seatings: TSeatings;

  procedure AddHappiness(const person, neighbour: string; const happiness: integer); forward;

  procedure ParseInput(const line: string; var people: TPeople);
  var
    person, neighbour: string;
    happiness: integer;
    fields:    array of string;
  begin
    fields    := line.split(' ');
    person    := fields[low(fields)];
    neighbour := fields[high(fields)].TrimRight(['.']);
    happiness := fields[3].ToInteger;

    if fields[2].equals('lose') then
      happiness *= -1;

    people.AddOrSetValue(person, 0);
    people.AddOrSetValue(neighbour, 0);
    AddHappiness(person, neighbour, happiness);
  end;

  procedure Permutations(var res: TPerms; var arr: TNames; idx: integer);
  var
    i:    integer;
    temp: string;
  begin
    if idx = high(arr) then
    begin
      SetLength(res, length(res) + 1);
      res[high(res)] := copy(arr);
      exit;
    end;

    for i := idx to high(arr) do
    begin
      temp     := arr[idx];
      arr[idx] := arr[i];
      arr[i]   := temp;

      Permutations(res, arr, idx + 1);

      temp     := arr[idx];
      arr[idx] := arr[i];
      arr[i]   := temp;
    end;
  end;

  function GetPermutations(var arr: TNames): TPerms;
  var
    res: TPerms = nil;
  begin
    Permutations(res, arr, 0);
    Result := res;
  end;

  procedure AddHappiness(const person, neighbour: string; const happiness: integer);
  var
    inner: TPeople;
  begin
    if seatings.ContainsKey(person) then
      inner := seatings[person]
    else
    begin
      inner := TPeople.Create;
      seatings.add(person, inner);
    end;
    inner.AddOrSetValue(neighbour, happiness);
  end;

  function GetHappiness(const person, neighbour: string): integer;
  var
    inner: TPeople;
  begin
    inner  := seatings[person];
    Result := inner[neighbour];
  end;

  function CalculateHappiness(names: TNames): integer;
  var
    perms:     TPerms;
    perm:      Tnames;
    len, i:    integer;
    happiness: integer;
    p1, p2:    string;
  begin
    result := 0;
    perms  := GetPermutations(names);
    len    := length(names);

    for perm in perms do
    begin
      happiness := 0;

      for i := low(perm) to high(perm) do
      begin
        p1 := perm[i];
        p2 := perm[(i + 1) mod len];
        Inc(happiness, GetHappiness(p1, p2));
        Inc(happiness, GetHappiness(p2, p1));
      end;

      result := max(result, happiness);
    end;
  end;

var
  F:      TextFile;
  line:   string;
  person: string;
  people: TPeople;
  part1, part2: integer;

begin
  seatings := TSeatings.Create;
  people   := TPeople.Create;
  AssignFile(F, input);
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, line);
    ParseInput(line, people);
  end;

  part1 := CalculateHappiness(people.keys.ToArray);
  WriteLn('Part 1: ', part1);

  // part 2
  for person in people.keys do
  begin
    AddHappiness('Myself', person, 0);
    AddHappiness(person, 'Myself', 0);
  end;
  people.Add('Myself', 0);

  part2 := CalculateHappiness(people.keys.ToArray);
  WriteLn('Part 2: ', part2);
end.
