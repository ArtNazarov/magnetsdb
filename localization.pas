unit localization;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, IniFiles,
  Controls,
  Graphics, Dialogs,  StdCtrls, DbCtrls, DBGrids, Menus, ExtCtrls,
  Process,     Grids;

  const
    lgMmDebug = 0;
    lgFormFile = 1;

  type

  { TLocalizedForm }

  TLocalizedForm = class(TForm)

  public
    procedure localize(lang : String);
    function get_msg(key : String; lang : String; def : String) : String;
    procedure log(dest : byte; msg : String);
    function is_localized(key : String) : Boolean;
    function getCNameByKey( key : String) : String;
  end;


implementation

procedure   TLocalizedForm.localize(lang: String);
var inif : TIniFile;
     buttons, labels , menuitems, checkboxes,
     dbgridcolumns, gridcolumns, forms  : TStringList;
     i, k : Integer;
     s, z : String;
     locale_filename : String;
begin
  //showmessage(Self.Name);
  if lang='' then Exit;
  locale_filename:=lang+'.ini';

  if not fileexists(locale_filename) then exit;
  forms:=TStringList.Create(); forms.Clear;
  buttons:=TStringList.Create(); buttons.Clear;
  labels:=TStringList.Create(); labels.clear;
  checkboxes:=TStringList.Create(); checkboxes.clear;
  menuitems:=TStringList.Create(); menuitems.clear;
  gridcolumns:=TStringList.Create(); gridcolumns.clear;
  dbgridcolumns:=TStringList.Create(); dbgridcolumns.clear;

  inif:=TIniFile.Create(locale_filename);
  inif.ReadSection('forms', forms);
  inif.ReadSection('buttons', buttons);
  inif.readSection('labels', labels);
  inif.readSection('checkboxes', checkboxes);
  inif.readSection('menuitems', menuitems);
  inif.readSection('gridcolumns', gridcolumns);
  inif.readSection('dbgridcolumns', dbgridcolumns);

  //showmessage('localize:'+Self.Name);

    for I:=0 to forms.Count-1 do
      if is_localized(forms[i]) then
              begin
              s:=Inif.ReadString('forms', forms[i], 'fmForm'+IntToStr(i));
              Self.Caption := s;
              break;
              end;

  for I:=0 to buttons.Count-1 do
      if is_localized(buttons[i]) then
              begin

              s:=Inif.ReadString('buttons', buttons[i], 'btn'+IntToStr(i));
              z:=getCNameByKey(buttons[i]);
              if NIL <> Self.FindComponent(z) as TButton
                          then
                              (Self.FindComponent(z) as TButton).Caption:=s;
              end;



  for i:=0 to labels.Count-1 do
      if is_localized(labels[i]) then
        begin

         s:=Inif.ReadString('labels', labels[i], 'lb'+IntToStr(i));
         z:=getCNameByKey(labels[i]);
         // showmessage(s);
         // showmessage(z);
         if (Self.FindComponent(z) as TLabel)<> NIL
            then
               (Self.FindComponent(z) as TLabel).Caption:=s;
      end;

    for i:=0 to checkboxes.Count-1 do
        if is_localized( checkboxes[i]) then
      begin

         s:=Inif.ReadString('checkboxes', checkboxes[i], 'chk'+IntToStr(i));
         z:=getCNameByKey(checkboxes[i]);
         // showmessage(s);
         // showmessage(z);
         if NIL <> Self.FindComponent(z) as TCheckBox
            then
              (Self.FindComponent(z) as TCheckbox).Caption:=s;
      end;
   for i:=0 to menuitems.Count-1 do
            if is_localized(menuitems[i]) then
      begin

         s:=Inif.ReadString('menuitems', menuitems[i], 'mnu'+IntToStr(i));
         z:=getCNameByKey(menuitems[i]);
         // showmessage(s);
         // showmessage(z);
                  if NIL <> Self.FindComponent(z) as TMenuItem then
                           (Self.FindComponent(z) as TMenuItem).Caption:=s;
      end;
   for i:=0 to gridcolumns.Count-1 do
         if is_localized(gridcolumns[i]) then
     begin

         s:=Inif.ReadString('gridcolumns', gridcolumns[i], 'gc'+IntToStr(i));
         z:=AnsiString(getCNameByKey(gridcolumns[i]));
         k:=StrToInt(AnsiString(z[length(AnsiString(z))]));
         z:=Copy(z, 1, length(z)-1);

         //showmessage(z);
         //showmessage(inttostr(k));

                  if NIL <> (Self.FindComponent(z) as TStringGrid) then
                     (Self.FindComponent(z) as TStringGrid).Columns[k].Title.Caption:=s;

      end;
   for i:=0 to dbgridcolumns.Count-1 do
       if is_localized(dbgridcolumns[i]) then
      begin
         s:=Inif.ReadString('dbgridcolumns', dbgridcolumns[i], 'dgc'+IntToStr(i));
         z:=AnsiString(getCNameByKey(dbgridcolumns[i]));
          k:=StrToInt(AnsiString(z[length(AnsiString(z))]));

         z:=Copy(z, 1, length(z)-1);

         //showmessage(z);
         //showmessage(intToStr(k));




            if NIL <> Self.FindComponent(z) as TDBGrid then
         (Self.FindComponent(z) as TDBGrid).Columns[k].Title.Caption:=s;

      end;

  checkboxes.free;
  buttons.free;
  labels.free;
  menuitems.free;
  gridcolumns.free;
  dbgridcolumns.free;
  forms.free;

end;

function TLocalizedForm.get_msg(key: String; lang : String; def: String): String;
var IniF : TIniFile; Str : String;
begin
 if not FileExists(lang+'.ini') then
          Result:=def
 else
 begin
 IniF:=TIniFile.Create(lang+'.ini');
 str:=IniF.ReadString('msg', key, def);
 IniF.Free;
 end;
 Result:=str;
end;

procedure TLocalizedForm.log(dest: byte; msg: String);
var
    f : TextFile;
    filename : String;

begin
  if dest = lgMmDebug then
    if Self.FindComponent('mmDebug') <> NIL then
      begin
            (Self.FindComponent('mmDebug') as TMemo).Lines.Add(msg);
      end;
  if dest = lgFormFile then
    begin
          filename:=Self.Name+'_form.log';
          AssignFile(f, filename);
          if FileExists(filename) then
            Append(f) else Rewrite(f);
          writeln(f, msg);
          closefile(f);
    end;
end;

function   TLocalizedForm.is_localized(key: String): Boolean;
begin
  Result:=(Pos(Self.Name + '.' , key) > 0)
end;

function   TLocalizedForm.getCNameByKey(key: String): String;
var i, j : Integer;
    s : String;
begin
  j:=length(key);
  i:=Pos('.', key)+1;
  s:=Copy(key, i, j-i+1);
  Result:=S;
end;

end.

