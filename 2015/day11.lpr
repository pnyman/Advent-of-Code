program day11;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  Math,
  Generics.Collections;

type
  TIntArray    = array of integer;
  TIntBoolDict = specialize TDictionary<integer, boolean>;

  function StringToIntegerArray(input: string): TIntArray;
  var
    c: char;
  begin
    result := nil;
    for c in input do
    begin
      SetLength(result, length(result) + 1);
      result[high(result)] := Ord(c);
    end;
  end;

  function IntegerArrayToString(PwArr: TIntArray): string;
  var
    n: integer;
  begin
    result := '';
    for n in PwArr do result += char(n);
  end;

  function RotatePassword(PwArr: TIntArray): TIntArray;
  var
    len, c, n: integer;
    foo: uint64;
  begin
    result := nil;
    len := length(PwArr);
    n   := len - 1;
    foo := 0;

    for c in PwArr do
    begin
      Inc(foo, (c - 97) * (26 ** n));
      Dec(n);
    end;

    Inc(foo);

    for n := 1 to len do
    begin
      SetLength(result, length(result) + 1);
      result[high(result)] := (foo mod 26) + 97;
      foo := foo div 26;
    end;
  end;

  function Rule1(PwArr: TIntArray): boolean;
  var
    i: integer;
  begin
    result := False;
    for i := 0 to high(PwArr) - 2 do
      if ((PwArr[i] + 2) = (PwArr[i + 1] + 1)) and
        ((PwArr[i] + 2) = PwArr[i + 2]) then
        exit(True);
  end;

  function Rule2(PwArr: TIntArray): boolean;
  var
    n: integer;
  begin
    result := True;
    for n in PwArr do
      if (n = 105) or (n = 108) or (n = 111) then
        exit(False);
  end;

  function Rule3(PwArr: TIntArray): boolean;
  var
    dict: TIntBoolDict;
    i:    integer;
  begin
    Result := False;
    dict   := TIntBoolDict.Create;
    try
      for i := low(PwArr) to high(PwArr) - 1 do
      begin
        if PwArr[i] = PwArr[i + 1] then
          dict.AddOrSetValue(PwArr[i], True);
        if dict.Count = 2 then
          exit(True);
      end;
    finally
      dict.Free;
    end;
  end;

  function CreateNewPassword(pw: string): string;
  var
    PwArr: TIntArray;
  begin
    PwArr := StringToIntegerArray(pw);
    repeat
      PwArr := RotatePassword(PwArr);
    until
      Rule1(PwArr) and Rule2(PwArr) and Rule3(PwArr);
    result := IntegerArrayToString(PwArr);
  end;

var
  input: string = 'vzbxkghb';
  pw:    string;

begin
  pw := CreateNewPassword(input);
  WriteLn('Part 1: ', pw);
  pw := CreateNewPassword(pw);
  WriteLn('Part 2: ', pw);
end.
