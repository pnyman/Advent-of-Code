program day12;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Classes,
  fpjson,
  jsonparser;

const
  input = 'input/day-12.json';

  function SumNumbers(jData: TJSONData; part2: boolean): integer;
  var
    e: TJSONEnum;
  begin
    result := 0;
    case jData.JSONType of
      jtNumber:
        result += jData.AsInteger;
      jtArray:
        for e in TJSONArray(jData) do
          result += SumNumbers(e.Value, part2);
      jtObject:
        for e in TJSONObject(jData) do
        begin
          if part2 and
            (e.Value.JSONType = jtString) and
            'red'.equals(e.Value.AsString) then
            exit(0);
          result += SumNumbers(e.Value, part2);
        end;
    end;
  end;

var
  fsJSONFile: TFileStream;
  jData: TJSONData;
  sum: integer;

begin
  fsJSONFile := TFileStream.Create(input, fmOpenRead);
  jData      := GetJSON(fsJSONFile);

  sum := SumNumbers(jData, False);
  WriteLn('Part 1: ', sum);

  sum := SumNumbers(jData, True);
  WriteLn('Part 2:  ', sum);
end.
