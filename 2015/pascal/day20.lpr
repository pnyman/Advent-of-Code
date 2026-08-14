program day20;
{$mode ObjFPC}{$H+}

uses
  SysUtils;

type
  TIntArray = array[1..1000000] of integer;

  procedure part1(var houses: TIntArray);
  var
    elf, house: integer;
  begin
    for elf := low(houses) to high(houses) do
    begin
      house := elf;
      while house <= high(houses) do
      begin
        Inc(houses[house], elf * 10);
        Inc(house, elf);
      end;
    end;
  end;

  procedure part2(var houses: TIntArray);
  var
    elves:      TIntArray;
    elf, house: integer;
  begin
    elves   := default(TIntArray);
    for elf := low(houses) to high(houses) do
    begin
      house := elf;
      while house <= high(houses) do
      begin
        if elves[elf] < 50 then
        begin
          Inc(houses[house], elf * 11);
          Inc(elves[elf]);
        end;
        Inc(house, elf);
      end;
    end;
  end;

  function solve(const houses: TIntArray; target: integer): integer;
  var
    house: integer;
  begin
    for house := low(houses) to high(houses) do
      if houses[house] >= target then
      begin
        exit(house);
      end;
  end;

/// main

var
  houses: TIntArray;
  target: integer = 34000000;

begin
  houses := default(TIntArray);
  part1(houses);
  WriteLn('Part 1: ', solve(houses, target));

  houses := default(TIntArray);
  part2(houses);
  WriteLn('Part 2: ', solve(houses, target));
end.
