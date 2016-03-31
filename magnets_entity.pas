unit magnets_entity;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  dbf, sqlite3conn, sqldb, // database units
  FileUtil, Forms, Controls,
  Graphics, Dialogs, DbCtrls,  Menus, ExtCtrls,
 clipbrd,  str_common_funcs,  magnets_constants, db_manager;


type

  { TMagnets_Entity }

  TMagnets_Entity = class(tdb_manager)
    public
    var
       category,                      // fields
       caption,
       labels,
       hash : String;
    var old_category,                 // old values for update
        old_caption,
        old_labels,
        old_hash : String;
   // Поиск в базе
 function search() : String;
 procedure init_db(); override;
 // Вставка
 procedure insert();
 // Обновление
 procedure update();
 // Удаление
 procedure delete();
 // Настройка
 procedure tear();
 // Количество записей
function getCount(count_field, count_value : String) : Integer;
  end;



implementation

{ TMagnets_Entity }

function TMagnets_Entity.search: String;
var
history_sql : TStringList;
 gen : String;
 sqlStr_cat, sqlStr_lab : String;
 limits : String;
 l : TStringList;
 i : Integer;
 last_query : String;
begin
   l:=TStringList.Create;
l.clear;
sqlStr_cat:='';
sqlStr_lab:='';
gen:='';

sorting_order:=sqlSort();

if where_value<>'' then
           case mode of
            0 :
              begin
           gen:=' UPPER('+search_field +') LIKE UPPER("%'+where_value+'%") ';
           end;
            1 :
             begin
           gen:=' ( ( UPPER(TRIM('+search_field  +')) >= UPPER("'+where_value+'") ) AND ( UPPER(TRIM('+search_field +')) <= UPPER("'+where_value+'яяя") ) )';
           end;
            end;


if  category <> '' then sqlStr_cat:=' ( category = "'+category+'" ) ';
if  labels <> '' then
   begin
     if Pos(' ', labels)>0 then
       begin
       Split(' ', labels, l);
       for i:=0 to l.Count-1 do
          if i=0 then
            case mode of
            0 : begin
                sqlStr_lab:= sqlStr_lab + ' ( UPPER(labels) LIKE UPPER("%'+l.Strings[i]+'%") ) '
                end;
            1 : begin
                sqlStr_lab:= sqlStr_lab + ' (  ( UPPER(labels) >= UPPER("'+l.Strings[i]+'") ) AND ( UPPER(labels) <= UPPER("'+l.Strings[i]+'яяя") ) ) ';
                end;
            end
          else
           case mode of
          0 : begin
              sqlStr_lab:= sqlStr_lab + ' AND ( UPPER(labels) LIKE UPPER("%'+l.Strings[i]+'%") ) ';
              end;
          1 : begin
              sqlStr_lab:= sqlStr_lab + ' AND ( ( UPPER(labels) >= UPPER("'+l.Strings[i]+'") ) AND ( UPPER(labels) <= UPPER("'+l.Strings[i]+'яяя") ) ) ';
                  end
           end;
       end else
               case mode of
               0 : begin
                    sqlStr_lab:=' ( UPPER(labels) LIKE UPPER("%'+labels+'%") ) ';
                   end;
               1 : begin
                    sqlStr_lab:=' ( ( UPPER(labels) >= UPPER("'+labels+'") ) AND ( UPPER(labels) <= UPPER("'+labels+'яяя") )  ) ';
                   end
               end
   end;
if  labels <> '' then
     if gen <> '' then
         gen:='(' + gen + ') AND ' + sqlStr_lab
     else
         gen:= sqlStr_lab;
if category <> '' then
   if gen<>'' then
    gen:='(' + gen + ') AND ' + sqlStr_cat
   else
     gen:=sqlStr_cat;
limits := ' LIMIT '+IntToStr(pageSize)+ ' OFFSET '+IntToStr(pageSize*(page-1));
if gen<>'' then gen:=' where '+gen;
sqlText:='select * from '+ table + ' '+ gen+' ORDER BY '+sorting_field+' '+sorting_order+limits;

history_sql:=TStringList.Create;
history_sql.clear;
if fileExists('sql.txt') then
   begin
   history_sql.LoadFromFile('sql.txt');
   last_query:=history_sql.Strings[history_sql.Count-1];
   end
else
   begin
        last_query:='';
   end;
l.free;
if last_query<>sqlText then
   begin
   history_sql.LoadFromFile('sql.txt');
   history_sql.Add(sqlText);
   history_sql.SaveToFile('sql.txt');
   end;
send_request();
history_sql.free;
Result:=sqlText;
end;

procedure TMagnets_Entity.init_db;
var i : byte;
begin
  inherited init_db;
  if conn=NIL then
     begin
          make_db_objects();
          link_it();
     end;

  conn.Close; // Ensure the connection is closed when we start

  if fileexists('main-sqlite.db') then  exit;
  conn.DatabaseName:='main-sqlite.db';
  conn.Open;
  trSQL.Active := true;


        conn.ExecuteDirect('CREATE TABLE "'+table+'"('+
                    ' "id" Integer NOT NULL PRIMARY KEY AUTOINCREMENT,'+
                    ' "category" Char(1000) NOT NULL,'+
                    ' "caption" Char(1000) NOT NULL,'+
                    ' "labels" Char(1000) NOT NULL,'+
                    ' "hash" Char(1000) NOT NULL);');

        trSQL.Commit;
        // Creating an index based upon id in the DATA Table
        conn.ExecuteDirect('CREATE UNIQUE INDEX "data_id_idx" ON "'+table+'"( "id" );');
        trSQL.Commit;
        conn.ExecuteDirect('CREATE UNIQUE INDEX "hash_id_idx" ON "'+table+'"( "hash" );');
        trSQL.Commit;
        conn.ExecuteDirect('CREATE INDEX "labels_id_idx" ON "'+table+'"( "labels" );');
        trSQL.Commit;
        conn.ExecuteDirect('CREATE INDEX "category_id_idx" ON "'+table+'"( "category" );');
        trSQL.Commit;
        conn.ExecuteDirect('CREATE INDEX "caption_id_idx" ON "'+table+'"( "caption" );');
        trSQL.Commit;

        // test insert
        for i:=0 to 4 do
         begin
                 conn.ExecuteDirect('INSERT INTO '+table+' (category, caption, labels, hash) VALUES ("test", "test'+IntToStr(i)+'", "test", "000'+IntToStr(i)+'");');
                 trSQL.Commit;
         end;
 end;



procedure TMagnets_Entity.insert;
begin
 make_db_objects();
 link_it();
 sqlText:='INSERT INTO '+table+' (category, caption, labels, hash)  VALUES ( ';
 sqlText:=SqlText+QuotedStr(category)+', '+QuotedStr(caption)+', ';
 sqlText:=SqlText+QuotedStr(labels)+', '+QuotedStr(hash);
 sqlText:=SqlText+');';
 send_request();
 free_it();
end;

procedure TMagnets_Entity.update;
begin
make_db_objects();
link_it();
SqlText:='UPDATE '+table+' SET ';
SqlText:=SqlText+' category='+QuotedStr(category)+', ';
SqlText:=SqlText+' caption='+QuotedStr(caption)+', ';
SqlText:=SqlText+' labels='+QuotedStr(labels)+', ';
SqlText:=SqlText+' hash='+QuotedStr(hash)+' WHERE ';
SqlText:=SqlText+'( category='+QuotedStr(old_category) +' ) AND ';
SqlText:=SqlText+'( caption='+QuotedStr(old_caption) +' ) AND ';
SqlText:=SqlText+'( labels='+QuotedStr(old_labels) +' ) AND ';
SqlText:=SqlText+'( hash='+QuotedStr(old_hash) +' ); ';
send_request();
free_it();
end;

procedure TMagnets_Entity.delete;
begin
make_db_objects();
link_it();
sqlText:='DELETE FROM '+table+' WHERE ';
sqlText:=sqlText+'( category='+QuotedStr(category) +' ) AND ';
sqlText:=sqlText+'( caption='+QuotedStr(caption) +' ) AND ';
sqlText:=sqlText+'( labels='+QuotedStr(labels) +' ) AND ';
sqlText:=sqlText+'( hash='+QuotedStr(hash) +' ); ';
send_request();
free_it();
end;

procedure TMagnets_Entity.tear;
begin
    filename:='main-sqlite.db';
    table:='data';
    make_db_objects();
    link_it();
    connect();
end;

function TMagnets_Entity.getCount(count_field, count_value : String): Integer;
var gcnt : Integer;
begin
 make_db_objects();
 link_it();
 query.Close;
 query.SQL.Clear;
 query.SQL.Add('SELECT COUNT(*) as cnt FROM ' + table + ' WHERE '+count_field+'="'+count_value+'"');
 query.ExecSQL;
 query.Open;
 dsSQL.DataSet.First;
 gcnt:=dsSQL.DataSet.FieldByName('cnt').AsInteger;
 query.Close;
 free_it();
 make_db_objects();
 link_it();
 Result:=gcnt;

end;



end.

