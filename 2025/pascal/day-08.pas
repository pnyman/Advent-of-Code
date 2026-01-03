Program day_08;
{$mode objfpc}{$H+}{$J-}{$R+}{$M+}

Uses
SysUtils, StrUtils, Math, Types;

const
   INPUT = '../input/day-08-test.txt';

type
   TPoint3D = array[0 ..2] of String;

   TDistance = Record
      a, b: TPoint3D;
      d: Int64;
   end;

   PDistance = ^TDistance;
   TDistPtrArray = array of PDistance;
   TPointArray   = array of TPoint3D;


procedure DistanceDump(D: PDistance);
begin
   WriteLn(Format('(%s, %s, %s), (%s, %s, %s) => %d',
           [D^.a[0], D^.a[1], D^.a[2],
           D^.b[0], D^.b[1], D^.b[2],
           D^.d]));
end;

function GetInput: TPointArray;
var
   tfIn: textFile;
   s: String;
   parts: TStringDynArray;
   A: TPointArray;
   P: TPoint3D;
   n: Integer;
begin
   AssignFile(tfIn, INPUT);
   reset(tfIn);
   n := 0;
   SetLength(A, 0);

   while not eof(tfIn) do
      begin
         readln(tfIn, s);
         parts := SplitString(s, ',');
         P[0] := parts[0];
         P[1] := parts[1];
         P[2] := parts[2];
         SetLength(A, n + 1);
         A[n] := P;
         Inc(n);
      end;

   CloseFile(tfIn);
   result := A;
end;


function Distance(Const p1, p2: TPoint3D): Int64;
var
   dx, dy, dz: Integer;
begin
   dx := StrToInt(p1[0]) - StrToInt(p2[0]);
   dy := StrToInt(p1[1]) - StrToInt(p2[1]);
   dz := StrToInt(p1[2]) - StrToInt(p2[2]);
   result := dx * dx + dy * dy + dz * dz;
end;

procedure QuickSortPtr(Var edges: TDistPtrArray; L, R: Integer);
var
   i, j : Integer;
   pivot, tmp : PDistance;
begin
   if L >= R then Exit;
   pivot := edges[(L + R) Div 2];
   i := L;
   j := R;

   Repeat
      while edges[i]^.d < pivot^.d do
         Inc(i);
      while edges[j]^.d > pivot^.d do
         Dec(j);
      if i <= j then
         begin
            tmp := edges[i];
            edges[i] := edges[j];
            edges[j] := tmp;
            Inc(i);
            Dec(j);
         end;
   Until i > j;

   if L < j then QuickSortPtr(edges, L, j);
   if i < R then QuickSortPtr(edges, i, R);
end;

function MakeEdges(Const nodes: TPointArray): TDistPtrArray;
var
   i, j, k: Integer;
   e: PDistance;
   n, cnt: Integer;
begin
   n := Length(nodes);
   cnt := n * (n - 1) Div 2;
   result := Nil;
   SetLength(result, cnt);
   k := 0;

   for i := 0 to n - 2 do
      for j := i + 1 to n - 1 do
         begin
            New(e);
            e^.a := nodes[i];
            e^.b := nodes[j];
            e^.d := Distance(nodes[i], nodes[j]);
            result[k] := e;
            Inc(k);
         end;

   QuickSortPtr(result, 0, High(result));
end;

var
   Dists: TDistPtrArray;
   D: PDistance;
begin
   Dists := MakeEdges(GetInput);
   for D in Dists do
      DistanceDump(D);
end.
