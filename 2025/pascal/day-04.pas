Program day_04;

{$mode objfpc}{$H+}{$J-}
{$R+}{$Q+}

Uses
SysUtils, StrUtils, Math, FGL;

const
   INPUT =   '../input/day-04-input.txt';


type
   TGrid =  Array of Array of Boolean;
   TCoord =  Record
      y, x:  Integer;
   end;
   TCoordArray =  Array of TCoord;


function GetInput :  TGrid;
var
   tfIn :  textFile;
   s :  string;
   y, x :  Integer;
   grid :  TGrid;
begin
   AssignFile(tfIn, INPUT);
   SetLength(grid, 0);
   y := 0;

   try
      reset(tfIn);
      while not eof(tfIn) do
         begin
            ReadLn(tfIn, s);
            SetLength(grid, y + 1);
            SetLength(grid[y], Length(s));
            for x := 0 to Pred(Length(s)) do
               grid[y][x] := s[x + 1] = '@';
            Inc(y);
         end;
      CloseFile(tfIn);

   except
      on E:  EInOutError do WriteLn('IOerror: ', E.Message);
   end;

   Result := grid;
end;


function RangeCheck(grid : TGrid; y, x: Integer):  Boolean;
begin
   result := (y >= Low(grid)) And (x >= Low(grid))
             And (y <= High(grid))
             And (x <= High(grid[y]));
end;


function CheckAdjacent(grid : TGrid; y, x : Integer) :  Boolean;
var
   rolls, yy, xx :  Integer;
begin
   if not grid[y][x] then Exit(False);
   rolls := 0;
   for yy := y - 1 to y + 1 do
      for xx := x - 1 to x + 1 do
         if RangeCheck(grid, yy, xx) then
            if grid[yy][xx] then
               begin
                  Inc(rolls);
                  if rolls > 4 then Exit(False);
               end;
   result := True;
end;


procedure Part_1;
var
   grid :  TGrid;
   y, x, acc :  Integer;
begin
   grid := GetInput;
   acc := 0;
   for y := 0 to High(grid) do
      for x := 0 to High(grid[y]) do
         if CheckAdjacent(grid, y, x) then Inc(acc);
   WriteLn(acc);
end;


procedure Part_2;
var
   grid :  TGrid;
   mask :  TCoordArray;
   y, x, i, cnt :  Integer;
   acc :  Integer;
begin
   grid := GetInput;
   acc := 0;

   Repeat
      cnt := 0;
      SetLength(mask, Length(grid) * Length(grid[0]));

      for y := 0 to High(grid) do
         for x := 0 to High(grid[y]) do
            if CheckAdjacent(grid, y, x) then
               begin
                  mask[cnt].y := y;
                  mask[cnt].x := x;
                  Inc(cnt);
               end;

      if cnt = 0 then Break;

      Inc(acc, cnt);
      for i := 0 to Pred(cnt) do
         grid[mask[i].y][mask[i].x] := false
  Until false;

   WriteLn(acc);
end;

begin
   Part_1;
   Part_2;
end.
