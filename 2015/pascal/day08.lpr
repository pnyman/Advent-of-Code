program day08;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  RegExpr;

const
  input = 'input/day-08.txt';

  function occurs(const line, pat: string): integer;
  var
    re: TRegExpr;
    content: string;
  begin
    Result := 0;
    content := Copy(line, 2, line.length - 2);  // without enclosing quotes
    re := TRegExpr.Create(pat);
    try
      if re.Exec(content) then
        repeat
          Inc(Result);
        until not re.ExecNext;
    finally
      re.Free;
    end;
  end;

var
  F:    TextFile;
  line: string;
  literal: integer = 0;
  memory: integer = 0;
  encoded: integer = 0;
  amount: integer = 0;

begin
  AssignFile(F, input);
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, line);

    Inc(literal, line.length);
    Inc(memory, line.length - 2);
    Inc(encoded, line.length + 4);

    amount := occurs(line, '\\\\');
    Dec(memory, amount);
    Inc(encoded, amount * 2);

    amount := occurs(line, '\\"');
    Dec(memory, amount);
    Inc(encoded, amount * 2);

    amount := occurs(line, '(?i)\\x[0-9a-f]{2}');
    Dec(memory, amount * 3);
    Inc(encoded, amount);
  end;

  WriteLn('Part 1: ', literal - memory);
  WriteLn('Part 2: ', encoded - literal);

end.
