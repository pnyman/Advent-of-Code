program day07;
{$mode ObjFPC}{$H+}
uses
  SysUtils,
  RegExpr;

const
  input = '../input/day-07.txt';

  function HasABBA(parts: TStringArray): boolean;
  var
    outside: boolean;
    inside:  boolean;
    re:      TRegExpr;
    i:       integer;
  begin
    outside := False;
    inside  := False;
    re      := TRegExpr.Create('(.)(.)(\2)(\1)');
    for i := low(parts) to high(parts) do
    begin
      if re.exec(parts[i]) and (re.match[1] <> re.match[2]) then
        if odd(i) then
          inside  := True
        else
          outside := True;
    end;
    result := outside and not inside;
    re.Free;
  end;

  function ExtractABAs(const s: string): TStringArray;
  var
    i: integer;
  begin
    Result := nil;
    for i  := 1 to Length(s) - 2 do
      if (s[i] = s[i + 2]) and (s[i] <> s[i + 1]) then
      begin
        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := s[i] + s[i + 1] + s[i];
      end;
  end;

  function SupportsSSL(const parts: Tstringarray): boolean;
  var
    i, j:     integer;
    abas:     TStringArray;
    aba, bab: string;
  begin
    Result := False;
    for i  := 0 to High(parts) do
    begin
      if Odd(i) then Continue;          // bara supernet-delar i yttre loopen
      abas := ExtractABAs(parts[i]);
      for aba in abas do
      begin
        bab   := aba[2] + aba[1] + aba[2];  // t.ex. 'aba' -> 'bab'
        for j := 0 to High(parts) do
          if Odd(j) and parts[j].Contains(bab) then
            Exit(True);
      end;
    end;
  end;

/// main

var
  F:      TextFile;
  line:   string;
  parts:  TStringArray;
  p1, p2: integer;

begin
  Assign(F, input);
  Reset(F);
  p1 := 0;
  p2 := 0;

  while not EOF(F) do
  begin
    ReadLn(F, line);
    parts := line.Split(['[', ']']);
    if HasABBA(parts) then Inc(p1);
    if SupportsSSL(parts) then Inc(p2);
  end;

  WriteLn('Part 1: ', p1);
  WriteLn('Part 2: ', p2);
end.
