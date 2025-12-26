Program day_01;

{$mode objfpc}{$H+}{$J-}
{$R+}

Uses
SysUtils, Math;

const
   INPUT =   '../input/day-01-input.txt';

type
   TIntArray =   Array of Integer;

   // getInput()
function getInput() :  TIntArray;
var
   tfIn   :   textFile;
   s      :   string;
   i      :   Integer;
   A      :   TIntArray;
begin
   i := 0;
   SetLength(A, 100);
   AssignFile(tfIn, INPUT);

   try
      reset(tfIn);
      while not eof(tfIn) do
         begin
            readln(tfIn, s);
            s := StringReplace(s, 'L', '-', [rfReplaceAll]);
            s := StringReplace(s, 'R', '', [rfReplaceAll]);
            A[i] := StrToInt(s);
            inc(i, 1);
            if i >= (Length(A) - 1) then SetLength(A, 2 * Length(A));
         end;
      CloseFile(tfIn);

   except
      on E:  EInOutError do writeln('IOerror: ', E.Message);
   end;

   SetLength(A, i);
   result := A;
end;

// part_1()
procedure part_1();
var
   i, arrow, acc :  Integer;
   A :   TIntArray;
begin
   A := getInput();
   arrow := 50;
   acc := 0;

   for i := low(A) to high(A) do
      begin
         arrow := ((arrow + A[i]) Mod 100 + 100) Mod 100;
         if arrow = 0 then inc(acc, 1);
      end;

   writeln(acc);
end;

// passes()
function passes(start : Integer; step : Integer) :  Integer;
var
   ending :  Integer;
begin
   ending := start + step;
   if step > 0 then
      result := Floor(ending / 100.0)
   else if step < 0 then
           result := Floor((start - 1) / 100.0) - Floor((ending - 1) / 100.0)
   else
      result := 0;
end;

// part_2()
procedure part_2();
var
   i, arrow, clicks, value :  Integer;
   A :  TIntArray;
begin
   arrow := 50;
   clicks := 0;
   A := getInput();

   for i := low(A) to high(A) do
      begin
         value := A[i];
         inc(clicks, passes(arrow, value));
         arrow := ((arrow + value) Mod 100 + 100) Mod 100;
      end;

   writeln(clicks);
end;

// main
begin
   part_1();
   part_2();
end.
