unit user_history;

//TODO:module user_history was cleared

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  dbf, sqlite3conn, sqldb, // database units
  FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, Menus, ExtCtrls,
   clipbrd;


procedure loadusersearches(var edCaption : TComboBox);
procedure saveusersearches(var edCaption : TComboBox);
procedure clearUserHistory(var edCaption : TComboBox);
procedure save_request_to_history(var edCaption : TComboBox);

procedure save_labels(var edLabels : TComboBox);
procedure clear_labels(var edLabels : TComboBox);
procedure restore_labels(var edLabels : TComboBox);
procedure add_label(var edLabels : TComboBox);


implementation

procedure loadusersearches(var edCaption : TComboBox);
begin
  if FileExists('usersearches.txt')
     then edCaption.Items.LoadFromFile('usersearches.txt');
end;

procedure saveusersearches(var edCaption : TComboBox);
begin
   edCaption.Items.SaveToFile('usersearches.txt');
end;


procedure clearUserHistory(var edCaption : TComboBox);
begin
  if FileExists('usersearches.txt') then
     begin
          edCaption.Items.Clear;
          edCaption.Items.SaveToFile('usersearches.txt');
     end;
            clear_labels(edCaption);
end;


procedure save_request_to_history(var edCaption : TComboBox);
var i : integer; found : boolean;
begin
 found := false;
 for i:=0 to edCaption.Items.Count-1 do
   if edCaption.Items[i] = edCaption.Text then
      begin
      found:=true;
      break;
      end;
 if not found then
        edCaption.Items.Add(edCaption.Text);
end;

procedure save_labels(var edLabels : TComboBox);
begin
  edLabels.Items.SaveToFile('labels.txt');
end;

procedure restore_labels(var edLabels : TComboBox);
begin
 if fileexists('labels.txt') then
    edLabels.Items.LoadFromFile('labels.txt');
end;

procedure clear_labels(var edLabels : TComboBox);
begin
  edLabels.Items.Clear;
  save_labels(edLabels);
end;

procedure add_label(var edLabels : TComboBox);
var i : integer; found : boolean;
begin
   found := false;
  for i:=0 to edLabels.Items.Count-1 do
    if edLabels.Items[i] = edLabels.Text then
       begin
            found:=true;
            break;
       end;
  if (not found) and (edLabels.Text<>'') then
     edLabels.Items.Add(edLabels.Text);
  save_labels(edLabels);
end;

end.

