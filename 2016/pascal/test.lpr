program test;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  StrUtils,
  MD5;

const
  // input = 'ugkcyxxp';
  input = 'abc';

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

var
  h: string;

begin
  h := MakeChecksum(input, 5017308);
  WriteLn(h);
end.
