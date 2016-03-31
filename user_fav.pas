unit user_fav;

//TODO:module user_fav was cleared


{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils,
dbf, sqlite3conn, sqldb, // database units
FileUtil, Forms, Controls,
Graphics, Dialogs, DbCtrls, Menus, ExtCtrls,
clipbrd, Grids, str_common_funcs;

procedure add_fav(category : String; caption : String; Labels : String; Hash : String; var lbFav : TStringGrid);
procedure load_fav(var lbFav : TStringGrid);
procedure remove_fav(var lbFav : TStringGrid);
procedure favClearAll(var lbFav : TStringGrid);
procedure save_fav(var lbFav : TStringGrid);
procedure InsertRow(var sg : TStringGrid;  s: TStringList);
procedure SaveGrid(var sg : TStringGrid);

implementation

procedure InsertRow(var sg : TStringGrid;  s: TStringList);
begin
  Sg.RowCount:=Sg.RowCount+1;
  Sg.Rows[Sg.RowCount-1]:=s;
end;



procedure add_fav(category : String; caption : String; Labels : String; Hash : String; var lbFav : TStringGrid);
var found : boolean; i : Integer; str : String;
  records : TStringList;
begin
  found := false;
  str := category+'~'+caption+'~'+labels+'~'+hash;
  for i:=0 to lbFav.RowCount-1 do
     if lbFav.Cells[2, i] = hash then
          begin
              found := true;
              break;
          end;
  if not found then
         begin
         records:=TStringList.create;
         split('~', str, records);
         InsertRow(lbFav, records);
         records.Free;
         end;

end;


procedure favClearAll(var lbFav : TStringGrid);
begin
  lbFav.Clear;
  lbFav.RowCount:=1;
  SaveGrid(lbFav);
end;

procedure save_fav(var lbFav : TStringGrid);
begin
  SaveGrid(lbFav);
end;



procedure SaveGrid(var sg: TStringGrid);
var
  f : TextFile;
  str : String;
  i : Integer;
begin

         AssignFile(f, 'fav.txt');
         Rewrite(f);
         for i:=0 to sg.RowCount-1 do
            begin
                 str:=sg.Cells[0, i]+'~'+sg.Cells[1, i]+'~'+sg.Cells[2, i]+'~'+sg.Cells[3, i];
                 WriteLn(f, str);
            end;
         closefile(f);

end;

procedure load_fav(var lbFav: TStringGrid);
var l : TStringList; i : integer;
  records : TStringList;
begin
   if fileExists('fav.txt') then
     begin
          lbFav.Clear;
          l:=tstringlist.create();
          l.LoadFromFile('fav.txt');
          for i:=0 to l.Count-1 do
             begin
               records:=tstringlist.create;
               split('~', l.Strings[i], records);
               //showmessage(IntToStr(records.Count));
               //showmessage('insert '+IntToStr(i));
               insertrow(lbFav, records);
               records.free;
             end;


          l.free;
     end;
end;

procedure remove_fav(var lbFav : TStringGrid);
begin
  lbFav.DeleteRow(lbFav.Row);
  saveGrid(lbFav);
end;


end.

