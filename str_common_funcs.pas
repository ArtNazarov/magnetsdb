unit str_common_funcs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function getHashFromFavStr(Str : String) : String;
function replace_html_quotes(Str : String) : String;
function Strip_Braces(Str : String; o, c : Char) : String;
function Look_In_Braces(Str : String; o, c : Char) : String;
function getCaption(Str : String) : String;
function getLabels(Str : String) : String;
function trimstr(Str : String) : String;
procedure Split(Delimiter: Char; Str: string; var ListOfStrings: TStringList) ;


implementation

function getHashFromFavStr(Str : String) : String;
var i : Integer; hash : String;
begin
  hash := '';
  i:=Length(Str);
  while i>0 do
        begin
             if Str[i] = '~' then break;
             hash := Str[i] + hash;
             Dec(i);
        end;
  Result:=hash;
end;

// automat
function Strip_Braces(Str : String; o, c : Char) : String;
var temp_str : String; k : integer; add : boolean;
begin
 temp_str:='';
 k:=1;
 add:=true;
 while k<=Length(Str) do
       begin
            if str[k] = o then
               add:=false;
            if str[k] = c then
               begin add:=true; temp_str:=temp_str+' '; end;
            if (not ( str[k] in [o, c]) ) and add then
               temp_str:=temp_str+str[k];
            inc(k);
       end;

  result:=temp_str;
end;

function Look_In_Braces(Str : String; o, c : Char) : String;
var temp_str : String; k : integer; add : boolean;
begin
 temp_str:='';
 k:=1;
 add:=false;
 while k<=Length(Str) do
       begin
            if str[k] = o then
               add:=true;
            if str[k] = c then
               begin add:=false; temp_str:=temp_str+' '; end;
            if (not ( str[k] in [o, c]) ) and add then
               temp_str:=temp_str + Str[k];
            inc(k);
       end;
  result:=temp_str;
end;


function replace_html_quotes(Str : String) : String;
var
   html_spec : array[byte, 0..1] of String;
   k  : integer;
   temp_str : String;
begin
   temp_str := Str;

   html_spec[0, 0]:='quot';
   html_spec[0, 1]:='''';

   html_spec[1, 0]:='gt';
   html_spec[1, 1]:='>';

   html_spec[2, 0]:='lt';
   html_spec[2, 1]:='<';

   html_spec[3, 0]:='amp';
   html_spec[3, 1]:='&';


   html_spec[4, 0]:= '&lsquo;';
   html_spec[4, 1]:= '‘';
   html_spec[5,0]:='rsquo';
   html_spec[5,1]:='’';
   html_spec[6,0]:='sbquo';
   html_spec[6,1]:='‚';
   html_spec[7,0]:='ldquo';
   html_spec[7,1]:='“';
   html_spec[8,0]:='rdquo';
   html_spec[8,1]:='”';
   html_spec[9,0]:='bdquo';
   html_spec[9,1]:='„';
   html_spec[10,0]:='dagger';
   html_spec[10,1]:='†';
   html_spec[11,0]:='Dagger';
   html_spec[11,1]:='‡';
   html_spec[12,0]:='permil';
   html_spec[12,1]:='‰';
   html_spec[13,0]:='lsaquo';
   html_spec[13,1]:='‹';
   html_spec[14,0]:='divide';
   html_spec[14,1]:='÷';
   html_spec[15,0]:='rsaquo';
   html_spec[15,1]:='›';
   html_spec[16,0]:='spades';
   html_spec[16,1]:='♠';
   html_spec[17,0]:='clubs';
   html_spec[17,1]:='♣';
   html_spec[18,0]:='hearts';
   html_spec[18,1]:='♥';
   html_spec[19,0]:='diams';
   html_spec[20,1]:='♦';
   html_spec[21,0]:='oline';
   html_spec[21,1]:='‾';
   html_spec[22,0]:='larr';
   html_spec[22,1]:='←';
   html_spec[23,0]:='uarr';
   html_spec[23,1]:='↑';
   html_spec[24,0]:='rarr';
   html_spec[24,1]:='→';
   html_spec[25,0]:='darr';
   html_spec[25,1]:='↓';
   html_spec[26,0]:='trade';
   html_spec[26,1]:='™';
   html_spec[27,0]:='#00';
   html_spec[27,1]:='-';
   html_spec[28,0]:='#32';
   html_spec[28,1]:=' ';
   html_spec[29,0]:='#33';
   html_spec[29,1]:='!';
   html_spec[30,0]:='quot';
   html_spec[30,1]:='"';
   html_spec[31,0]:='frasl';
   html_spec[31,1]:='/';
   html_spec[32,0]:='hellip';
   html_spec[32,1]:='…';
html_spec[33,0]:='ndash';
html_spec[33,1]:='–';
html_spec[34,0]:='mdash';
html_spec[34,1]:='—';
html_spec[35,0]:='nbsp';
html_spec[35,1]:=' ';
html_spec[36,0]:='sect';
html_spec[36,1]:='§';
html_spec[37,0]:='copy';
html_spec[37,1]:='©';
html_spec[38,0]:='laquo';
html_spec[38,1]:='«';
html_spec[39,0]:='reg';
html_spec[39,1]:='®';
html_spec[40,0]:='deg';
html_spec[40,1]:='°';
html_spec[41,0]:='plusmn';
html_spec[41,1]:='±';
html_spec[42,0]:='middot';
html_spec[42,1]:='·';
html_spec[43,0]:='raquo';
html_spec[43,1]:='»';
html_spec[44,0]:='#9679';
html_spec[44,1]:='●';
html_spec[45,0]:='#8226';
html_spec[45,1]:='•';
   for k:=0 to 45 do
          temp_str:= StringReplace(temp_str, '&'+html_spec[k,0]+';' , html_spec[k, 1], [rfReplaceAll, rfIgnoreCase]);

   result:=temp_str;
end;

function getCaption(Str : String) : String;
begin
   Result:=replace_html_quotes(Strip_Braces(Strip_Braces(Str, '(', ')'), '[', ']'));
end;

function getLabels(Str : String) : String;
begin
      Result:=replace_html_quotes(Look_in_Braces(Str, '[', ']')+' '+Look_in_Braces(Str, '(', ')'));
end;

function trimstr(Str : String) : String;
begin
  Result := Trim(Str);
end;

procedure Split(Delimiter: Char; Str: string; var ListOfStrings: TStringList) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;


end.

