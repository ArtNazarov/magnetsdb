program magnetsdb;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, FileUtil, SysUtils, // this includes the LCL widgetset
  Forms, dbflaz, main, add_magnet_gui, gui_importer_csv, gui_editor, delete_gui,
  gui_ini_files, localization, init_gui, magnets_constants,
  uniqueinstanceraw, wndgrid
  (*, internal_browser *)
  { you can add units after this };

{$R *.res}

(* var f : TextFile; status : string; *)

begin
   if not InstanceRunning('magnetsdb', true) then
   begin
(*
  if not fileutil.FileExistsUTF8('mutex.txt') then
   begin
     system.Assign(f, 'mutex.txt');
     system.ReWrite(f);
     writeln(f, 'open');
     system.close(f);
   end;
  system.Assign(f, 'mutex.txt');
  system.reset(f);
  system.readln(f, status);
  system.close(f);

  if status <> 'open' then
     begin
     if paramcount = 1 then
        begin
             system.Assign(f, 'inserted_hash.txt');
             system.Rewrite(f);
             system.writeln(f, paramstr(1));
             system.close(f);
        end;
     exit;
     end;

  *)

  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);

  if ParamCount > 0 then
     begin
     fmMain.Show;
     fmMain.action_to_do:='add';
     fmMain.inserted_link:=ParamStr(1);
     fmMain.do_action_on_start();
     end;
  Application.CreateForm(TfmGrid, fmGrid);
    Application.Run;

   (*
  system.Rewrite(f);
  system.writeln(f, 'open');
  system.close(f);
  *)
end;
end.

