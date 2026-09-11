program day06;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Math,
  RegExpr;

const
  input = '../input/day-06.txt';

type
  TInstruction = record
    action: string;
    startx: integer;
    starty: integer;
    stopx:  integer;
    stopy:  integer;
  end;

  TBoolArray = array of array of boolean;
  TIntArray  = array of array of integer;

  function ParseLinexxx(const line: string): TInstruction;
  var
    parts:    TStringArray;
    subparts: TStringArray;
  begin
    parts := line.split(' ');
    if length(parts) > 4 then Delete(parts, 0, 1);
    Result.action := parts[0];
    subparts      := parts[1].split(',');
    Result.startx := StrToInt(subparts[0]);
    Result.starty := StrToInt(subparts[1]);
    subparts      := parts[3].split(',');
    Result.stopx  := StrToInt(subparts[0]);
    Result.stopy  := StrToInt(subparts[1]);
  end;

  function ParseLine(const line: string): TInstruction;
  var
    re:  TRegExpr;
    pat: string;
  begin
    pat := '^(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)$';
    re  := TRegExpr.Create(pat);
    try
      if not re.Exec(line) then
        raise Exception.CreateFmt('Kunde inte tolka rad: %s', [line]);
      Result.action := re.match[1];
      Result.startx := StrToInt(re.match[2]);
      Result.starty := StrToInt(re.match[3]);
      Result.stopx  := StrToInt(re.match[4]);
      Result.stopy  := StrToInt(re.match[5]);
    finally
      re.Free;
    end;
  end;

var
  F:      Text;
  line:   string;
  x, y:   integer;
  alight: integer = 0;
  brightness: integer = 0;
  instruction: TInstruction;
  grid1:  TBoolArray = nil;
  grid2:  TIntArray = nil;

begin
  SetLength(grid1, 1000, 1000);
  SetLength(grid2, 1000, 1000);
  AssignFile(F, input);
  Reset(F);

  try
    while not EOF(F) do
    begin
      ReadLn(F, line);
      instruction := ParseLine(line);

      for x := instruction.startx to instruction.stopx do
        for y := instruction.starty to instruction.stopy do
          case instruction.action of
            'on':
            begin
              grid1[x][y] := True;
              Inc(grid2[x][y]);
            end;
            'off':
            begin
              grid1[x][y] := False;
              grid2[x][y] := max(grid2[x][y] - 1, 0);
            end;
            'toggle':
            begin
              grid1[x][y] := not grid1[x][y];
              Inc(grid2[x][y], 2);
            end;
          end;
    end;

    for x := 0 to 999 do
      for y := 0 to 999 do
      begin
        if grid1[x][y] then Inc(alight);
        Inc(brightness, grid2[x][y]);
      end;

    WriteLn('Part 1:   ', alight);
    WriteLn('Part 2: ', brightness);

  finally
    Close(F);
  end;
end.
