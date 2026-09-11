program day05;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  MD5;

const
  // input = 'ugkcyxxp';
  input = 'abc';

var
  n:  integer = -1;
  m:  integer;
  h:  TMDDigest;
  pw: string;

begin
  pw    := '';
  for m := 1 to 8 do
  begin
    repeat
      begin
        Inc(n);
        h := MD5String(format('%s%d', [input, n]));
      end;
    until
      (h[0] = 0) and (h[1] = 0) and (h[2] = 0);
    pw += char(h[5]);
    WriteLn(char(h[5]));
  end;
  WriteLn(pw);
end.
