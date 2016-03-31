unit wndgrid;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ValEdit,
  Grids, Buttons;

type

  { TfmGrid }

  TfmGrid = class(TForm)
    grid: TStringGrid;
    procedure FormResize(Sender: TObject);
    procedure gridResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure clear();
    procedure add(Key, Value : String);
  end;

var
  fmGrid: TfmGrid;

implementation

{$R *.lfm}

{ TfmGrid }

procedure TfmGrid.gridResize(Sender: TObject);
begin

end;

procedure TfmGrid.FormResize(Sender: TObject);
begin
  Grid.Columns[1].Width := Width - Grid.Columns[0].Width;
end;

procedure TfmGrid.clear;
begin
  Caption:='Hotkeys';
  grid.Columns[0].Title.Caption:='Key';
  grid.Columns[1].Title.Caption:='Value';
  grid.Clear;
  grid.RowCount:=1;
end;

procedure TfmGrid.add(Key, Value: String);
var s : TStringList;
begin
  with grid do
   begin
     s:=TStringList.Create;
     s.Add(Key);
     s.Add(value);
     RowCount:=RowCount+1;
     Rows[RowCount-1]:=s;
     s.free;
   end;
end;

end.

