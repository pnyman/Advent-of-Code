program day16;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Generics.Collections;

const
  input = '../input/day-16.txt';

type
  TSueDict = specialize TDictionary<string, integer>;
  TSueArr  = array of TSueDict;

  procedure ParseInput(line: string; var data: TSueArr);
  var
    fields: array of string;
    sue:    TSueDict;
    idx:    integer = 0;
  begin
    sue    := TSueDict.Create;
    line   := LowerCase(line);
    fields := line.replace(':', '').replace(',', '').split(' ');
    while idx < 8 do
    begin
      sue.add(fields[idx], fields[idx + 1].ToInteger);
      Inc(idx, 2);
    end;
    SetLength(data, length(data) + 1);
    data[high(data)] := sue;
  end;

  function TestSue1(sue, clues: TSueDict): boolean;
  var
    kv: TSueDict.TDictionaryPair;
  begin
    for kv in sue do
    begin
      if kv.key.equals('sue') then
        continue;
      if not (kv.Value = clues[kv.key]) then
        exit(False);
    end;
    result := True;
  end;

  function TestSue2(sue, clues: TSueDict): boolean;
  var
    kv: TSueDict.TDictionaryPair;
    val, clue: integer;
  begin
    for kv in sue do
    begin
      if kv.key.equals('sue') then
        continue;
      val  := kv.Value;
      clue := clues[kv.key];
      case kv.key of
        'cats', 'trees':
          if val <= clue then exit(False);
        'pomeranians', 'goldfish':
          if val >= clue then exit(False);
        else
          if not (val = clue) then exit(False);
      end;
    end;
    result := True;
  end;

var
  F:     TextFile;
  line:  string;
  clues: specialize TDictionary<string, integer>;
  data:  TSueArr;
  sue:   TSueDict;

begin
  clues := TSueDict.Create;
  clues.Add('children', 3);
  clues.Add('cats', 7);
  clues.Add('samoyeds', 2);
  clues.Add('pomeranians', 3);
  clues.Add('akitas', 0);
  clues.Add('vizslas', 0);
  clues.Add('goldfish', 5);
  clues.Add('trees', 3);
  clues.Add('cars', 2);
  clues.Add('perfumes', 1);

  data := nil;

  AssignFile(F, input);
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, line);
    ParseInput(line, data);
  end;

  for sue in data do
    if TestSue1(sue, clues) then
      WriteLn('Part 1: ', sue['sue']);

  for sue in data do
    if TestSue2(sue, clues) then
      WriteLn('Part 2: ', sue['sue']);
end.
