program day18;
{$mode ObjFPC}{$H+}
{$WARN 6058 OFF}

uses
  SysUtils,
  Classes;

const
  inputfile = '../input/day-18.txt';

type
  TDeltas = array of array of integer;
  TGrid   = array of array of boolean;

const
  deltas: TDeltas =
    ((0, 1), (0, -1), (1, 0), (-1, 0),
    (1, 1), (1, -1), (-1, 1), (-1, -1));

var
  rows_, cols_: integer;

  function GetInput: TGrid;
  var
    F:     TextFile;
    line:  string;
    input: TStringList;
    grid:  TGrid;
    r, c:  integer;
  begin
    input := TStringList.Create;
    AssignFile(F, inputfile);
    Reset(F);

    while not EOF(F) do
    begin
      ReadLn(F, line);
      input.add(line);
    end;

    rows_ := input.Count;
    cols_ := input[0].length;
    // make a ring around the data to avoid range checks
    SetLength(grid, (rows_ + 2), (cols_ + 2));

    // N.B. Strings are 1-indexed!
    for r := 0 to rows_ - 1 do
      for c := 1 to cols_ do
        if input[r][c] = '#' then
          grid[r + 1][c] := True;

    result := grid;
  end;

  function CountNeighbours(grid: TGrid; row, col: integer): integer;
  var
    i, r, c: integer;
  begin
    result := 0;
    for i  := low(deltas) to high(deltas) do
    begin
      r := row + deltas[i][0];
      c := col + deltas[i][1];
      if grid[r][c] then Inc(result);
    end;
  end;

  function MaybeToggle(grid: TGrid; row, col: integer): boolean;
  var
    neighbours: integer;
    lighted:    boolean;
  begin
    neighbours := CountNeighbours(grid, row, col);
    lighted    := grid[row][col];
    if lighted then
      result := (neighbours = 2) or (neighbours = 3)
    else
      result := neighbours = 3;
  end;

  function CountLighted(grid: TGrid): integer;
  var
    r, c: integer;
  begin
    result := 0;
    for r  := 1 to rows_ do
      for c := 1 to cols_ do
        if grid[r][c] then Inc(result);
  end;

  procedure LightCorners(var grid: TGrid);
  begin
    grid[1][1]     := True;
    grid[1][cols_] := True;
    grid[rows_][1] := True;
    grid[rows_][cols_] := True;
  end;

  function solve(part2: boolean = False; steps: integer = 100): integer;
  var
    grid, newgrid: TGrid;
    n, r, c, i:    integer;
  begin
    grid := GetInput;
    if part2 then LightCorners(grid);
    for n := 1 to steps do
    begin
      SetLength(newgrid, (rows_ + 2), (cols_ + 2));
      for r := 1 to rows_ do
        for c := 1 to cols_ do
          newgrid[r][c] := MaybeToggle(grid, r, c);
      grid := copy(newgrid);
      for i := low(newgrid) to high(newgrid) do
        grid[i] := copy(newgrid[i]);
      if part2 then LightCorners(grid);
    end;
    result := CountLighted(grid);
  end;

// 821, 886
begin
  WriteLn(format('Part 1: %d', [solve()]));
  WriteLn(format('Part 2: %d', [solve(True)]));
end.
