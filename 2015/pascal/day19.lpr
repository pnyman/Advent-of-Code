program day19;
{$mode ObjFPC}{$H+}
{$WARN 6058 OFF}

uses
  SysUtils,
  StrUtils,
  Classes;

const
  inputfile = '../input/day-19.txt';

type
  TRule = record
    a, b: string;
  end;
  TRules = array of TRule;

  procedure GetInput(var molecule: string; var rules: TRules);
  var
    F:      TextFile;
    line:   string;
    rule:   TRule;
    fields: array of string = nil;
  begin
    AssignFile(F, inputfile);
    Reset(F);
    while not EOF(F) do
    begin
      ReadLn(F, line);
      if line.IsEmpty then continue
      else if line.Contains('=>') then
      begin
        fields := line.split(' ');
        rule.a := fields[0];
        rule.b := fields[2];
        SetLength(rules, length(rules) + 1);
        rules[high(rules)] := rule;
      end
      else
        molecule := line;
    end;
  end;

  function generate(str, old, new: string): TStringList;
  var
    idx, len:   integer;
    head, tail: string;
  begin
    result := TStringList.Create;
    len    := old.length;
    idx    := str.IndexOf(old, 0);
    while idx >= 0 do  // -1 if no match
    begin
      head := copy(str, 0, idx);
      tail := copy(str, succ(idx) + len);
      result.add(str.join('', [head, new, tail])); // str is not included in the join
      idx  := str.IndexOf(old, succ(idx));
    end;
  end;

  function StringCount(str: string; val: string): integer;
  var
    idx: integer;
  begin
    result := 0;
    idx    := str.IndexOf(val, 0);
    while idx >= 0 do
    begin
      Inc(result);
      idx := str.IndexOf(val, succ(idx));
    end;
  end;

/// main

var
  molecule: string;
  rules:    TRules;
  rule:     TRule;
  acc:      TStringList;
  gen:      string;
  ch:       char;
  ctr, p2:  integer;

begin
  GetInput(molecule, rules);
  acc := TStringList.Create;
  acc.sorted := True; // must sort or the duplicates setting is ignored
  acc.duplicates := dupIgnore;
  for rule in rules do
    for gen in generate(molecule, rule.a, rule.b) do
      acc.add(gen);
  WriteLn('Part 1: ', acc.Count);

  // https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4etju/
  ctr := 0;
  for ch in molecule do
    if ch in ['A'..'Z'] then Inc(ctr);
  p2 := ctr - 1 -
    StringCount(molecule, 'Rn') -
    StringCount(molecule, 'Ar') -
    StringCount(molecule, 'Y') * 2;
  WriteLn('Part 2: ', p2);
end.
