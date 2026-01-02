Program day_01;
{$mode objfpc}{$H+}{$J-}{$R+}

Uses
SysUtils, Math;

const
   INPUT = '../input/day-01-input.txt';

type
   TIntArray = Array of Integer;

function GetInput(): TIntArray;
var
   tfIn: textFile;
   s: String;
   A: TIntArray;
begin
   SetLength(A, 0);
   AssignFile(tfIn, INPUT);
   reset(tfIn);

   while not eof(tfIn) do
      begin
         readln(tfIn, s);
         s := StringReplace(s, 'L', '-', [rfReplaceAll]);
         s := StringReplace(s, 'R', '', [rfReplaceAll]);
         Insert(StrToInt(s), A, MaxInt);
      end;

   CloseFile(tfIn);
   result := A;
end;


function Passes(start: Integer; step: Integer): Integer;
var
   ending: Integer;
begin
   result := 0;
   ending := start + step;
   if step > 0 then
      result := Floor(ending / 100.0)
   else
      if step < 0 then
         result := Floor((start - 1) / 100.0) - Floor((ending - 1) / 100.0)
end;

var
   rot, arrow, acc, clicks: Integer;

begin
   arrow := 50;
   acc := 0;
   clicks := 0;

   for rot in GetInput do
      begin
         Inc(clicks, Passes(arrow, rot));
         arrow := ((arrow + rot) Mod 100 + 100) Mod 100;
         if arrow = 0 then Inc(acc);
      end;

   writeln(acc, ', ', clicks);
end.
