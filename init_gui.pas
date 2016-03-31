unit init_gui;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfmInit }

  TfmInit = class(TForm)
    mmInit: TMemo;
  private
    { private declarations }
  public
    { public declarations }
    procedure m(msg : String);
  end;

var
  fmInit: TfmInit;

implementation

{$R *.lfm}

{ TfmInit }

procedure TfmInit.m(msg: String);
begin
  mmInit.Lines.Add(msg);
end;

end.

