Program day_03;

{$mode objfpc}{$H+}{$J-}
{$R+}{$Q+}

Uses
SysUtils, StrUtils, Math, FGL;

const
   INPUT =   '../input/day-03-input.txt';

type
   TInt2DArray =  Array of Array of Integer;

   // GetInput
function GetInput :  TInt2DArray;
var
   tfIn :  textFile;
   s :  string;
   i, k :  Integer;
   A :  TInt2DArray;
begin
   AssignFile(tfIn, INPUT);
   SetLength(A, 0);
   k := -1;

   try
      reset(tfIn);
      while not eof(tfIn) do
         begin
            readln(tfIn, s);
            SetLength(A, Length(A) + 1);
            inc(k, 1);
            SetLength(A[k], Length(s));
            for i := 0 to Length(s) - 1 do
               A[k][i] := StrToInt(copy(s, i + 1, 1));
         end;
      CloseFile(tfIn);

   except
      on E:  EInOutError do writeln('IOerror: ', E.Message);
   end;

   Result := A;
end;

// 17359
procedure part_1;
var
   arr :  TInt2DArray;
   a, b, i, j, k :  Integer;
   sum :  Integer;
begin
   sum := 0;
   arr := GetInput;
   for i := Low(arr) to High(arr) do
      begin
         a := 0;
         b := 0;
         k := 0;
         for j := Low(arr[i]) to High(arr[i]) - 1 do
            if arr[i][j] > a then
               begin
                  a := arr[i][j];
                  k := j;
               end;
         for j := k + 1 to High(arr[i]) do
            b := Max(b, arr[i][j]);
         sum := sum + (10 * a) + b;
      end;
   writeln(sum);
end;

// 172787336861064
procedure part_2;
var
   arr :  TInt2DArray;
   bank, stack :  Array of Integer;
   i, j, battery, to_remove :  Integer;
   total, tmp :  Uint64;
begin
   arr := GetInput;
   total := 0;
   for i := Low(arr) to High(arr) do
      begin
         bank := arr[i];
         to_remove := Length(bank) - 12;
         SetLength(stack, 0);
         for j := Low(bank) to High(bank) do
            begin
               battery := bank[j];
               while (Length(stack) > 0)
                     and (stack[High(stack)] < battery)
                     and (to_remove > 0) do
                  begin
                     SetLength(stack, Length(stack) - 1);
                     dec(to_remove);
                  end;
               SetLength(stack, Length(stack) + 1);
               stack[High(stack)] := battery;
            end;
         tmp := 0;
         for j := 0 to 11 do
            tmp := tmp * 10 + stack[j];
         total := total + tmp;
      end;
   writeln(total);
end;

// main
begin
   part_1;
   part_2;
end.
