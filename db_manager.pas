unit db_manager;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
   db, dbf, sqlite3conn, sqldb, // database units
  FileUtil, Forms, Controls,
  Graphics, Dialogs, DbCtrls,  Menus, ExtCtrls,
 clipbrd,   magnets_constants;


type

  { tdb_manager }

  tdb_manager = class

    public
          var filename : String;            // filename of the database
          var table : String;               // table in the database
          var conn: TSQLite3Connection;
          var dsSQL: TDataSource;
          var query: TSQLQuery;
          var trSQL: TSQLTransaction;
          var sorting_order : String;       // sorting order
          var sqlText : String;             // request
          var page   : Integer;             // current page
          var mode   : Integer;             // current mode
          var search_field : String;        // current field for search
          var sorting_field : String;
          var sorting       : boolean;
          var where_value : String;
          function sqlSort() : String;      // returns ASC or DESC
          procedure make_db_objects();      // createss conn etc
         // Создание новой базы
          procedure init_db(); virtual;
          // Связывание объектов друг с другом
          procedure link_it();
          // Деструкторы
          procedure free_it();
          // Подключение к базе
          procedure  connect();
          // Отправка запроса к базе
          procedure send_request();
          procedure disconnect();
  end;

implementation



{ tdb_manager }

function tdb_manager.sqlSort: String;
var str : String;
begin
  Str:='ASC';
  if sorting then Str:='DESC';
  Result:=Str;
end;

procedure tdb_manager.make_db_objects;
begin
 conn:=NIL;
trSQL:=NIL;
dsSQL:=NIL;
query:=NIL;
conn:=TSQLite3Connection.Create(Nil);
trSQL:=TSQLTransaction.Create(nil);
query:=TSQLQuery.Create(nil);
dsSQL:=TDataSource.Create(nil);
end;

procedure tdb_manager.link_it;
begin
  if filename='' then filename:=db_name;
 conn.DatabaseName:=filename;
 conn.Transaction:=trSQL;
 trSQL.Database:=conn;
 query.Database:=conn;
 query.Transaction:=trSQL;
 dsSQL.dataset:=query;
end;

procedure tdb_manager.free_it;
begin
  query.Free;
 trSQL.Free;
 dsSQL.Free;
 conn.Free;
 query:=NIL;
 trSQL:=NIL;
 dsSQL:=NIL;
 conn:=NIL;
end;

procedure tdb_manager.connect;
begin
 if conn=NIL then make_db_objects();
 link_it();
end;

procedure tdb_manager.init_db;
begin

end;

procedure tdb_manager.send_request;
begin
  if conn <> NIL then conn.Close;
 conn.Open;
 trSQL.Active := true;
 query.SQL.Clear;
 query.SQL.add(sqlText);
 if (Pos('DELETE ', query.SQL.text)>0) or
    (Pos('UPDATE ', query.SQL.text)>0) or
    (Pos('INSERT ', query.SQL.text)>0) then
      begin
     conn.ExecuteDirect(sqlText);
     trSQL.commit;
      end
 else if sqlText<> '' then
     begin
      query.ExecSQL;
      trSQL.Commit;
      query.Open();
     end;
end;

procedure tdb_manager.disconnect;
begin
   query.close();
   trSQL.Active:=false;
   dsSQL.Enabled:=false;
   conn.Connected:=false;
end;

end.

