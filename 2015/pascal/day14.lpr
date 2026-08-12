program day14;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Math,
  Generics.Collections;

const
  input = '../input/day-14.txt';

type
  TData = record
    speed:    integer;
    flight:   integer;
    rest:     integer;
    distance: integer;
    points:   integer;
  end;

  TDataList = array of TData;

  procedure ParseInput(const line: string; var data: TDataList);
  var
    fields:   array of string;
    reindeer: TData;
  begin
    fields := line.split(' ');

    reindeer.speed  := fields[3].ToInteger;
    reindeer.flight := fields[6].ToInteger;
    reindeer.rest   := fields[13].ToInteger;

    SetLength(data, length(data) + 1);
    data[high(data)] := reindeer;
  end;

  function DistanceTraveled(reindeer: TData; maxtime: integer): integer;
  var
    time: integer = 0;
    dist: integer = 0;
  begin
    while time <= maxtime do
    begin
      Inc(dist, reindeer.speed * min(reindeer.flight, maxtime - time));
      Inc(time, reindeer.flight + reindeer.rest);
    end;
    result := dist;
  end;

  procedure advance(var reindeer: TData; const time: integer);
  var
    a, b: integer;
  begin
    a := (time mod (reindeer.flight + reindeer.rest));
    b := reindeer.flight;
    if (1 <= a) and (a <= b) then
      Inc(reindeer.distance, reindeer.speed);
  end;

  procedure AwardPoint(var data: TDataList);
  var
    maxdist: integer = 0;
    reindeer: TData;
    i: integer;
  begin
    for reindeer in data do
      maxdist := max(maxdist, reindeer.distance);

    for i := low(data) to high(data) do
      if data[i].distance = maxdist then
        Inc(data[i].points);
  end;

var
  F:       TextFile;
  line:    string;
  data:    TDataList = nil;
  reindeer: TData;
  maxtime: integer = 2503;
  distance: integer = 0;
  maxpoints: integer = 0;
  time, i: integer;

begin
  AssignFile(F, input);
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, line);
    ParseInput(line, data);
  end;

  for reindeer in data do
    distance := max(distance, DistanceTraveled(reindeer, maxtime));
  WriteLn('Part 1: ', distance);

  for time := 1 to maxtime do
  begin
    for i := low(data) to high(data) do
      advance(data[i], time);
    AwardPoint(data);
  end;

  for reindeer in data do
    maxpoints := max(maxpoints, reindeer.points);
  WriteLn('Part 2: ', maxpoints);
end.
