program day04;
{$mode ObjFPC}{$H+}

uses
  SysUtils,
  MD5;

const
  input = 'ckczppom';

var
  n: integer = -1;
  h: TMDDigest;

begin
  repeat
    begin
      Inc(n);
      h := MD5String(format('%s%d', [input, n]));
    end;
  until
    (h[0] = 0) and (h[1] = 0) and (h[2] < 16);
  WriteLn('Part 1:  ', n);

  repeat
    begin
      Inc(n);
      h := MD5String(format('%s%d', [input, n]));
    end;
  until
    (h[0] = 0) and (h[1] = 0) and (h[2] = 0);
  WriteLn('Part 2: ', n);
end.
