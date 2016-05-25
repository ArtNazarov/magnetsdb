unit delete_gui;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Localization;

type

  { TfmDelete }

  TfmDelete = class(TLocalizedForm)
    btOk: TButton;
    btCancel: TButton;
    edCategory: TEdit;
    edCaption: TEdit;
    edLabels: TEdit;
    edHash: TEdit;
    lbCategory: TLabel;
    lbCaption: TLabel;
    lbLabels: TLabel;
    lbHash: TLabel;
    procedure btCancelClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    fcategory : String;
    fcaption  : String;
    flabels   : String;
    fhash     : String;
    procedure valuestogui();
  end;

var
  fmDelete: TfmDelete;

implementation

{$R *.lfm}

{ TfmDelete }

procedure TfmDelete.btOkClick(Sender: TObject);
begin
  modalresult:=mrOK;
end;

procedure TfmDelete.btCancelClick(Sender: TObject);
begin
  modalresult:=mrCancel;
end;

procedure TfmDelete.valuestogui;
begin
  edCategory.text:=fcategory;
  edCaption.text:=fcaption;
  edLabels.text:=flabels;
  edHash.text:=fhash;
end;

end.

