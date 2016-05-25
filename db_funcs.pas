unit db_funcs;


{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils,
   dbf, sqlite3conn, sqldb, // database units
  FileUtil, Forms, Controls,
  Graphics, Dialogs, DbCtrls,  Menus, ExtCtrls,
 clipbrd,  inifiles, magnets_constants, db_manager;


// TODO : Refactor it to db_manager, magnets_entity class

 procedure reindex();



implementation

procedure reindex();
var
 inif : TIniFile;
 x : TStringList;
 db_manager : tdb_manager;
begin
inif:=TIniFile.Create('settings.ini');
if Inif.readstring('general', 'reindex', 'YES')='YES' then
 begin

 db_manager:=Tdb_manager.create;
 db_manager.filename:='main-sqlite.db';
 db_manager.table:='magnets';
 db_manager.make_db_objects();
 db_manager.link_it();
 db_manager.sqlText:='SELECT DISTINCT category FROM data';
 db_manager.send_request();
 db_manager.query.First;
   x:=TStringList.Create();
   while not  db_manager.query.EOF do
    begin
         x.Add( db_manager.query.FieldByName('category').AsString);
         db_manager.query.next;
    end;
   Inif.writestring('general', 'reindex', 'NO');
   x.SaveToFile('categories.txt');
   x.Free;
   db_manager.free_it();
end;
inif.free;
db_manager.free();
end;



end.

