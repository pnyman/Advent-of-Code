program day21;
{$mode ObjFPC}{$H+}
{$WARN 6058 OFF}

uses
  SysUtils,
  StrUtils,
  Classes;

type
  TGear = array of array of integer;

const
  inputfile      = '../input/day-21.txt';

  weapons: TGear =
    ((4, 8), (5, 10), (6, 25), (7, 40), (8, 74));
  armor: TGear   =
    ((1, 13), (2, 31), (3, 53), (4, 75), (5, 102));
  rings: TGear   =
    ((1, 25), (2, 50), (3, 100), (-1, 20), (-2, 40), (-3, 80));


  function RingChoices: TGear;
  begin
    result := nil;
  end;


/// main




begin

end.
