unit labels_helper;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils,
  dbf, sqlite3conn, sqldb, // database units
  FileUtil, Forms, Controls,
  Graphics, Dialogs, DbCtrls,  Menus, ExtCtrls,
 clipbrd,  str_common_funcs,  magnets_constants, db_manager;

type

  { LabelsManager }

  LabelsManager = class(tdb_manager)
     public
       var labels_list   : TStringList;
       procedure init_labels_list();
       procedure loadLabels(category : String);
       procedure free_labels_list();
end;

implementation


{ LabelsManager }

procedure LabelsManager.init_labels_list;
begin
  labels_list:=TStringList.create();
end;

procedure LabelsManager.loadLabels(category: String);
var s : String; temp : TStringList; i : integer; h : TStringList;
begin
//init_labels_list();
make_db_objects();
link_it();

query.Close;
query.SQL.Clear;
query.SQL.Add('SELECT labels FROM ' + table + ' WHERE category="'+category+'"');
(*
h:=TStringLIst.Create();
h.Add(Query.SQL.text);
h.SaveToFile('label-sql.txt');
h.free;
*)
query.ExecSQL;
query.Open;
dsSQL.DataSet.First;
while not dsSQL.DataSet.EOF do
begin
  s:=dsSQL.DataSet.FieldByName('labels').AsString;
  temp:=TStringList.Create;
  Split(' ', s, temp);
  for i:=0 to temp.Count-1 do
      begin
           if labels_list.IndexOf(temp[i])=-1 then
              begin
                 labels_list.Add(temp[i]);
              end;
      end;
  temp.free;
  dsSQL.DataSet.Next;
end;

query.Close;


free_it();

end;

procedure LabelsManager.free_labels_list;
begin
  labels_list.Free();
end;


end.

