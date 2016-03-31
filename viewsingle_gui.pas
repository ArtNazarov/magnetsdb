unit viewsingle_gui;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Localization;

type

  { TfmViewSingle }

  TfmViewSingle = class(TLocalizedForm)
    dispCategory: TLabel;
    dispCaption: TLabel;
    dispLabels: TLabel;
    dispHash: TLabel;
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
  fmViewSingle: TfmViewSingle;

implementation

{$R *.lfm}

{ TfmViewSingle }

procedure TfmViewSingle.btOkClick(Sender: TObject);
begin
  modalresult:=mrOK;
end;

procedure TfmViewSingle.btCancelClick(Sender: TObject);
begin
  modalresult:=mrCancel;
end;

procedure TfmViewSingle.valuestogui;
begin
  dispCategory.Caption:=fcategory;
  dispCaption.Caption:=fcaption;
  dispLabels.Caption:=flabels;
  dispHash.Caption:=fhash;
end;

end.

