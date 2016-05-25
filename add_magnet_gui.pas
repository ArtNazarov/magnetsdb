unit add_magnet_gui;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ClipBrd, localization;

type

  { TfmAddMagnet }

  TfmAddMagnet = class(TLocalizedForm)
    btInsertHash: TButton;
    btInsertToDb: TButton;
    btCancel: TButton;
    edCategory: TComboBox;
    edHash: TEdit;
    edCaption: TEdit;
    edLabels: TEdit;
    lbCategory: TLabel;
    lbCaption: TLabel;
    lbLabels: TLabel;
    lbHash: TLabel;
    procedure btInsertHashClick(Sender: TObject);
    procedure btInsertToDbClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    fcategory : String;
    flabels   : String;
    fhash     : String;
    fcaption  : String;

    procedure valuesfromgui();
    procedure valuestogui();

  end;

var
  fmAddMagnet: TfmAddMagnet;

implementation

{$R *.lfm}

{ TfmAddMagnet }

procedure TfmAddMagnet.FormCreate(Sender: TObject);
begin
  edCategory.Clear;
  edCategory.Items.LoadFromFile('categories.txt');
  fcaption:='';
  flabels:='';
  fcategory:='';
  fhash:='';
  valuestogui();
  // TODO : localization of the form
end;

procedure TfmAddMagnet.btInsertToDbClick(Sender: TObject);
begin
  valuesfromgui();
//  fmAddMagnet.ModalResult:=mrOK;
end;

procedure TfmAddMagnet.btInsertHashClick(Sender: TObject);
var str : String;
    z : Integer;
    t  : String;
   q  : Integer;
const
  pattern : String = 'magnet:?xt=urn:btih:';

begin
 t:='';
 // TODO: add code from 1.5.x
 str:=ClipBrd.Clipboard.AsText;
 //showmessage(str);
 z:=Pos(pattern, Str)+Length(pattern);
// showmessage(IntToStr(z));
 q:=z;
 while q<=length(str) do
       begin
         if str[q] in ['a'..'f', 'A'..'F', '0'..'9'] then
            t:=t+str[q] else break;
         q:=q+1;
       end;
 edHash.Text:=t;
end;

procedure TfmAddMagnet.valuesfromgui;
begin
  fcategory:=edCategory.text;
  flabels:=edLabels.text;
  fcaption:=edCaption.text;
  fhash:=edHash.text;
end;

procedure TfmAddMagnet.valuestogui;
begin
  edCategory.text:=fcategory;
  edLabels.text:=flabels;
  edCaption.text:=fcaption;
  edHash.text:=fhash;
end;

end.

