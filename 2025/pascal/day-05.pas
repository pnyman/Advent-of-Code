Program day_05;

{$mode objfpc}{$H+}{$J-}{$R+}{$Q+}

Uses SysUtils, StrUtils, Math;

const
   INPUT = '../input/day-05-input.txt';

type
   TRange = Record
      a, b: Int64;
   end;
   TFreshArray = Array of TRange;
   TAvailableArray = Array of Int64;


procedure GetInput(Var fresh: TFreshArray; Var available: TAvailableArray);
var
   tfIn: textFile;
   line: String;
   limits: Array of String;
   range: TRange;
begin
   AssignFile(tfIn, INPUT);
   SetLength(fresh, 0);
   SetLength(available, 0);

   try
      reset(tfIn);
      while not eof(tfIn) do
         begin
            ReadLn(tfIn, line);
            if line.Contains('-') then
               begin
                  limits := line.Split('-');
                  range.a := StrToInt64(limits[0]);
                  range.b := StrToInt64(limits[1]);
                  SetLength(fresh, Length(fresh) + 1);
                  fresh[High(fresh)] := range;
               end
            else
               if Length(line) > 0 then
                  begin
                     SetLength(available, Length(available) + 1);
                     available[High(available)] := StrToInt64(line);
                  end;
         end;
      CloseFile(tfIn);

   except
      on E: EInOutError do WriteLn('IOerror: ', E.Message);
   end;
end;


procedure Part_1(Const fresh: TFreshArray; Const available: TAvailableArray);
var
   x: Int64;
   r: TRange;
   count: Integer;
begin
   count := 0;
   for x in available do
      for r in fresh do
         if (r.a <= x) and (x <= r.b) then
            begin
               Inc(count);
               break;
            end;
   WriteLn(count);
end;


procedure SortIntervals(Var fresh: TFreshArray);
var
   i, j: Integer;
   temp: TRange;
begin
   for i := Low(fresh) to High(fresh) - 1 do
      for j := i + 1 to High(fresh) do
         if fresh[i].a > fresh[j].a then
            begin
               temp := fresh[i];
               fresh[i] := fresh[j];
               fresh[j] := temp;
            end;
end;


function MergeIntervals(Var fresh: TFreshArray): TFreshArray;
var
   merged: TFreshArray;
   r_high: Int64;
   r: TRange;
begin
   SetLength(merged, 0);
   SortIntervals(fresh);
   for r in fresh do
      if Length(merged) = 0 then
         begin
            SetLength(merged, Length(merged) + 1);
            merged[High(merged)] := r;
         end
      else
         begin
            r_high := merged[High(merged)].b;
            if r.a > (1 + r_high) then
               begin
                  SetLength(merged, Length(merged) + 1);
                  merged[High(merged)] := r;
               end
            else
               merged[High(merged)].b := Max(r.b, r_high);
         end;
   result := merged;
end;


procedure Part_2(fresh: TFreshArray);
var
   sum: Int64;
   r: TRange;
begin
   sum := 0;
   for r in MergeIntervals(fresh) do
      Inc(sum, 1 + r.b - r.a);
   WriteLn(sum);
end;


// main
var
   fresh: TFreshArray;
   available: TAvailableArray;

begin
   GetInput(fresh, available);
   Part_1(fresh, available);
   Part_2(fresh);
end.
