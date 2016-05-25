unit gui_editor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Localization;

type

  { TfmEditor }

  TfmEditor = class(TLocalizedForm)
    btOK: TButton;
    btCancel: TButton;
    edCategory: TComboBox;
    edCaption: TEdit;
    edLabels: TEdit;
    edHash: TEdit;
    lbCategory: TLabel;
    lbCaption: TLabel;
    lbLabels: TLabel;
    lbHash: TLabel;
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    fcaption : String;
    flabels  : String;
    fhash    : String;
    fcategory : String;
    procedure valuestogui();
    procedure valuesfromgui();
  end;

var
  fmEditor: TfmEditor;

implementation

{$R *.lfm}

procedure TfmEditor.valuesfromgui;
begin
  fcategory:=edCategory.text;
  flabels:=edLabels.text;
  fcaption:=edCaption.text;
  fhash:=edHash.text;
end;

procedure TfmEditor.valuestogui;
begin
  edCategory.text:=fcategory;
  edLabels.text:=flabels;
  edCaption.text:=fcaption;
  edHash.text:=fhash;
end;

procedure TfmEditor.FormCreate(Sender: TObject);
begin
//  showmessage(Name);
  edCategory.Clear;
  edCategory.Items.LoadFromFile('categories.txt');
  fcaption:='';
  flabels:='';
  fcategory:='';
  fhash:='';
  valuestogui();
  // TODO : localization of the form
end;

procedure TfmEditor.btOKClick(Sender: TObject);
begin
  valuesfromgui();
  ModalResult:=mrOK;
end;

end.

