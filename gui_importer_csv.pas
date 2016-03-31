unit gui_importer_csv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Localization;

type

  { TfmImport }

  TfmImport = class(TLocalizedForm)
    btCancel: TButton;
    btOK: TButton;
    btOpenDialog: TButton;
    chkFilter: TCheckBox;
    chkLog: TCheckBox;
    chkNewBase: TCheckBox;
    edBulkSize: TEdit;
    edBy_Category: TEdit;
    edBy_Caption: TEdit;
    edBy_Labels: TEdit;
    GroupBox1: TGroupBox;
    lbBy_Category: TLabel;
    lbBy_Caption: TLabel;
    lbBy_Labels: TLabel;
    lbBulkSize: TLabel;
    lbSourcePath: TLabel;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    rgSourceCSV: TRadioGroup;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure btOKClick(Sender: TObject);
    procedure btOpenDialogClick(Sender: TObject);
    procedure chkFilterChange(Sender: TObject);
    procedure chkLogChange(Sender: TObject);
    procedure chkNewBaseChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    sourcepath : String;
    do_logging    : Boolean;
    do_filtering  : Boolean;
    new_base      : Boolean;
    filter        : String;
    source_key   : String;
    by_category  : String;
    by_caption   : String;
    by_labels    : String;
    procedure valuestogui();
    procedure valuesfromgui();
    function get_tool_params() : String;
  end;

var
  fmImport: TfmImport;

implementation

{$R *.lfm}

{ TfmImport }

procedure TfmImport.btOpenDialogClick(Sender: TObject);
begin
  case rgSourceCSV.ItemIndex of
  0 : begin if OpenDialog1.Execute then sourcepath:=OpenDialog1.FileName; valuestogui(); end;
  1 : begin if SelectDirectoryDialog1.Execute then sourcepath:=SelectDirectoryDialog1.FileName; valuestogui(); end;
  end;
end;

procedure TfmImport.chkFilterChange(Sender: TObject);
begin
  do_filtering := chkFilter.Checked;
end;

procedure TfmImport.chkLogChange(Sender: TObject);
begin
  do_logging:= chkLog.Checked;
end;

procedure TfmImport.chkNewBaseChange(Sender: TObject);
begin
  new_base := chkNewBase.Checked;
end;

procedure TfmImport.btOKClick(Sender: TObject);
begin
  if filter='' then exit;
  valuesfromgui();
  ModalResult:=mrOK;
end;

procedure TfmImport.valuestogui;
begin
  lbSourcePath.Caption:=sourcepath;
end;

procedure TfmImport.valuesfromgui;
begin

  do_filtering:=chkFilter.Checked;
  do_logging:=chkLog.Checked;
  new_base:=chkNewBase.Checked;
  by_category:=edBy_Category.Text;
  by_caption:=edBy_caption.Text;
  by_labels:=edBy_Labels.Text;
  case rgSourceCSV.ItemIndex of
  0 : source_key:='filename';
  1 : source_key:='directory';
  end;
end;

function TfmImport.get_tool_params: String;
var p : String;
begin
  valuesfromgui();
  p:=source_key+'='+sourcepath;
  if do_filtering then
     begin
       p:=p+' by_caption='+edBy_Caption.text+' by_category='+edBy_Category.text
       +' by_labels='+edBy_Labels.text;
     end;
  if do_logging then
       p:=p+' log=yes'
     else
       p:=p+' log=no';
  if edBulkSize.Text='' then p:=p+' bulk=200' else p:=p+' bulk='+edBulkSize.Text;
  Result:=p;
end;

end.

