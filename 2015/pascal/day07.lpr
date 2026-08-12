program day07;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Generics.Collections;

const
  input = 'input/day-07.txt';

type
  TInstr = record
    arg1: string;
    op:   string;
    arg2: string;
    wire: string;
  end;

  TStrStrDict   = specialize TDictionary<string, string>;
  TStrInstrDict = specialize TDictionary<string, TInstr>;

var
  circuit:  TStrInstrDict;
  resolved: TStrStrDict;

  function ParseLine(const line: string): TInstr;
  var
    parts: TStringArray;
    lhs:   TStringArray;
  begin
    parts := line.Split([' -> ']);
    lhs   := parts[0].Split([' ']);

    Result := default(TInstr);
    Result.wire := parts[1];

    case Length(lhs) of
      1:
      begin
        Result.arg1 := lhs[0];
        Result.op   := 'ASSIGN';
      end;
      2:
      begin
        Result.op   := 'NOT';
        Result.arg2 := lhs[1];
      end;
      3:
      begin
        Result.arg1 := lhs[0];
        Result.op   := lhs[1];
        Result.arg2 := lhs[2];
      end;
      else
        raise Exception.CreateFmt('Cannot parse: %s', [line]);
    end;
  end;

  function IsNumeric(const x: string): boolean;
  var
    c: char;
  begin
    for c in x do
      if not (c in ['0'..'9']) then
        exit(False);
    Result := True;
  end;

  function ApplyOp(const op: string; const arg1, arg2: string): string;
  var
    a, b, val: integer;
  begin
    a := StrToInt(arg1);
    b := StrToInt(arg2);
    case op of
      'AND': val    := a and b;
      'OR': val     := a or b;
      'LSHIFT': val := a shl b;
      'RSHIFT': val := a shr b;
      else
        raise Exception.CreateFmt('Unknown operator: %s', [op]);
    end;
    Result := IntToStr(val);
  end;

  function resolve(const val: string): string;
  var
    instr: TInstr;
  begin
    if IsNumeric(val) then
      exit(val);

    if resolved.ContainsKey(val) then
      exit(resolved[val]);

    instr := circuit[val];
    if instr.op.equals('NOT') then
      Result := IntToStr(not StrToInt(resolve(instr.arg2)))
    else if instr.op.equals('ASSIGN') then
      Result := resolve(instr.arg1)
    else
      Result := ApplyOp(instr.op, resolve(instr.arg1), resolve(instr.arg2));

    resolved.AddOrSetValue(val, Result);
  end;

var
  F:     Text;
  line:  string;
  instr: TInstr;
  signal: string;

begin
  circuit  := TStrInstrDict.Create;
  resolved := TStrStrDict.Create;
  AssignFile(F, input);
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, line);
    instr := ParseLine(line);
    circuit.AddOrSetValue(instr.wire, instr);
  end;

  signal := resolve('a');
  WriteLn('Part 1: ', signal);

  circuit.Clear;
  resolved.Clear;
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, line);
    if line.EndsWith('-> b') then
      line := format('%s -> b', [signal]);
    instr  := ParseLine(line);
    circuit.AddOrSetValue(instr.wire, instr);
  end;

  signal := resolve('a');
  WriteLn('Part 2:  ', signal);
end.
