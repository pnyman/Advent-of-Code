program day02;
{$mode ObjFPC}{$H+}
uses
  SysUtils,
  Math;

const
  input = '../input/day-23.txt';

type
  TInstr = record
    instr:  string;
    reg:    string;
    offset: integer;
  end;
  TInstrArr = array of TInstr;

  procedure ParseInput(const line: string; var arr: TInstrArr);
  var
    fields: array of string;
    instr:  TInstr;
  begin
    fields      := line.replace(',', '').split(' ');
    instr       := default(TInstr);
    instr.instr := fields[0];

    if length(fields) > 2 then
    begin
      instr.reg := fields[1];
      if fields[2].contains('-') then
        instr.offset := fields[2].replace('-', '').ToInteger * -1
      else
        instr.offset := fields[2].replace('+', '').ToInteger;
    end
    else if fields[1].contains('-') then
      instr.offset := fields[1].replace('-', '').ToInteger * -1
    else if fields[1].contains('+') then
      instr.offset := fields[1].replace('+', '').ToInteger
    else
      instr.reg    := fields[1];

    SetLength(arr, length(arr) + 1);
    arr[high(arr)] := instr;
  end;

  procedure Execute(const arr: TInstrArr; var a, b: integer);
  var
    instr: TInstr;
    head:  integer = 0;
    len:   integer;
  begin
    len := length(arr);

    while head < len do
    begin
      instr := arr[head];
      case instr.instr of
        'hlf':
        begin
          if instr.reg = 'a' then
            a := a div 2
          else
            b := b div 2;
          Inc(head);
        end;
        'tpl':
        begin
          if instr.reg = 'a' then
            a := a * 3
          else
            b := b * 3;
          Inc(head);
        end;
        'inc':
        begin
          if instr.reg = 'a' then Inc(a)
          else
            Inc(b);
          Inc(head);
        end;
        'jmp':
          Inc(head, instr.offset);
        'jie':
        begin
          if (instr.reg = 'a') and (a mod 2 = 0) then
            Inc(head, instr.offset)
          else if (instr.reg = 'b') and (b mod 2 = 0) then
            Inc(head, instr.offset)
          else
            Inc(head);
        end;
        'jio':
        begin
          if (instr.reg = 'a') and (a = 1) then
            Inc(head, instr.offset)
          else if (instr.reg = 'b') and (b = 1) then
            Inc(head, instr.offset)
          else
            Inc(head);
        end;
      end;
    end;
  end;

var
  F:    TextFile;
  data: TInstrArr;
  line: string;
  a, b: integer;

begin
  data := nil;

  AssignFile(F, input);
  Reset(F);
  while not EOF(F) do
  begin
    ReadLn(F, line);
    ParseInput(line, data);
  end;
  Close(F);

  a := 0;
  b := 0;
  Execute(data, a, b);
  WriteLn('Part 1: ', b);

  a := 1;
  b := 0;
  Execute(data, a, b);
  WriteLn('Part 2: ', b);
end.
