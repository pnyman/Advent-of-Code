Program day_02;

{$mode objfpc}{$H+}{$J-}
{$R+}{$Q+}

Uses
SysUtils, StrUtils, Math, FGL;

const
   INPUT =   '../input/day-02-input.txt';

type
   TInt2DArray =  Array of Array of Int64;

   // GetInput()
function GetInput() :  TInt2DArray;
var
   tfIn :  textFile;
   s :  string;
   i :  Integer;
   A :  TInt2DArray;
   C, D :  Array of String;
begin
   i := 0;
   AssignFile(tfIn, INPUT);

   try
      reset(tfIn);
      while not eof(tfIn) do
         begin
            readln(tfIn, s);
            C := SplitString(s, ',');
            SetLength(A, Length(C));
            for i := Low(C) to High(C) do
               begin
                  SetLength(A[i], 2);
                  D := SplitString(C[i], '-');
                  A[i][0] := StrToInt64(D[0]);
                  A[i][1] := StrToInt64(D[1]);
               end;
         end;
      CloseFile(tfIn);

   except
      on E:  EInOutError do writeln('IOerror: ', E.Message);
   end;

   Result := A;
end;

// 28846518423
procedure part_1;
var
   A :  TInt2DArray;
   i, len, half :  Integer;
   num, acc :  Int64;
   s :  String;
begin
   A := GetInput();
   acc := 0;
   for i := Low(A) to High(A) do
      begin
         for num := A[i][0] to A[i][1] do
            begin
               s := IntToStr(num);
               len := Length(s);
               if (len mod 2) = 0 then
                  begin
                     half := len Div 2;
                     if copy(s, 1, half) = copy(s, half + 1, half) then
                        inc(acc, num);
                  end;
            end;
      end;
   writeln(acc);
end;

function IsInvalid(num: UInt64):  Boolean;
var
   len, f, step, i :  Integer;
   pow, base       :  UInt64;
   acc             :  UInt64;
begin
   Result := False;
   len := Trunc(Log10(num)) + 1;

   for f := 2 to len do
      begin
         if (len mod f) <> 0 then Continue;

         step := len Div f;
         pow  := 1;
         for i := 1 to step do
            pow := pow * 10;

         base := num Mod pow;
         if base = 0 then Continue;

         acc := 0;
         for i := 1 to f do
            acc := acc * pow + base;

         if acc = num then Exit(True);
      end;
end;

// 31578210022
procedure part_2;
var
   i :  Integer;
   acc, num :  int64;
   A :  TInt2DArray;
   D : Array of Int64;
begin
   A := GetInput;
   acc := 0;
   for i := Low(A) to High(A) do
      begin
         for num := A[i][0] to A[i][1] do
            if IsInvalid(num) then inc(acc, num);
      end;
   writeln(acc);
end;

// main
begin
   part_1;
   part_2;
end.
