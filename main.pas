unit main;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils,
  dbf, sqlite3conn, sqldb, // database units
  FileUtil, Forms, Controls,
  Graphics, Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, Menus, ExtCtrls,
  Process,  AsyncProcess, clipbrd, INIFiles,  Grids,
  user_fav,
  user_history,
  str_common_funcs,
  db_funcs,
  LCLType,
  LCLProc, PopupNotifier, ComboEx, CheckLst,  UTF8Process,
  add_magnet_gui,
  gui_importer_csv,
  gui_editor,
  gui_ini_files,
  delete_gui,
  localization,
  init_gui,
  magnets_constants,
  viewsingle_gui,
  magnets_entity, UniqueInstance,
  wndgrid
 (*, internal_browser *), Types;

const

  url_sitereadme : String = 'https://github.com/ArtNazarov/magnetsdb/blob/master/README.md';
  plFilename = 'possible-labels.txt';


type


  { TfmMain }

  TfmMain = class(TLocalizedForm)
    btnClearUserHistory: TButton;
    btPrevPage: TButton;
    btNextPage: TButton;
    btPrevSQL: TButton;
    btMultiSelect: TButton;
    btPossibleLabels: TButton;
    btPossibleLabelsApply: TButton;
    ccCategory: TCheckListBox;
    possibleLabels: TListBox;
    chkCategory: TCheckBox;
    chkCustomColors: TCheckBox;
    chkLabel: TCheckBox;
    chkStrictMode: TCheckBox;
    edCaption: TComboBox;
    edCategory: TEdit;
    edLabels: TComboBox;
    lbAttrs: TCheckBox;
    chkSearchOnChange: TCheckBox;
    chkColorize: TCheckBox;
    lbPage: TLabel;
    lbFavourites: TLabel;
    leftPanel: TPanel;
    favHandler4: TMenuItem;
    FavSearchEngine1: TMenuItem;
    FavSearchEngine2: TMenuItem;
    FavSearchEngine3: TMenuItem;
    FavHandlers: TMenuItem;
    FavSearchEngines: TMenuItem;
    FavOtherActions: TMenuItem;
    dbImport: TMenuItem;
    dbEdit: TMenuItem;
    dbDelete: TMenuItem;
    fmMenu: TMainMenu;
    FavSearchEngine4: TMenuItem;
    FavSearchEngine5: TMenuItem;
    dbReindex: TMenuItem;
    capSearchEngine1: TMenuItem;
    capSearchEngine2: TMenuItem;
    capSearchEngine3: TMenuItem;
    capSearchEngine4: TMenuItem;
    capSearchEngine5: TMenuItem;
    mnuTools: TMenuItem;
    mnuViewSql: TMenuItem;
    mnuTrList: TMenuItem;
    mnuHelpWebSite: TMenuItem;
    mnuHelp: TMenuItem;
    mnuHelpHotkeys: TMenuItem;
    mnuViewSingle: TMenuItem;
    mnuGetBase: TMenuItem;
    panCategory: TPanel;
    panOtherAttrs: TPanel;
    pmDbSearchEngine5: TMenuItem;
    pmDbSearchEngine4: TMenuItem;
    mnuSettings: TMenuItem;
    mnuLocalization: TMenuItem;
    mnuOptions: TMenuItem;
    pmAddRecord: TMenuItem;
    mnuDbOtherActions: TMenuItem;
    mnuDbSearchEngines: TMenuItem;
    mnuAppHandlers: TMenuItem;
    pmDbSearchEngine3: TMenuItem;
    pmDbSearchEngine1: TMenuItem;
    pmDbSearchEngine2: TMenuItem;
    pmAppHandler4: TMenuItem;
    mmDebug: TMemo;
    pmDbSelectAll: TMenuItem;
    pmAddToFav: TMenuItem;
    favHandler2: TMenuItem;
    favHandler3: TMenuItem;
    favRemoveItem: TMenuItem;
    favClearAll: TMenuItem;
    favHandler1: TMenuItem;
    panTop: TPanel;
    panCenter: TPanel;
    pmAppHandler2: TMenuItem;
    pmAppHandler3: TMenuItem;

    bottomPanel: TPanel;
    pmAppHandler1: TMenuItem;
    OpenDialog1: TOpenDialog;
    pmDatabase: TPopupMenu;
    pmFav: TPopupMenu;
    pmCaption: TPopupMenu;
    PopupNotifier1: TPopupNotifier;
    rightPanel: TPanel;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    sqlGrid: TDBGrid;
    lbFav: TStringGrid;
    tbFontSize: TTrackBar;
    Timer1: TTimer;
    tmSQL: TTimer;
    UniqueInstance1: TUniqueInstance;

    procedure btMultiSelectClick(Sender: TObject);
    procedure btnClearUserHistoryClick(Sender: TObject);
    procedure btPossibleLabelsApplyClick(Sender: TObject);
    procedure btPossibleLabelsClick(Sender: TObject);
    procedure btPrevPageClick(Sender: TObject);

    procedure btNextPageClick(Sender: TObject);
    procedure btPrevSQLClick(Sender: TObject);
    procedure capSearchEngine1Click(Sender: TObject);
    procedure capSearchEngine2Click(Sender: TObject);
    procedure capSearchEngine3Click(Sender: TObject);
    procedure capSearchEngine4Click(Sender: TObject);
    procedure capSearchEngine5Click(Sender: TObject);
    procedure ccCategoryClickCheck(Sender: TObject);
    procedure ccCategoryDblClick(Sender: TObject);
    procedure ccCategoryItemClick(Sender: TObject; Index: integer);
    procedure chkCategoryChange(Sender: TObject);
    procedure chkCustomColorsChange(Sender: TObject);
    procedure chkLabelChange(Sender: TObject);
    procedure chkColorizeChange(Sender: TObject);
    procedure chkSearchOnChangeChange(Sender: TObject);
    procedure chkStrictModeChange(Sender: TObject);
    procedure dbDeleteClick(Sender: TObject);
    procedure dbEditClick(Sender: TObject);
    procedure dbImportClick(Sender: TObject);
    procedure dbReindexClick(Sender: TObject);
    procedure edCaptionChange(Sender: TObject);
    procedure edCaptionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCategoryChange(Sender: TObject);
    procedure edCategoryEditingDone(Sender: TObject);
    procedure edCategoryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCategorySelect(Sender: TObject);
    procedure edLabelsChange(Sender: TObject);
    procedure edLabelsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure favClearAllClick(Sender: TObject);
    procedure favHandler1Click(Sender: TObject);
    procedure favHandler2Click(Sender: TObject);
    procedure favHandler3Click(Sender: TObject);
    procedure favHandler4Click(Sender: TObject);
    procedure favRemoveItemClick(Sender: TObject);
    procedure FavSearchEngine1Click(Sender: TObject);
    procedure FavSearchEngine2Click(Sender: TObject);
    procedure FavSearchEngine3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure lbAttrsChange(Sender: TObject);
    procedure lbFavDblClick(Sender: TObject);
    procedure lbFavHeaderSized(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
    procedure mnuGetBaseClick(Sender: TObject);
    procedure mnuHelpHotkeysClick(Sender: TObject);
    procedure mnuHelpWebSiteClick(Sender: TObject);
    procedure mnuLocalizationClick(Sender: TObject);
    procedure mnuSettingsClick(Sender: TObject);
    procedure mnuTrListClick(Sender: TObject);
    procedure mnuViewSingleClick(Sender: TObject);
    procedure mnuViewSqlClick(Sender: TObject);
    procedure pmAddRecordClick(Sender: TObject);
    procedure pmAddToFavClick(Sender: TObject);
    procedure pmAppHandler2Click(Sender: TObject);
    procedure pmAppHandler3Click(Sender: TObject);
    procedure pmAppHandler4Click(Sender: TObject);
    procedure pmDbSearchEngine1Click(Sender: TObject);
    procedure pmDbSearchEngine2Click(Sender: TObject);
    procedure pmDbSearchEngine3Click(Sender: TObject);
    procedure pmDbSelectAllClick(Sender: TObject);
    procedure pmAppHandler1Click(Sender: TObject);
    procedure pmInsertHashClick(Sender: TObject);
    procedure PopupNotifier1Close(Sender: TObject; var CloseAction: TCloseAction
      );
    procedure possibleLabelsClick(Sender: TObject);
    procedure possibleLabelsDblClick(Sender: TObject);
    procedure possibleLabelsDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure rightPanelClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure sqlGridColumnSized(Sender: TObject);
    procedure sqlGridDblClick(Sender: TObject);
    procedure sqlGridTitleClick(Column: TColumn);
    procedure tbFontSizeChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure tmSQLTimer(Sender: TObject);
    procedure searchonenterkey(Key : Word);
    procedure resize_columns_of_grids();
    procedure UniqueInstance1OtherInstance(Sender: TObject;
      ParamCount: Integer; Parameters: array of String);












  private
    { private declarations }

  public
     // settings, session data, logic flags
     loading_checkboxes : boolean;
     dontchangelist : boolean;
     action_to_do : String;
     inserted_link : String;
     used_app : String;
     used_vplayer : String;
     used_altapp : String;
     used_altapp4 : String;
     used_lang    : String;
     confirm_delete : Boolean;
     warn_empty_category : boolean;
     updater_magic : String;
     use_external_browser : boolean;
     ptr_history          : Integer;


     CategoriesFullList : TStringList;

     m : TfmInit;


     last_caption : String;
     last_labels : String;
     last_category : String;



     md : TMagnets_Entity;

    procedure initsettings();
    procedure save_settings_to_ini;
    procedure readsettings;

    procedure initapplication;
    procedure initinterface;

    procedure favToApp(app_index : integer);
    procedure dbToApp(app_index : integer);

    procedure colorize();
    procedure rq();
    procedure disconnect();
    procedure connect_again();

    procedure load_locale(lang : String);
    procedure attrs_show();
    procedure open_browser(url : String);
    procedure open_search_engine(source : byte; index : byte);
    procedure set_font_size(fs : Integer);


    procedure startApp();
    procedure stopApp();
    procedure reloadApp();
    procedure do_action_on_start();

    procedure prevpageaction();
    procedure nextpageaction();
    procedure tofirstpage();

    function getTrList() : String;

  end;

var
  fmMain: TfmMain;

implementation

{$R *.lfm}

{ TfmMain }


procedure TfmMain.initapplication;
var history_sql : TStringList;
begin

 ptr_history:=-1;
 if FileExists('sql.txt') then
    begin
      history_sql:=TStringList.Create;
      history_sql.LoadFromFile('sql.txt');
      ptr_history:=history_sql.Count-1;
      history_sql.Free;
    end;
 btPrevSQL.Enabled:=(ptr_history>0);
 used_app := DefaultApps[version, ixHandler0];
 used_vplayer := DefaultApps[version, ixHandler1];
 used_altapp := DefaultApps[version, ixHandler2];
 m.m('init interface started...');
 initinterface();
 m.m('init interface ended...');
 m.m('init settings started...');
 initsettings();
 m.m('init settings ended...');
 m.m('ReadSettings started...');
 readsettings();
 m.m('ReadSettings ended...');
 m.m('load user searches...');
 user_history.loadusersearches(edCaption);
 m.m('load user searches ended...');
 m.m('load user history, restore labels started');
 user_history.restore_labels(edLabels);
 m.m('load user history, restore labels ended');
 m.m('colorize started...');
 colorize();
 m.m('colorize ended...');
m.m('init ended...');
end;


procedure TfmMain.initinterface();
begin

end;

procedure TfmMain.favToApp(app_index: integer);
var process: TAsyncProcess;
    str : string;
    I : Integer;
    add_tr : String;
begin
  str:=used_app;
  add_tr:=getTrList();
  case app_index of
  1 : begin str:=used_app; end;
  2 : begin str:=used_vplayer; end;
  3 : begin str:=used_altapp; end;
  4 : begin str:=used_altapp4; end;
  end;

  if lbFav.Row <> -1 then
   begin
    for i:=lbFav.Selection.top to lbFav.Selection.Bottom do begin
  process:=TASyncProcess.Create(nil);
  process.CommandLine:=str+' magnet:?xt=urn:btih:'+lbFav.Cells[3, i]+add_tr;
  if debug then ShowMessage(process.CommandLine);
  process.Execute();
  process.Free; end;
   end;

end;

procedure TfmMain.dbToApp(app_index: integer);
var process: TAsyncProcess;
    str : string;
    i : Integer;
    add_tr : String;
begin

  if sqlGrid.SelectedRows.Count=0 then exit;
  add_tr:=getTrList();
  str:=used_app;
  case app_index of
  1 : begin str:=used_app; end;
  2 : begin str:=used_vplayer; end;
  3 : begin str:=used_altapp; end;
  4 : begin str:=used_altapp4; end;
  end;
         for i:=0 to sqlGrid.SelectedRows.Count-1 do
            begin
               sqlGrid.DataSource.DataSet.GotoBookmark(
               sqlGrid.SelectedRows.Items[i]
               );
              process:=TASyncProcess.Create(nil);
              process.CommandLine:=str+' magnet:?xt=urn:btih:'+sqlGrid.SelectedField.DataSet.FieldByName('hash').AsString+add_tr;
              if debug then ShowMessage(process.CommandLine);
              process.Execute();
              process.Free;
            end;
end;

procedure TfmMain.colorize;
var i : Integer;
begin
  if not chkCustomColors.Checked then Exit;
  if chkColorize.Checked then
     begin
       for i:=0 to fmMain.ControlCount-1 do
           begin
             fmMain.Controls[i].Font.Color:=clRed-200;
             fmMain.Controls[i].Color:=clRed-78;
           end;
       sqlGrid.Font.Color:=clRed;
       lbFav.Font.Color:=sqlGrid.Font.Color;
       sqlGrid.Color:=clRed-78;
       lbFav.Color:=sqlGrid.Color;
       sqlGrid.AlternateColor:=clRed-200;
       lbFav.AlternateColor:=sqlGrid.AlternateColor;
     end
     else
     begin
              for i:=0 to fmMain.ControlCount-1 do
           begin
             fmMain.Controls[i].Font.Color:=clBlue+78;
             fmMain.Controls[i].Color:=clWhite;
           end;
     sqlGrid.Font.Color:=clBlack;
     lbFav.Font.Color:=sqlGrid.Font.Color;
     sqlGrid.Color:=clWhite-100;
     lbFav.Color:=sqlGrid.Color;
     sqlGrid.AlternateColor:=clWhite-200;
     lbFav.AlternateColor:=sqlGrid.AlternateColor;
     end;
  sqlGrid.Repaint;
end;

procedure TfmMain.rq;
var sql : String; do_rq : boolean;
begin

  do_rq:=true;

  md.category:='';
  if chkCategory.Checked then md.category:=edCategory.text;


  if (warn_empty_category) and (md.category='') and (not chkSearchOnChange.checked) then
    begin
         do_rq:=(mrOK = MessageDlg(
// TODO localize messages
 get_msg('msgNeedConfirmation', used_lang, 'Требуется подтверждение...'),
 get_msg('msgCategoryNotSelected', used_lang, 'Категория не выбрана, поиск может потребовать много времени. Все равно продолжить?'),
 mtInformation,
 [mbOK, mbCancel], ''));
    end;

  md.labels:='';
  if chkLabel.Checked then md.labels:=edLabels.text;


  lbPage.Caption:=IntToStr(md.page);
  if edCaption.text='' then
     begin
       md.where_value:='';
       md.search_field:='caption';
       md.search();
       exit;
     end;



//  if do_rq then
//     begin
   md.search_field:='caption';
  md.where_value:=edCaption.text;
  sql:=md.search();
  log(lgMmDebug, sql);
  log(lgMmDebug, 'rq switch off tmSQL');
  tmSQL.Enabled:=FALSE;
//     end;
end;

procedure TfmMain.disconnect;
begin
   chkSearchOnChange.Checked:=false;
   tmSQL.Enabled:=false;
   md.disconnect();
end;

procedure TfmMain.connect_again;
begin

   md.init_db();
   md.connect();
   rq();
end;

procedure TfmMain.load_locale(lang : String);
begin

    localize(lang);

end;

procedure TfmMain.attrs_show;
begin
  panCategory.Visible:=lbAttrs.Checked;
  chkLabel.Visible:=lbAttrs.Checked;
  chkCategory.Visible:=lbAttrs.Checked;
  edLabels.Visible:=lbAttrs.Checked;
  edCategory.Visible:=lbAttrs.Checked;
  btPossibleLabels.Visible:=lbAttrs.Checked;
  btPossibleLabelsApply.Visible:=lbAttrs.Checked;
  possibleLabels.Visible:=lbAttrs.Checked;
end;

procedure TfmMain.open_browser(url: String);
var

 BrowserPath : string;
 BrowserProcess: TProcessUTF8;
 Inif : TIniFile;
// browser : TfmBrowser;
begin
(*  if use_external_browser then
      begin *)
   Inif:=TIniFIle.Create(ss);
   BrowserPath :=  Inif.readString('browser', 'use', '/usr/bin/firefox');
   BrowserProcess:=TProcessUTF8.Create(nil);
   Inif.Free;
   try
     BrowserProcess.CommandLine:=BrowserPath+' '+url;
     BrowserProcess.Execute;
   finally
     BrowserProcess.Free;
   end;
(*      end
  else
      begin
           browser:=TfmBrowser.Create(nil);
           browser.Show;

      end;         *)
end;

procedure TfmMain.open_search_engine(source: byte; index: byte);
var url, q : String; Inif : TIniFile;
begin
  q:='';
  case source of
  0 : q:=sqlGrid.SelectedField.DataSet.FieldByName('Caption').AsString;
  1 : q:=lbFav.Rows[lbFav.Row].Strings[1];
  2:  q:=edCaption.Text;
  end;

  q:=StringReplace(q, ' ' , '%20', [rfReplaceAll, rfIgnoreCase]);

  Inif:=TIniFile.Create(ss);
  url:=Inif.ReadString('searchengines', 'searchengine'+IntToStr(index), '127.0.0.1');
  Inif.Free;
  url:=url+q;
  open_browser(url);
end;

procedure TfmMain.set_font_size(fs: Integer);
begin
  sqlGrid.Font.Size:=fs;
  sqlGrid.DefaultRowHeight:=fs+4;
  lbFav.Font.Size:=fs;
  lbFav.DefaultRowHeight:=fs+4;
  ccCategory.Font.Size:=fs;
end;

procedure TfmMain.startApp;
var Inif : TIniFIle; i : integer;
begin

md:=tmagnets_entity.create;
md.filename:='main-sqlite.db';
md.table:='data';
md.sorting := false;
md.init_db();
md.connect();
sqlGrid.DataSource:=md.dsSQL;
Inif:=TIniFile.Create(ss);
m := NIL;
m := TfmInit.Create(Self);
m.Show;
m.m('init started...');
mmDebug.Visible:=debug;
chkCustomColors.Visible:=not disable_features;
chkColorize.Visible:=not disable_features;
md.mode:=0;
md.page := 1;
md.sorting_field:='Caption';
user_fav.load_fav(lbFav);
user_history.loadusersearches(edCaption);
// TODO change loading categories
if not FileExists('categories.txt') then reindex();
ccCategory.Items.loadfromfile('categories.txt');
ccCategory.ItemIndex:=0; // select first category
CategoriesFullList:=TStringList.Create();

For I:=0 to ccCategory.Items.Count-1 do
         CategoriesFullList.Add(ccCategory.Items[i]);

CategoriesFullList.Sorted:=True;

initapplication();
attrs_show();

 if Inif.ReadBool('sql', 'restore_request', false) then
    rq();

 Inif.Free;
end;

procedure TfmMain.stopApp;
begin
  save_settings_to_ini();
  user_history.saveusersearches(edCaption);
  user_history.save_labels(edLabels);
  user_fav.save_fav(lbFav);
  if m<>NIL then
     begin
       m.Hide;
       m.Release;
       m.Free;
       m:=NIL;
     end;
   FreeAndNil(CategoriesFullList);
end;

procedure TfmMain.reloadApp;
begin
  startApp();
  stopApp();
end;

procedure TfmMain.do_action_on_start();
var
    f : tfmAddmagnet;
    process : TASyncProcess;
    tmd : TMagnets_Entity;
begin
  if action_to_do='add' then
      begin
           f:=tfmAddmagnet.Create(self);
           ClipBrd.Clipboard.AsText:=inserted_link;
           f.fcategory:='INCOMING';
           f.fcaption:='auto_'+DateTimeToStr(Now());
           f.flabels:='incoming';
           f.valuestogui();
           f.btInsertHashClick(self);
           f.showmodal;
           if f.ModalResult = mrOK then
               begin
                       disconnect();
                       tmd:=TMagnets_Entity.Create();
                       tmd.tear();
                       if tmd.getCount('hash', f.fhash) > 0 then
                          showmessage('Hash was found!')
                       else
                       begin
                       tmd.caption:=edCaption.text;
                       tmd.category:=f.fcategory;
                       tmd.labels:=f.flabels;
                       tmd.hash:=f.fhash;
                       f.valuesfromgui();
                       tmd.insert();
                       end;
                       tmd.free_it();
                       tmd.free();
                       connect_again();
                       rq();
                       if MessageDlg('Launch handler?',mtCustom, [mbOK,mbCancel], 0)=mrOK then
                            begin
                       process:=TASyncProcess.Create(nil);
                       process.CommandLine:=used_app+' magnet:?xt=urn:btih:'+f.fhash;
                       //ShowMessage(process.CommandLine);
                       process.Execute();
                       process.Free;
                            end;

               end;
           f.release;
           f.free;
           action_to_do:='';
      end;
end;

procedure TfmMain.prevpageaction;
begin
  if md.page>1 then md.page:=md.page-1;
  if md.page=1 then btPrevPage.Enabled:=false;
  rq();
end;

procedure TfmMain.nextpageaction;
begin
  if md.page>0 then btPrevPage.Enabled:=True;
  md.page:=md.page+1;
  rq();
end;

procedure TfmMain.tofirstpage;
begin
  btPrevPage.Enabled:=False;
  md.page:=1;
  rq();
end;

function TfmMain.getTrList: String;
var
    add_tr : String;
    i  : Byte;
    tr : TStringList;
begin
  add_tr:='';
  if fileExists('tr.txt') then
   begin
        tr := TStringList.Create();
        tr.LoadFromFile('tr.txt');
        for i:=0 to tr.Count-1 do
                 add_tr:=add_tr + '&tr='+tr.Strings[i];
        tr.Free;
   end
  else
   add_tr:='&tr=http://retracker.local/announce';
    Result:=add_tr;
end;



procedure TfmMain.initsettings;
var
   IniF:TINIFile;
   i : Byte;
   qq : TMemo;

begin
  loading_checkboxes:=false;
  IF not FileExists(ss) then
  begin
    Inif := TINIFile.Create(ss);

    // handlers


    Inif.WriteString('general', 'reindex', 'NO');
    Inif.WriteBool('browser', 'external', true);
    // Use external or internal browser?

    Inif.WriteString('general', 'app', DefaultApps[version, ixHandler0]);
    Inif.WriteString('general', 'vplayer', DefaultApps[version, ixHandler1]);
    Inif.WriteString('general', 'altapp', DefaultApps[version, ixHandler2]);
    Inif.WriteString('general', 'altapp4', DefaultApps[version, ixHandler3]);

    // columns width
    Inif.WriteString('general', 'c0', '24');
    Inif.WriteString('general', 'c1', '32');
    Inif.WriteString('general', 'c2', '450');
    Inif.WriteString('general', 'c3', '32');
    Inif.WriteString('general', 'c4', '32');


    Inif.WriteString('general', 'f0', '24');
    Inif.WriteString('general', 'f1', '32');
    Inif.WriteString('general', 'f2', '450');


    Inif.WriteString('general', 'lw', '150');
    Inif.WriteString('general', 'rw', '150');
    // main app form
    Inif.WriteString('general', 'aw', '600'); // minimal
    Inif.WriteString('general', 'ah', '400');
    //Inif.WriteString('general', 'al', '0');
    //Inif.WriteString('general', 'at', '0');
    Inif.WriteString('general', 'fs', '14'); // font size
    Inif.WriteString('general', 'nightmode', 'NO'); // nightmode
    // TODO : make color customization
(*
    Inif.WriteString('ui', 'textcolor0', inttostr(clBlack));
    Inif.WriteString('ui', 'textcolor1', inttostr(clWhite));

    Inif.WriteString('ui', 'bgcolor0', inttostr(clWhite));
    Inif.WriteString('ui', 'bgcolor1', inttostr(clBlack));

    *)


    // panel visibility
    Inif.WriteString('general', 'lp', 'YES');
    Inif.WriteString('general', 'rp', 'YES');
    Inif.WriteString('general', 'bp', 'YES');

    Inif.WriteString('general', 'locale', '');

    Inif.WriteString('controls', 'caption', 'test');
    Inif.WriteString('controls', 'labels', 'test');
    Inif.WriteString('controls', 'category', 'test');
    Inif.WriteBool('controls','chkcategory',true);
    Inif.WriteBool('controls','chklabel',false);
    Inif.WriteBool('sql', 'restore_request', true);
    Inif.WriteInteger('sql','page', md.page);

    // search engines
    for i:=0 to search_engines_count-1 do
        Inif.WriteString('searchengines',
                                         'searchengine'+IntToStr(i+1),
                                          hardcoded_se[i]);

    // browser
    if version = 0 then
    Inif.WriteString('browser', 'use', '/usr/bin/firefox')
    else
    Inif.WriteString('browser', 'use', 'C:\Program Files (x86)\Mozilla Firefox\firefox.exe');


    // importer
    if version = 0 then
    Inif.WriteString('importer', 'path', expandfilename('~/magnetsdb_importer_csv/magnetsdb_importer_csv'))
    else
    Inif.WriteString('importer', 'path', 'magnetsdb_importer_csv.exe');

    // confirm_delete
    Inif.WriteBool('confirmations', 'confirm_delete', false);

    // warn about empty category
    Inif.WriteBool('confirmations', 'warn_empty_category', true);

    // updater
    Inif.WriteString('updater', 'magic', magic);

    Inif.Free;

  End;


  if Not FileExists(plFilename) then
    begin
      qq:=TMemo.Create(Self);
      qq.Clear;
      qq.Lines.Add('RUS');
      qq.Lines.Add('ENG');
      qq.Lines.SaveToFile(plFilename);
      qq.Free;
    end;


end;

procedure TfmMain.save_settings_to_ini;
var IniF:TINIFile;// Класс для работы с INI-файлами
  bs : String;
  k : Integer;
begin
    Inif := TINIFile.Create(ss);
     // columns width
     // main table
     for k:=0 to 3 do
     Inif.WriteString('general', 'c'+IntToStr(k),  IntToStr(sqlGrid.Columns[k].Width));
     // bookmarks
      for k:=0 to 3 do
     Inif.WriteString('general', 'f'+IntToStr(k),  IntToStr(lbFav.Columns[k].Width));

     Inif.WriteString('general', 'lw', IntToStr(fmMain.leftPanel.Width));
     Inif.WriteString('general', 'rw', IntToStr(fmMain.rightPanel.Width));

     Inif.WriteString('general', 'aw', IntToStr(fmMain.Width));
     Inif.WriteString('general', 'ah', IntToStr(fmMain.Height));
     //Inif.WriteString('general', 'at', IntToStr(fmMain.Top));
     //Inif.WriteString('general', 'al', IntToStr(fmMain.Left));
     //Inif.WriteString('general', 'fs', IntToStr(tbFontSize.Position));
     bs:='NO';
     if chkColorize.Checked then bs:='YES';
     Inif.WriteString('general', 'nightmode', bs);

    // panel visibility

    bs := 'NO';
    if fmMain.leftPanel.visible then bs := 'YES';
    Inif.WriteString('general', 'lp', bs);

    bs := 'NO';
    if fmMain.rightPanel.visible then bs := 'YES';
    Inif.WriteString('general', 'rp', bs);

    bs := 'NO';
    if fmMain.bottomPanel.visible then bs := 'YES';
    Inif.WriteString('general', 'bp', bs);

    // save state of checkboxes
    Inif.WriteString('controls', 'caption', edCaption.Text);
    Inif.WriteString('controls', 'labels', edLabels.Text);
    Inif.WriteString('controls', 'category', edCategory.Text);
    Inif.WriteBool('controls', 'chkcategory', chkCategory.Checked);
    Inif.WriteBool('controls', 'chklabel', chkLabel.Checked);

    Inif.WriteInteger('sql', 'page', md.page);


    Inif.Free;

end;

procedure TfmMain.readsettings;
var
 inif : TIniFile;
 k : integer;
 fs : Integer;
 i, j  : integer;
 w  : TStringList;
begin

  IF (FileExists(ss))then
  begin
    m.m('File '+ss+' was found');
    Inif := TINIFile.Create(ss);
    used_app := Inif.readString('general', 'app', '');
    m.m('Reading used_app:'+used_app);
    used_vplayer := Inif.readString('general', 'vplayer', '');
    m.m('Reading vplayer:'+used_vplayer);
    used_altapp := Inif.readString('general', 'altapp', '');
    m.m('Reading altapp:'+used_altapp);
    used_altapp4 := Inif.readString('general', 'altapp4', '');
    m.m('Reading altapp4:'+used_altapp4);
    use_external_browser := Inif.readBool('browser', 'external', false);
    m.m('Reading use_external_browser:'+BoolToStr(use_external_browser));

     // columns width
     // main table
     for k:=0 to 3 do
     sqlGrid.Columns[k].Width:=StrToInt(Inif.ReadString('general', 'c'+IntToStr(k), '32'));
     m.m('Sql columns widths were readed');
     // bookmarks
     for k:=0 to 3 do
     lbFav.Columns[k].Width:=StrToInt(Inif.ReadString('general', 'f'+IntToStr(k), '32'));
     m.m('Bookmarks columns widths were readed');
    // panel visibility
    fmMain.leftPanel.visible:=Inif.ReadString('general', 'lp', 'YES')='YES';
    fmMain.rightPanel.visible:=Inif.ReadString('general', 'rp', 'YES')='YES';
    fmMain.bottomPanel.visible:=Inif.ReadString('general', 'bp', 'YES')='YES';
    m.m('Panels visibility was readed');

    fmMain.leftPanel.width:=StrToInt(Inif.ReadString('general', 'lw', '150'));
    fmMain.rightPanel.width:=StrToInt(Inif.ReadString('general', 'rw', '150'));
    // restore form
    //fmMain.Top:=StrToInt(Inif.ReadString('general', 'at', '0'));
    //fmMain.Left:=StrToInt(Inif.ReadString('general', 'al', '0'));
    fmMain.Width:=StrToInt(Inif.ReadString('general', 'aw', '600'));
    fmMain.Height:=StrToInt(Inif.ReadString('general', 'ah', '400'));
     m.m('Form width and height were readed');

    // font size
    fs:=StrToInt(Inif.ReadString('general', 'fs', '14'));
    tbFontSize.Position:=fs;
    set_font_size(fs);

    chkColorize.Checked:=Inif.ReadString('general', 'nightmode', 'NO')='YES';

    used_lang:=Inif.ReadString('general', 'locale', 'en');
    load_locale(used_lang);

    // load state of checkboxes
    m.m('Starts loading state of checkboxes');
    loading_checkboxes:=true;
    edCategory.text:=Inif.ReadString('controls', 'category', 'test');
    w:=TStringList.Create();
    w.clear;
    if edCategory.text<>'' then
      if Pos(';', edCategory.text)>0 then
        begin
          Split(';', edCategory.text, w);
          for i:=0 to ccCategory.Count-1 do
            for j:=0 to w.Count-1 do
           begin
                Application.ProcessMessages;
                if w.Strings[j]=ccCategory.Items[i] then
                  ccCategory.Checked[i]:=true;
           end;
        end;
   w.free;
   loading_checkboxes:=false;


   m.m('Loading state of checkboxes was ended');



    edCaption.text:=Inif.ReadString('controls', 'caption', 'test');
    edLabels.text:=Inif.ReadString('controls', 'labels', 'test');

    chkLabel.Checked:=Inif.ReadBool('controls', 'chklabel', false);
    chkCategory.Checked:=Inif.ReadBool('controls', 'chkcategory', false);

    pmAppHandler1.Caption:=pmAppHandler1.Caption+'('+used_app+')';
    pmAppHandler2.Caption:=pmAppHandler2.Caption+'('+used_vplayer+')';
    pmAppHandler3.Caption:=pmAppHandler3.Caption+'('+used_altapp+')';
    pmAppHandler4.Caption:=pmAppHandler4.Caption+'('+used_altapp4+')';


    FavHandler1.Caption:=FavHandler1.Caption+'('+used_app+')';
    FavHandler2.Caption:=FavHandler2.Caption+'('+used_vplayer+')';
    FavHandler3.Caption:=FavHandler3.Caption+'('+used_altapp+')';
    FavHandler4.Caption:=FavHandler4.Caption+'('+used_altapp4+')';

    for i:=0 to search_engines_count-1 do
      (fmMain.FindComponent('pmDbSearchEngine'+IntToStr(i+1)) as TMenuItem).Caption:=
      (fmMain.FindComponent('pmDbSearchEngine'+IntToStr(i+1)) as TMenuItem).Caption+
      '('+Inif.ReadString('searchengines', 'searchengine'+IntToStr(i+1), '127.0.0.1')+')';



    for i:=0 to search_engines_count-1 do
      (fmMain.FindComponent('FavSearchEngine'+IntToStr(i+1)) as TMenuItem).Caption:=
      (fmMain.FindComponent('FavSearchEngine'+IntToStr(i+1)) as TMenuItem).Caption+
      '('+Inif.ReadString('searchengines', 'searchengine'+IntToStr(i+1), '127.0.0.1')+')';

    for i:=0 to search_engines_count-1 do
      (fmMain.FindComponent('capSearchEngine'+IntToStr(i+1)) as TMenuItem).Caption:=
      (fmMain.FindComponent('capSearchEngine'+IntToStr(i+1)) as TMenuItem).Caption+
      '('+Inif.ReadString('searchengines', 'searchengine'+IntToStr(i+1), '127.0.0.1')+')';



   confirm_delete:=Inif.ReadBool('confirmations', 'confirm_delete', true);

   warn_empty_category:=Inif.ReadBool('confirmations', 'warn_empty_category', true);


   md.page:=Inif.ReadInteger('sql', 'page', 1);

   if md.page>1 then btPrevPage.Enabled:=true;

   updater_magic:=Inif.ReadString('updater', 'magic', magic);

   m.m('Read other parameters was completed');

  End;

  if FileExists(plFilename) then
     begin
          possibleLabels.Items.LoadFromFile(plFilename);
     end;

end;


procedure TfmMain.favClearAllClick(Sender: TObject);
begin
 user_fav.favClearAll(fmMain.lbFav);
end;

procedure TfmMain.favHandler1Click(Sender: TObject);
begin
  favToApp(1);
end;

procedure TfmMain.favHandler2Click(Sender: TObject);
begin
  favToApp(2);
end;

procedure TfmMain.favHandler3Click(Sender: TObject);
begin
  favToApp(3);
end;

procedure TfmMain.favHandler4Click(Sender: TObject);
begin
  favToApp(4);
end;

procedure TfmMain.btnClearUserHistoryClick(Sender: TObject);
var history_sql : TStringList;
 last_query : String;
begin
  user_history.clearUserHistory(fmMain.edCaption);
  user_history.clear_labels(fmMain.edLabels);
  if fileexists('sql.txt') then
     begin
       history_sql:=TStringList.Create;
       history_sql.LoadFromFile('sql.txt');
       last_query:=history_sql.Strings[history_sql.count-1];
       history_sql.clear;
       history_sql.Add(last_query);
       history_sql.SaveToFile('sql.txt');
       history_sql.Free;
     end;
end;

procedure TfmMain.btPossibleLabelsApplyClick(Sender: TObject);
var r : String; q, h, i, l : integer; C : char;
begin


         r:='';
         q:=-1;

       for i:=0 to possibleLabels.Count-1 do
          begin
               q:=q+1;
               C:=possibleLabels.items[i][1];
               l:=length(possibleLabels.Items[i]);
               if  (c = '+') or (c='-') then
                  begin
                       h:=0;
                       if c='+' then h:=1;
                       if q=0 then
                       r:=Copy(possibleLabels.items[i], 1+h, l)
                         else
                       r:=r+' '+Copy(possibleLabels.items[i], 1+h, l);
                  end;
          end;
      edLabels.text:=r;

end;

procedure TfmMain.btPossibleLabelsClick(Sender: TObject);
begin
  possibleLabels.Visible := not possibleLabels.Visible;
  btPossibleLabelsApply.Visible :=   possibleLabels.Visible;
end;

procedure TfmMain.btMultiSelectClick(Sender: TObject);
var i : integer;
begin
  if (ccCategory.Visible=false) and (ccCategory.items.Count=0) then
  begin
     ccCategory.clear;
     for i:=0 to ccCategory.items.Count-1 do
       ccCategory.Items.add(ccCategory.items[i]);
  end;
  ccCategory.Visible:=not ccCategory.Visible;
end;

procedure TfmMain.btPrevPageClick(Sender: TObject);
begin
  prevpageaction();
end;

procedure TfmMain.btNextPageClick(Sender: TObject);
begin
  nextpageaction();
end;

procedure TfmMain.btPrevSQLClick(Sender: TObject);
var
  history_sql : TStringList;
begin
  if fileExists('sql.txt') then
   begin
  history_sql:=TStringList.Create;
  history_sql.LoadFromFile('sql.txt');
   end;


  if ptr_history > 0 then ptr_history:=ptr_history-1;
  if ptr_history = 0 then
                 begin
                      ptr_history:=history_sql.Count-1;
                 end;
  md.sqlText:=history_sql.Strings[ptr_history];
  md.send_request();
end;

procedure TfmMain.capSearchEngine1Click(Sender: TObject);
begin
  open_search_engine(2, 1)
end;

procedure TfmMain.capSearchEngine2Click(Sender: TObject);
begin
  open_search_engine(2, 2)
end;

procedure TfmMain.capSearchEngine3Click(Sender: TObject);
begin
  open_search_engine(2, 3)
end;

procedure TfmMain.capSearchEngine4Click(Sender: TObject);
begin
  open_search_engine(2, 4)
end;

procedure TfmMain.capSearchEngine5Click(Sender: TObject);
begin
  open_search_engine(2, 5);
end;

procedure TfmMain.ccCategoryClickCheck(Sender: TObject);
var i : integer; r : String;
begin
  if loading_checkboxes then exit;
  r:='';
  for i:=0 to ccCategory.items.count-1 do
   if ccCategory.Checked[i] then
    begin
      if r='' then
        r:=ccCategory.Items[i]
      else
        r:=r+';'+ccCategory.Items[i];
    end;
  dontchangelist:=true;
  edCategory.text:=r;
  dontchangelist:=false;
end;

procedure TfmMain.ccCategoryDblClick(Sender: TObject);
var i : integer;
begin
  ccCategory.Clear;
  for i:=0 to CategoriesFullList.Count-1 do
    ccCategory.Items.Add(CategoriesFullList[i]);
end;

procedure TfmMain.ccCategoryItemClick(Sender: TObject; Index: integer);
begin
  //ccCategory.Checked[index]:=not ccCategory.Checked[index];
end;

procedure TfmMain.chkCategoryChange(Sender: TObject);
begin
  if chkSearchOnChange.checked then
     begin
          tmSQL.Enabled:=true;
     end
  else rq();
end;

procedure TfmMain.chkCustomColorsChange(Sender: TObject);
begin
  chkColorize.Enabled:=chkCustomColors.Checked;
  if chkCustomColors.Checked then colorize();
  // TODO: reset to default color scheme
end;

procedure TfmMain.chkLabelChange(Sender: TObject);
begin
 if chkSearchOnChange.checked then
   tmSQL.Enabled:=true
   else
  rq();
end;

procedure TfmMain.chkColorizeChange(Sender: TObject);
begin
  colorize();
  save_settings_to_ini();
end;

procedure TfmMain.chkSearchOnChangeChange(Sender: TObject);
begin
  if chkSearchOnChange.Checked then
   begin
   tmSQL.Enabled:=true;
   log(lgMmDebug, 'chkSearch switch on tmSQL');
   end
  else
   begin
   log(lgMmDebug, 'chkSearch switch off tmSQL');
   tmSQL.Enabled:=false;
   end;
end;

procedure TfmMain.chkStrictModeChange(Sender: TObject);
begin
  if chkStrictMode.checked then
     md.mode:=1
  else
     md.mode:=0;
end;

procedure TfmMain.dbDeleteClick(Sender: TObject);
var f : TfmDelete; i : integer;
  tmd : tmagnets_entity;
  dr  : array[byte, 0..3] of String;
  drC : byte;
  do_delete : boolean;
begin
  if sqlGrid.SelectedRows.Count = 0 then Exit;
  if sqlGrid.SelectedRows.Count = 1 then
  begin


 f:=TfmDelete.Create(Self);
 f.localize(used_lang);
 f.fCaption:=sqlgrid.Datasource.Dataset.FieldByName('caption').AsString;
 f.fCategory:=sqlgrid.Datasource.Dataset.FieldByName('category').AsString;
 f.fHash:=sqlgrid.Datasource.Dataset.FieldByName('hash').AsString;
 f.fLabels:=sqlgrid.Datasource.Dataset.FieldByName('labels').AsString;
 f.valuestogui();
 do_delete:=confirm_delete;
 if not do_delete then
    begin
     f.ShowModal;
     do_delete:=(f.ModalResult = mrOK);
    end;
 if do_delete then
  begin
       disconnect();
       tmd:=tmagnets_entity.create();
       tmd.tear();
       tmd.category:=f.fCategory;
       tmd.caption:=f.fCaption;
       tmd.labels:=f.fLabels;
       tmd.hash:=f.fHash;
       tmd.delete();
       tmd.free_it();
       tmd.free();
       connect_again();
       rq();
  end;

 f.Release;
 f.Free;

  exit;
  end;


  drC:=0;
  for i:=0 to sqlGrid.SelectedRows.Count-1 do
    begin
         sqlGrid.DataSource.DataSet.GotoBookmark(sqlGrid.SelectedRows.Items[i]);
         inc(drC);
         dr[drC-1, 0]:=sqlgrid.Datasource.Dataset.FieldByName('caption').AsString;
         dr[drC-1, 1]:=sqlgrid.Datasource.Dataset.FieldByName('category').AsString;
         dr[drC-1, 2]:=sqlgrid.Datasource.Dataset.FieldByName('labels').AsString;
         dr[drC-1, 3]:=sqlgrid.Datasource.Dataset.FieldByName('hash').AsString;
     end;

  for i:=0 to drC-1 do
  begin
 f:=TfmDelete.Create(Self);
 f.fCaption:=dr[i, 0];
 f.fCategory:=dr[i, 1];
 f.fLabels:=dr[i, 2];
 f.fHash:=dr[i, 3];
 f.valuestogui();
 do_delete:=confirm_delete;
 if not do_delete then
   begin
    f.ShowModal;
    do_delete:=(f.ModalResult = mrOK);
   end;
 if do_delete then
  begin
       disconnect();
       md.category:=f.fCategory;
       md.caption:=f.fCaption;
       md.labels:=f.fLabels;
       md.hash:=f.fHash;
       md.delete();
       connect_again();
  end;

 f.Release;
 f.Free;

    end;



end;

procedure TfmMain.dbEditClick(Sender: TObject);
var f : TfmEditor;
  ocaption, ocategory, olabels, ohash,
  ncaption, ncategory, nlabels, nhash : String;
  tmd : tmagnets_entity;
begin
 f:=TfmEditor.Create(Self);
 f.localize(used_lang);
 ocaption:=sqlgrid.DataSource.DataSet.FieldByName('caption').AsString;
 ocategory:=sqlgrid.DataSource.DataSet.FieldByName('category').AsString;
 olabels:=sqlgrid.DataSource.DataSet.FieldByName('labels').AsString;
 ohash:=sqlgrid.DataSource.DataSet.FieldByName('hash').AsString;

 with f do
      begin

      fcaption:=ocaption;
      fcategory:=ocategory;
      flabels:=olabels;
      fhash:=ohash;
      valuestogui();
      end;

 f.ShowModal;
 if f.ModalResult = mrOK then
  begin
      f.valuesfromgui();
      ncaption:=f.fcaption;
      ncategory:=f.fcategory;
      nlabels:=f.flabels;
      nhash:=f.fhash;
      disconnect();

      tmd := tmagnets_entity.create();
      tmd.tear;
      //showmessage('insert to db');
      tmd.old_category:=ocategory;
      tmd.old_caption:=ocaption;
      tmd.old_labels:=olabels;
      tmd.old_hash:=ohash;
      tmd.category:= ncategory;
      tmd.caption:= ncaption;
      tmd.labels:= nlabels;
      tmd.hash:= nhash;
      tmd.update();
      tmd.free_it();
      tmd.free();
      //showmessage('repeat last request');
      // connect again
      connect_again();
      rq();
  end;
 f.Release;
 f.Free;
end;

procedure TfmMain.dbImportClick(Sender: TObject);
var f : TfmImport; p : TProcessUTF8; inif : TIniFile;
  importer_tool : String;
begin

 inif:=TIniFile.Create('settings.ini');
 importer_tool:=expandfilename(inif.ReadString('importer', 'path', '~/magnetdb_importer_csv/magnetsdb_importer_csv'));
 f:=TfmImport.Create(Self);
 f.localize(used_lang);
 f.ShowModal;
 if f.ModalResult = mrOK then
  begin
     importer_tool:=importer_tool+' '+f.get_tool_params();
     p:=TProcessUTF8.Create(nil);
     p.Executable := '/bin/sh';
     p.Parameters.Add('-c');
     p.Parameters.add(importer_tool);
     p.Options:=[poWaitOnExit];
     p.Execute;
     p.Free;
  end;
 f.Release;
 f.Free;
end;

procedure TfmMain.dbReindexClick(Sender: TObject);
var Inif : TIniFile;
begin
   stopApp();
   Inif:=TIniFile.Create('settings.ini');
   Inif.WriteString('general', 'reindex', 'YES');
   Inif.Free;
   reindex();
   startApp();
end;

procedure TfmMain.edCaptionChange(Sender: TObject);
begin
  if not chkSearchOnChange.Checked then Exit;
  if edCaption.Text<>last_caption then
       tmSQL.Enabled:=true;
end;

procedure TfmMain.edCaptionKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  searchonenterkey(Key);
end;

procedure TfmMain.edCategoryChange(Sender: TObject);
var i : integer;
begin

  if not chkSearchOnChange.Checked then Exit
  else
  begin
  if chkCategory.Checked then
     begin
       log(lgMmDebug, 'edCategory switch on tmSQL');
       if not tmSQL.Enabled then tmSQL.Enabled:=True;
     end
   else
     begin
     tmSQL.Enabled:=False;
     rq();
     end;
  end;

end;

procedure TfmMain.edCategoryEditingDone(Sender: TObject);
var

Filter: string;
i, j: Integer;
w : TStringList;
begin
 if dontchangelist then exit;
       Filter := edCategory.Text;
  w:=TStringList.Create();
  w.clear;
  if Pos(';', Filter)>0 then
          Split(';', Filter, w)
  else
    w.add(Filter);
  //w.SaveToFile('lines.txt');
  if Length(Filter)>0 then
begin
     ccCategory.Items.Clear;
//     edCategory.DroppedDown := True;
 if (w.count>=1) and (CategoriesFullList.Count>=1) then
   for j:=0 to w.Count-1 do
     for i := 0 to CategoriesFullList.Count - 1 do
       if Pos(UpperCase(w.Strings[j]), UpperCase(CategoriesFullList[i]))<>0 then
           ccCategory.Items.Add(CategoriesFullList[i]);

end;
 w.Free;
(*else
begin
    edCategory.Items.Clear;
    for i := 0 to CategoriesFullList.Count - 1 do
     edCategory.Items.Add(CategoriesFullList[i]);
end;*)

//edCategory.DroppedDown:=(edCategory.Items.Count<>0) and (Length(edCategory.Text)<>0);
edCategory.Text:=Filter;
edCategory.SelStart:=Length(edCategory.Text);
ccCategory.Hint:=IntToStr(ccCategory.Items.Count);
end;

procedure TfmMain.edCategoryKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  searchonenterkey(Key);
end;

procedure TfmMain.edCategorySelect(Sender: TObject);
begin
  rq();
end;

procedure TfmMain.edLabelsChange(Sender: TObject);
begin
  if not chkSearchOnChange.Checked then Exit;
  if chkLabel.Checked then
     begin
      if length(edLabels.text)>=5 then
         begin
           log(lgMmDebug, 'edLabels switch on tmSQL');
           tmSQL.Enabled:=true;
         end
      end
  else begin
      log(lgMmDebug, 'edLabels switch off tmSQL');
      tmSQL.Enabled:=false;
  end;
end;

procedure TfmMain.edLabelsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  searchonenterkey(Key);
end;

procedure TfmMain.favRemoveItemClick(Sender: TObject);
begin
 user_fav.remove_fav(fmMain.lbFav);
end;

procedure TfmMain.FavSearchEngine1Click(Sender: TObject);
begin
  open_search_engine(1, 1);
end;

procedure TfmMain.FavSearchEngine2Click(Sender: TObject);
begin
  open_search_engine(1, 2);
end;

procedure TfmMain.FavSearchEngine3Click(Sender: TObject);
begin
    open_search_engine(1, 3);
end;

procedure TfmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  stopApp();
  if m<>NIL then
     begin
       m.Hide;
       m.Release;
       m.Free;
     end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
 m:=NIL;
 edCategory.Height:=panCategory.Height;
 chkCategory.Height:=panCategory.Height;

 edLabels.Height:=panOtherAttrs.Height;
 chkLabel.Height:=panOtherAttrs.Height;
 edCaption.Height:=panOtherAttrs.Height;
 startApp();
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
   if vk_F1 = Key then
        open_browser(url_sitereadme);
  if vk_F2 = Key then
     tofirstpage();
  if vk_F3 = Key then
     mnuViewSingle.Click;
  if vk_F4 = Key then
     dbEdit.Click;
  if vk_F5 = Key then
     prevpageaction();
  if vk_F6 = Key then
     nextpageaction();
  if (vk_F7 = Key) and sqlGrid.Focused then
    pmappHandler1.Click;
  if (vk_F7 = Key) and lbFav.Focused then
    FavHandler1.Click;
  if (vk_F8 = Key) and sqlGrid.Focused then
     dbDelete.Click;
  if (vk_F8 = Key) and lbFav.Focused then
     favRemoveItem.Click;
  if vk_F9 = Key then
     pmAddToFav.Click;
  if (vk_F10 = Key) and sqlGrid.Focused then
     pmDbSearchEngine1.Click;
  if (vk_F10 = Key) and lbFav.Focused then
     favSearchEngine1.Click;
  if vk_F11 = Key then
     begin
     lbAttrs.Checked:=True;
     chkCategory.Show;
     edCategory.Show;
     edCategory.SetFocus;
     //edCategory.DroppedDown:=True;
     end;
  if (vk_Insert = Key) and not (ssAlt in Shift) then
     pmAddRecord.Click;
  if (vk_Insert = Key) and (ssAlt in Shift) then
      dbImport.Click;
end;

procedure TfmMain.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TfmMain.FormResize(Sender: TObject);
begin
  resize_columns_of_grids();
end;

procedure TfmMain.lbAttrsChange(Sender: TObject);
begin
  attrs_show();
end;

procedure TfmMain.lbFavDblClick(Sender: TObject);
begin
  favToApp(1);
end;

procedure TfmMain.lbFavHeaderSized(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
begin
  resize_columns_of_grids();
end;

procedure TfmMain.mnuGetBaseClick(Sender: TObject);
var
 process : TAsyncProcess;
 str : String;
begin
  str:=used_app;
  process:=TASyncProcess.Create(nil);
  process.CommandLine:=str+' magnet:?xt=urn:btih:'+updater_magic;
  //ShowMessage(process.CommandLine);
  process.Execute();
  process.Free;
end;

procedure TfmMain.mnuHelpHotkeysClick(Sender: TObject);
var f : TfmGrid; i : integer;
begin
  f := TfmGrid.Create(self);
  f.clear;
  f.add('F1', 'Open website of app');
  f.add('F2', 'Goes to the first page');
  f.add('F3', 'View single record');
  f.add('F4', 'Edit one record');
  f.add('F5', 'Goes to the prev. page');
  f.add('F6', 'Goes to the next page');
  f.add('F7', 'Send to the first handler');
  f.add('F8', 'Delete');
  f.add('F9', 'Add to bookmarks');
  f.add('F10', 'Search using search engine 1');
  f.add('F11', 'Goes to the categories selectbox');
  f.add('Ins', 'Add record');
  f.add('Alt+Ins', 'Import records');
  f.showmodal;
  f.Release;
  f.Free;
end;

procedure TfmMain.mnuHelpWebSiteClick(Sender: TObject);
begin
  open_browser(url_sitereadme);
end;

procedure TfmMain.mnuLocalizationClick(Sender: TObject);
var f : TfmIniEditor;
 thefilename : String;
begin
     thefilename:=InputBox('Localization...', 'Filename:', 'en.ini');
     if FileExists(thefilename) then
         begin
          f:=TfmIniEditor.Create(Self);
          f.filename:=thefilename;
          f.load();
          f.ShowModal;
          reloadApp();
          f.Hide;
          f.Release;
          f.Free;
        end;
end;

procedure TfmMain.mnuSettingsClick(Sender: TObject);
var f : TfmIniEditor;
begin
 f:=TfmIniEditor.Create(Self);
 f.filename:=ss;
 f.load();
 f.ShowModal;
 reloadApp();
 f.Hide;
 f.Release;
 f.Free;
end;

procedure TfmMain.mnuTrListClick(Sender: TObject);
var f : TfmIniEditor;
  t : TextFile;
begin
 f:=TfmIniEditor.Create(Self);
 f.filename:='tr.txt';
 if not fileexists(f.filename) then
        begin
          AssignFile(t, 'tr.txt');
          Rewrite(t);
          Writeln(t, 'http://retracker.local/announce');
          CloseFile(t);
        end;
 f.load();
 f.ShowModal;
 reloadApp();
 f.Hide;
 f.Release;
 f.Free;
end;

procedure TfmMain.mnuViewSingleClick(Sender: TObject);
var f : TfmViewSingle;
begin
 f:=TfmViewSingle.Create(self);
 f.localize(used_lang);
 with f do
      begin

      fcaption:=sqlgrid.DataSource.DataSet.FieldByName('caption').AsString;
      fcategory:=sqlgrid.DataSource.DataSet.FieldByName('category').AsString;
      flabels:=sqlgrid.DataSource.DataSet.FieldByName('labels').AsString;
      fhash:=sqlgrid.DataSource.DataSet.FieldByName('hash').AsString;
      valuestogui();
      end;
 f.ShowModal;
 f.Release;
 f.Free;

end;

procedure TfmMain.mnuViewSqlClick(Sender: TObject);
var f : TfmIniEditor;
  t : TextFile;
begin
 f:=TfmIniEditor.Create(Self);
 f.filename:='sql.txt';
 if not fileexists(f.filename) then
        begin
          AssignFile(t, 'sql.txt');
          Rewrite(t);
          Writeln(t, 'SELECT * FROM data WHERE category="test" ORDER BY category ASC OFFSET 0 LIMIT 10');
          CloseFile(t);
        end;
 f.load();
 f.ShowModal;
 reloadApp();
 f.Hide;
 f.Release;
 f.Free;
end;

procedure TfmMain.pmAddRecordClick(Sender: TObject);
var f : TfmAddMagnet; tmd : tmagnets_entity;
begin



 f:=TfmAddMagnet.Create(Self);
 f.localize(used_lang);
 f.fcategory:=edCategory.text;
 f.fcaption:=DateTimeToStr(Now());
 f.flabels:='user';
 f.valuestogui();
 f.ShowModal;
 if f.ModalResult  = mrOK then
    begin
      // TODO: INSERT REQUEST to database
      // disconnect
      disconnect();

      //showmessage('insert to db');

      tmd:=TMagnets_Entity.Create();
      tmd.tear();
      f.valuesfromgui();
      if tmd.getCount('hash', f.fhash) > 0 then
          showmessage('Hash was found!')
                       else
      begin
      tmd.category:=f.fcategory;
      tmd.caption:=f.fcaption;
      tmd.labels:=f.flabels;
      tmd.hash:=f.fhash;
      tmd.query.close;
      tmd.insert();
      end;
      tmd.free_it();
      tmd.free();
      //showmessage('repeat last request');
      // connect again
      connect_again();
      rq();
    end;
 f.Hide;
 f.Release();
end;

procedure TfmMain.pmAddToFavClick(Sender: TObject);
var i  : Integer;
begin
  if sqlGrid.SelectedRows.Count = 0 then Exit;
  if sqlGrid.SelectedRows.Count = 1 then
  begin
  user_fav.add_fav(
  sqlGrid.DataSource.DataSet.FieldByName('Category').AsString,
  sqlGrid.DataSource.DataSet.FieldByName('Caption').AsString,
  sqlGrid.DataSource.DataSet.FieldByName('Labels').AsString,
  sqlGrid.DataSource.DataSet.FieldByName('Hash').AsString,
  fmMain.lbFav);
  exit;
  end;

  for i:=0 to sqlGrid.SelectedRows.Count-1 do
    begin
           sqlGrid.DataSource.DataSet.GotoBookmark(sqlGrid.SelectedRows.Items[i]);
             user_fav.add_fav(
  sqlGrid.DataSource.DataSet.FieldByName('Category').AsString,
  sqlGrid.DataSource.DataSet.FieldByName('Caption').AsString,
  sqlGrid.DataSource.DataSet.FieldByName('Labels').AsString,
  sqlGrid.DataSource.DataSet.FieldByName('Hash').AsString,
  fmMain.lbFav);

    end;

end;

procedure TfmMain.pmAppHandler2Click(Sender: TObject);
begin
  dbToApp(2);
end;

procedure TfmMain.pmAppHandler3Click(Sender: TObject);
begin
  DbToApp(3);
end;

procedure TfmMain.pmAppHandler4Click(Sender: TObject);
begin
    DbToApp(4);
end;

procedure TfmMain.pmDbSearchEngine1Click(Sender: TObject);
begin
  open_search_engine(0, 1);
end;

procedure TfmMain.pmDbSearchEngine2Click(Sender: TObject);
begin
  open_search_engine(0, 2);
end;

procedure TfmMain.pmDbSearchEngine3Click(Sender: TObject);
begin
  open_search_engine(0, 3);
end;

procedure TfmMain.pmDbSelectAllClick(Sender: TObject);
begin
// TODO: Select all feature
end;

procedure TfmMain.pmAppHandler1Click(Sender: TObject);
begin
  dbToApp(1);
end;

procedure TfmMain.pmInsertHashClick(Sender: TObject);
begin

end;

procedure TfmMain.PopupNotifier1Close(Sender: TObject;
  var CloseAction: TCloseAction);
begin

end;

procedure TfmMain.possibleLabelsClick(Sender: TObject);
begin

end;

procedure TfmMain.possibleLabelsDblClick(Sender: TObject);
var p : Integer; l : Integer; c : char;
begin
 p:=possibleLabels.ItemIndex;
 l:=Length(possibleLabels.Items[p]);
 c:=possibleLabels.Items[p][1];
 if p = -1 then exit;
   if (c <> '+') and (c<> '-') then
         possibleLabels.Items[p]:= '-' +  possibleLabels.Items[p]
  else
      if c = '-' then
          possibleLabels.Items[p]:= '+' +  Copy (  possibleLabels.Items[p], 2, Length(possibleLabels.Items[p]))
  else
      if c ='+' then
          possibleLabels.Items[p]:= Copy (  possibleLabels.Items[p], 2, Length(possibleLabels.Items[p]));


end;

procedure TfmMain.possibleLabelsDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var c : Char;
begin
 c:=possibleLabels.Items[Index][1];
 case c of
      '-' :   begin
    possibleLabels.Canvas.Brush.Color := clRed;
    possibleLabels.Canvas.Pen.Color:=clRed;
    possibleLabels.Canvas.Font.Color := clRed;
               end;
            '+' :   begin
    possibleLabels.Canvas.Brush.Color := clGreen;
    possibleLabels.Canvas.Pen.Color:=clGreen;
    possibleLabels.Canvas.Font.Color := clGreen;
               end;
      else
      begin

      end;
 end;



possibleLabels.Canvas.FillRect(ARect);
possibleLabels.Canvas.TextRect(ARect, ARect.Left + 2, ARect.Top + 2, possibleLabels.Items[Index])
end;


procedure TfmMain.rightPanelClick(Sender: TObject);
begin

end;

procedure TfmMain.Splitter1Moved(Sender: TObject);
begin

 resize_columns_of_grids();

end;

procedure TfmMain.Splitter2Moved(Sender: TObject);
begin
  resize_columns_of_grids;
end;

procedure TfmMain.sqlGridColumnSized(Sender: TObject);
begin
  resize_columns_of_grids();
end;

procedure TfmMain.sqlGridDblClick(Sender: TObject);
begin
  dbToApp(1);
end;




procedure TfmMain.sqlGridTitleClick(Column: TColumn);
var k : Integer;
begin
  md.sorting:=not md.sorting;
  md.sorting_field:='Caption';
  case column.ID of
  0 : begin  md.sorting_field:='Category'; end;
  1 : begin  md.sorting_field:='Caption'; end;
  2 : begin  md.sorting_field:='Labels'; end;
  3 : begin  md.sorting_field:='Hash'; end;
  end;
  //page:=1;
  rq();

  for k:=0 to 3 do
    if column.id = k then
     sqlGrid.Columns[k].Title.Font.Style:=[fsBold]
    else
     sqlGrid.Columns[k].Title.Font.Style:=[];


end;

procedure TfmMain.tbFontSizeChange(Sender: TObject);
begin
  set_font_size(tbFontSize.Position);
  save_settings_to_ini();
end;

procedure TfmMain.Timer1Timer(Sender: TObject);
var f : TextFile; s : String; d : tfmAddMagnet;
begin
  if fileexists('inserted_hash.txt') then
     begin
          timer1.Enabled:=false;
          assignfile(f, 'inserted_hash.txt');
          reset(f);
          readln(f, s);
          closefile(f);

          deletefile('inserted_hash.txt');

           d:=tfmAddMagnet.Create(Self);
           ClipBrd.Clipboard.AsText:=s;
           d.valuestogui();
           d.btInsertHashClick(self);
           d.showmodal;
           if d.modalresult = mrOK then
            begin
                   disconnect();

                   md.category:=d.fcategory;
                   md.caption:=d.fcaption;
                   md.labels:=d.flabels;
                   md.hash:=d.fhash;
                   md.insert();
                       connect_again();    end;
           d.free;
           timer1.Enabled:=true;
     end;

  if fileexists('sql.txt') then
     btPrevSQL.Enabled:=true
  else
      btPrevSQL.Enabled:=false;
end;



procedure TfmMain.tmSQLTimer(Sender: TObject);
begin
  log(lgMmDebug, 'tmSQL enter');

  if (last_caption<>edCaption.Text)
     or
     (last_labels<>edLabels.Text)
     or
     (last_category<>edCategory.Text) then
     begin
           last_caption:=edCaption.text;
           last_labels:=edLabels.text;
           last_category:=edCategory.Text;
           log(lgMmDebug, 'last caption:'+last_caption);
           log(lgMmDebug, 'last category:'+last_category);
           log(lgMmDebug, 'last labels:'+last_labels);
           log(lgMmDebug, 'tmSQL prepare SQL');
           rq();
           log(lgMmDebug, 'tmSQL called SQL');
           Application.ProcessMessages;
           log(lgMmDebug, 'tmSQL call processing messages');
     end
  else
    log(lgMmDebug, 'tmSQL: nothing done!');
    log(lgMmDebug, '...tmSQL exit');
  if mmDebug.Lines.Count>250 then mmDebug.Clear;
end;

procedure TfmMain.searchonenterkey(Key : Word);
  var do_rq : Boolean;
begin
  if chkSearchOnChange.Checked then Exit;
  if (Key = vk_return) then
     begin
       do_rq:=false;
       do_rq:=do_rq or (edCaption.Focused);
       do_rq:=do_rq or (edCategory.Focused);
       do_rq:=do_rq or (edLabels.Focused);
       if do_rq then
                    rq();
       user_history.save_request_to_history(edCaption);
       if chkLabel.Checked then
            user_history.add_label(edLabels);
     end;
end;

procedure TfmMain.resize_columns_of_grids;
var i : 0..3;
begin

 for i:=0 to 3 do
    begin
        if lbFav.Columns[i].Width>(fmMain.Width div 4) then
            lbFav.Columns[i].Width:=fmMain.Width div 4;
        if sqlGrid.Columns[i].Width>(fmMain.Width div 4) then
             sqlGrid.Columns[i].Width:=fmMain.Width div 4;
        if sqlGrid.Columns[i].Width<40 then
           sqlGrid.Columns[i].Width:=40;
        if lbFav.Columns[i].Width<40 then
           lbFav.Columns[i].Width:=40

    end;

 sqlGrid.columns[1].width:=panCenter.Width-sqlGrid.columns[0].width-sqlGrid.Columns[2].width-sqlGrid.columns[3].Width;
 lbFav.columns[1].width:=leftPanel.Width-lbFav.columns[0].width-lbFav.Columns[2].width-lbFav.columns[3].Width;

end;

procedure TfmMain.UniqueInstance1OtherInstance(Sender: TObject;
  ParamCount: Integer; Parameters: array of String);
(*
var
  i:Integer;
*)
begin
  //Label1.Caption:=Format('A new instance was created with %d parameter(s):', [Count]);
 (*
  possibleLabels.Clear;
  for i := 0 to Count - 1 do
    possibleLabels.Items.Add(Parameters[i]);
  BringToFront;
  //hack to force app bring to front
  FormStyle := fsSystemStayOnTop;
  FormStyle := fsNormal;
 *)
  // showmessage(Parameters[1]);
  fmMain.action_to_do:='add';
  fmMain.inserted_link:=Parameters[0];
  fmMain.do_action_on_start();
end;








end.

