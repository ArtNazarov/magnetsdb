unit gui_ini_files;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterIni, SynEdit, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TfmIniEditor }

  TfmIniEditor = class(TForm)
    btOK: TButton;
    btCancel: TButton;
    Panel1: TPanel;
    SynEdit1: TSynEdit;
    SynIniSyn1: TSynIniSyn;
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    filename : String;
    procedure load();
    procedure save();
  end;

var
  fmIniEditor: TfmIniEditor;

implementation

{$R *.lfm}

{ TfmIniEditor }

procedure TfmIniEditor.FormCreate(Sender: TObject);
begin
  btOk.Width:=Width div 2;
end;

procedure TfmIniEditor.btOKClick(Sender: TObject);
begin
  if filename<>'' then save();
  ModalResult:=mrOK;
end;

procedure TfmIniEditor.btCancelClick(Sender: TObject);
begin
  modalresult:=mrCancel;
end;

procedure TfmIniEditor.load;
begin
  Caption:=filename;
  SynEdit1.lines.LoadFromFile(filename);
end;

procedure TfmIniEditor.save;
begin
  SynEdit1.lines.SaveToFile(filename);
end;

end.

