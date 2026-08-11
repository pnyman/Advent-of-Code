program day09;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Generics.Collections,
  Math;

const
  input = 'input/day-09.txt';

type
  TMyArray   = array of string;
  TMyPerms   = array of TMyArray;
  TPlaces    = specialize TDictionary<string, integer>;
  TDistances = specialize TDictionary<string, TPlaces>;

var
  distances: TDistances;

  procedure AddDistance(const start, destination, distance: string);
  var
    inner: TPlaces;
  begin
    if distances.ContainsKey(start) then
      inner := distances[start]
    else
    begin
      inner := TPlaces.Create;
      distances.add(start, inner);
    end;
    inner.Add(destination, StrToInt(distance));
  end;

  function GetDistance(start, destination: string): integer;
  var
    inner: TPlaces;
  begin
    inner  := distances[start];
    Result := inner[destination];
  end;

  procedure ParseInput(const line: string; var places: TPlaces);
  var
    temp: array of string = nil;
    start, destination, distance: string;
  begin
    temp     := line.split(' ');
    start    := temp[0];
    destination := temp[2];
    distance := temp[4];
    places.AddOrSetValue(start, 0);
    places.AddOrSetValue(destination, 0);
    AddDistance(start, destination, distance);
    AddDistance(destination, start, distance);
  end;

  procedure Permutations(var res: TMyPerms; var arr: TMyArray; idx: integer);
  var
    i:    integer;
    temp: string;
  begin
    if idx = length(arr) then
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

  function GetPerms(var arr: TMyArray): TMyPerms;
  var
    res: TMyPerms = nil;
  begin
    Permutations(res, arr, 0);
    Result := res;
  end;

var
  F:     TextFile;
  line:  string;
  perms: TMyPerms;
  places: TMyArray;
  temp:  TPlaces;
  place: string;
  i, dist, maxdist, mindist: integer;

begin
  distances := TDistances.Create;
  temp    := TPlaces.Create;
  perms   := TMyPerms.Create;
  places  := TMyArray.Create;
  mindist := high(integer);
  maxdist := 0;
  AssignFile(F, input);
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, line);
    ParseInput(line, temp);
  end;

  for place in temp.keys do
  begin
    SetLength(places, length(places) + 1);
    places[high(places)] := place;
  end;

  perms := GetPerms(places);
  for places in perms do
  begin
    dist := 0;
    for i := 0 to high(places) - 1 do
      dist  += GetDistance(places[i], places[i + 1]);
    mindist := min(mindist, dist);
    maxdist := max(maxdist, dist);
  end;

  WriteLn('Part 1: ', mindist);
  WriteLn('Part 2: ', maxdist);
end.
