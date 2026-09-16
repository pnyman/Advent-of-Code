program day05;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  StrUtils,
  MD5;

const
  input = 'ugkcyxxp';
  // input = 'abc';

  function MakeChecksum(str: string; num: integer): string;
  var
    md5: TMDDigest;
    n:   integer;
  begin
    result := '';
    md5    := MD5String(format('%s%d', [str, num]));
    for n in md5 do
      result += format('%0.2x', [n]);
    result   := LowerCase(result);
  end;

  function Part1: string;
  var
    n: integer = -1;
    m: integer;
    h: string;
  begin
    result := '';
    for m  := 1 to 8 do
    begin
      repeat
        begin
          Inc(n);
          h := MakeChecksum(input, n);
        end;
      until
        StartsStr('00000', h);
      result += char(h[6]);
    end;
  end;

/// main

begin
  WriteLn('Part 1: ', Part1);
end.
