Program day_06;

{$mode objfpc}{$H+}{$J-}{$R+}{$Q+}

Uses SysUtils, StrUtils, Math;

const
   INPUT =   '../input/day-06-input.txt';


type
   TWidthsArray =  Array of Integer;
   TStringArray =  Array of Array of String;


procedure GetInput(Var strArr: TStringArray; Var widthsArr: TWidthsArray);
var
   tfIn :  textFile;
   line :  String;
   s, fmt :  String;
   i, j, w, cursor :  Integer;
   sArr, lineArr :  Array of String;

begin
   AssignFile(tfIn, INPUT);
   SetLength(widthsArr, 0);
   i := 0;

   try
      Reset(tfIn);
      while not eof(tfIn) do
         begin
            ReadLn(tfIn, line);
            SetLength(strArr, i + 1);
            SetLength(lineArr, i + 1);
            lineArr[i] := line;
            j := 0;

            for s in line.split(' ') do
               if Length(s) > 0 then
                  begin
                     SetLength(strArr[i], j + 1);
                     strArr[i][j] := s;
                     Inc(j);
                  end;

            Inc(i);
         end;
      CloseFile(tfIn);

   except
      on E:  EInOutError do WriteLn('IOerror: ', E.Message);
   end;

   w := 0;
   for sArr in strArr do
      begin
         for s in sArr do
            w := Max(w, Length(s));
         SetLength(widthsArr, Length(widthsArr) + 1);
         widthsArr[High(widthsArr)] := w;
      end;

   for i := 0 to High(strArr) do
      begin
         cursor := 1;
         w := widthsArr[i];
         fmt := Concat('%-', IntToStr(w * Succ(Length(strArr[i]))), 's');
         line := Format(fmt, [lineArr[i]]);
         for j := 0 to High(strArr[i]) do
            begin
               strArr[i][j] := Copy(line, cursor, w);
               if w > 1 then
                  Inc(cursor, w + 1)
               else
                  Inc(cursor, w + 3);
            end;
      end;
end;


// main
var
   s :  Array of String;
   t :  String;
   w :  Integer;
   strArr:  TStringArray;
   widthsArr:  TWidthsArray;

begin
   GetInput(strArr, widthsArr);
   { for s in ColumnWidths do }
   {    begin }
   {       for t in s do }
   {          Write(Format('>%s< ', [t])); }
   {       WriteLn; }
   {    end; }

   for w in widthsArr do
      Write(Format('%d ', [w]));
   WriteLn;

   for s in strArr do
      begin
         Write('|');
         for t in s do
            begin
               Write(Format('%s|', [t]));
            end;
         WriteLn;
      end;

end.
