with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Strings.Fixed;

procedure Day_01 is

File_Name: constant String := "../input/day-01-input.txt";

package Int_Vector is
   new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Integer);

function Get_Input return Int_Vector.Vector is
   Arr : Int_Vector.Vector;
   F : File_Type;
   Line : String (1 .. 10);
   Last : Natural;
begin
   Open (F, In_File, File_Name);
   while not End_Of_File (F) loop
      Get_Line (F, Line, Last);

      for I in 1 .. Last loop
         if Line (I) = 'L' then Line (I) := '-'; end if;
         if Line (I) = 'R' then Line (I) := ' '; end if;
      end loop;

      declare
         use Ada.Strings.Fixed;
         S : constant String := Trim (Line (1 .. Last), Ada.Strings.Both);
      begin
         Arr.Append (Integer'Value (S));
      end;
   end loop;

   Close (F);
   return Arr;
end;

function Passes (Start, Step: Integer) return Integer is
   Ending : Integer := Start + Step;
begin
   if Step = 0
   then return 0;
   elsif Step > 0 then
      return Integer (Float'Floor (Float (Ending) / 100.0));
   else
      return Integer (Float'Floor (Float (Start - 1) / 100.0) -
                      Float'Floor (Float (Ending - 1) / 100.0));
   end if;
end;

Arrow : Integer := 50;
Acc, Clicks : Integer := 0;

begin
   for Rot of Get_Input loop
      Clicks := Clicks + Passes (Arrow, Rot);
      Arrow := ((Arrow + Rot) Mod 100 + 100) Mod 100;
      if Arrow = 0 then Acc := Acc + 1; end if;
   end loop;
   Put_Line ("Part 1: " & Acc'Image);
   Put_Line ("Part 2: " & Clicks'Image);
end Day_01;
