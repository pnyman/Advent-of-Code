program day04;
{$mode ObjFPC}{$H+}
uses
  SysUtils,
  RegExpr;

const
  input = '../input/day-04.txt';

  function IsRealRoom(const Name, checksum: string): boolean;
  var
    freq:    array['a'..'z'] of integer;
    letters: array of char;
    c, tmp:  char;
    i, j:    integer;
  begin
    letters := nil;
    FillChar(freq, SizeOf(freq), 0);
    for c in Name do
      if c in ['a'..'z'] then Inc(freq[c]);

    for c := 'a' to 'z' do
      if freq[c] > 0 then
      begin
        SetLength(letters, Length(letters) + 1);
        letters[High(letters)] := c;
      end;

    for i := 1 to High(letters) do // small insertion sort, max 26 elements
    begin
      j := i;
      while (j > 0) and
        ((freq[letters[j]] > freq[letters[j - 1]]) or
          ((freq[letters[j]] = freq[letters[j - 1]]) and
          (letters[j] < letters[j - 1]))) do
      begin
        tmp := letters[j];
        letters[j] := letters[j - 1];
        letters[j - 1] := tmp;
        Dec(j);
      end;
    end;

    result := True;
    for i  := 0 to 4 do
      if (i > High(letters)) or (letters[i] <> checksum[i + 1]) then
        Exit(False);
  end;

  function Rotate(const Text: string; const key: integer): string;
  var
    c: char;
  begin
    result := '';
    for c in Text do
      if c in ['a'..'z'] then
        result += char((Ord(c) - Ord('a') + key mod 26) mod 26 + Ord('a'))
      else
        result += c;
  end;

  procedure Solve(var sum, roomId: integer);
  var
    F:    TextFile;
    line: string;
    id:   integer;
    re:   TRegExpr;
  begin
    AssignFile(F, input);
    Reset(F);
    re := TRegExpr.Create('^(.*)-(\d+)\[(.*)\]$');
    try
      while not EOF(F) do
      begin
        ReadLn(F, line);
        if not re.Exec(line) then Continue;
        if IsRealRoom(re.Match[1], re.Match[3]) then
        begin
          id := StrToInt(re.Match[2]);
          Inc(sum, id);
          if rotate(line, id).contains('north') then
            roomId := id;
        end;
      end;
    finally
      re.Free;
      Close(F);
    end;
  end;

/// main

var
  sum, id: integer;

begin
  sum := 0;
  Solve(sum, id);
  WriteLn('Part 1: ', sum);
  WriteLn('Part 2: ', id);
end.
