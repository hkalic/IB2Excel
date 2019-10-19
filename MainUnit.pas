unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, IBDatabase, IBCustomDataSet,
  IBQuery, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  StdCtrls, ExtCtrls, ToolWin, ComCtrls, DBTables, Buttons, cxContainer,
  cxTextEdit, cxMaskEdit, Mask, IniFiles;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    ToolBar1: TToolBar;
    Database1: TDatabase;
    Query1: TQuery;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    BitBtn8: TBitBtn;
    ToolButton3: TToolButton;
    MaskEdit1: TMaskEdit;
    Panel1: TPanel;
    Cijene: TRadioGroup;
    MaskEdit2: TMaskEdit;
    Label1: TLabel;
    procedure Query1AfterOpen(DataSet: TDataSet);
    procedure Query1BeforeOpen(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MaskEdit2Exit(Sender: TObject);
    procedure DajUpit(inventura:String);
    procedure MaskEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CijeneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Params: TIniFile;
  cjenik, path: String;

implementation
uses cxexportgrid4link, cxexport;

{$R *.dfm}

procedure TForm1.Query1AfterOpen(DataSet: TDataSet);
begin
    cxGrid1DBTableView1.DataController.CreateAllItems;
    DataSet.EnableControls;
end;

procedure TForm1.Query1BeforeOpen(DataSet: TDataSet);
begin
    cxGrid1DBTableView1.ClearItems;
    DataSet.DisableControls;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
    with Database1.Params do
    begin
        Clear;
        Add('ENABLE BCD=TRUE');
        Add('OPEN MODE=READ ONLY');
        Add('USER NAME=********'); // username removed
        Add('PASSWORD=*******'); // password removed
        Add('SERVER NAME='+MaskEdit1.Text+'://DBS/interbase/pisdb.gdb');
    end;
    with Query1 do
    begin
        Close;
        SQL:=Memo1.Lines;
        Open;
    end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
    Query1.Close;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
    SaveDialog1.DefaultExt:='xls';
    SaveDialog1.Filter:='EXCEL files|*.xls|All files|*.*';
    if SaveDialog1.Execute then ExportGrid4ToExcel(SaveDialog1.FileName, cxGrid1, True, True);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
    SaveDialog1.DefaultExt:='sql';
    SaveDialog1.Filter:='SQL files|*.sql|All files|*.*';
    if OpenDialog1.Execute then Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
    SaveDialog1.DefaultExt:='html';
    SaveDialog1.Filter:='HTML files|*.html|All files|*.*';
    if SaveDialog1.Execute then ExportGrid4ToHTML(SaveDialog1.FileName, cxGrid1, True, True);
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
    SaveDialog1.DefaultExt:='txt';
    SaveDialog1.Filter:='TXT files|*.txt|All files|*.*';
    if SaveDialog1.Execute then ExportGrid4ToText(SaveDialog1.FileName, cxGrid1, True, True);
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
    SaveDialog1.DefaultExt:='xml';
    SaveDialog1.Filter:='XML files|*.xml|All files|*.*';
    if SaveDialog1.Execute then ExportGrid4ToXML(SaveDialog1.FileName, cxGrid1, True, True);
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
    SaveDialog1.DefaultExt:='sql';
    SaveDialog1.Filter:='SQL files|*.sql|All files|*.*';
    if SaveDialog1.Execute then Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     path:=ExtractFilePath(Application.ExeName);
     Params := TIniFile.Create(path+'ib2e.ini');
     MaskEdit1.Text := Params.ReadString('Server', 'IP', '127.0.0.1');
     if Params.ReadString('Mode', 'Inventura', '0') = '1' then
     begin
        cjenik:=Params.ReadString('Mode', 'Cijene', 'MP');
        if cjenik = 'MP' then Cijene.ItemIndex:=0 else Cijene.ItemIndex:=1;
        MaskEdit2.Text := Params.ReadString('Mode', 'BrojInventure', '4908001');

        //Memo1.Lines.LoadFromFile(path+'inventura04.sql');
        Dajupit(MaskEdit2.Text);

        if Params.ReadString('Mode', 'Edit', '0')='0' then
        begin
                Memo1.Enabled:=False;
                BitBtn4.Enabled:=False;
                BitBtn6.Enabled:=False;
                BitBtn7.Enabled:=False;
                BitBtn4.Enabled:=False;
                BitBtn8.Enabled:=False;
                BitBtn5.Enabled:=False;
                MaskEdit1.Enabled:=False;
        end
        else Memo1.Enabled:=True;
     end
     else Panel1.Visible:=False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     Params.WriteString('Server', 'IP', MaskEdit1.Text);
     Params.WriteString('Mode', 'Cijene', cjenik);
     Params.WriteString('Mode', 'BrojInventure', MaskEdit2.Text);
     Params.Free;
end;

procedure TForm1.MaskEdit2Exit(Sender: TObject);
begin
     Dajupit(MaskEdit2.Text);
end;

procedure TForm1.DajUpit(inventura:String);
begin
     with Memo1.Lines do
     begin
          Clear;
          Add('SELECT dz_sifmat, ms_nazmat, ms_jedmat, ms_sifkla,');
          Add('dz_kolinv, dz_kolkng, dz_kolinv-dz_kolkng KOL_RAZ,');
          if Cijene.ItemIndex=0 then
          begin
               Add('cj_cijmp, dz_kolinv*cj_cijmp VRI_INV, dz_kolkng*cj_cijmp VRI_KNJ,');
               Add('(dz_kolinv-dz_kolkng)*cj_cijmp VRI_RAZ');
          end else
          begin
               Add('cj_cijznc, dz_kolinv*cj_cijznc VRI_INV, dz_kolkng*cj_cijznc VRI_KNJ,');
               Add('(dz_kolinv-dz_kolkng)*cj_cijznc VRI_RAZ');
          end;
          Add('FROM dz_dokraz, ms_matsta, ex_cjenik');
          Add('WHERE dz_sifmat = ms_sifmat');
          Add('and cj_sifcjn = dz_sifcjn');
          Add('and dz_sifinv = '''+inventura+'''');
          Add('ORDER BY ms_nazcro, dz_sifmat');
     end;
end;

procedure TForm1.MaskEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=13 then DajUpit(MaskEdit2.Text);
end;

procedure TForm1.CijeneClick(Sender: TObject);
begin
     DajUpit(MaskEdit2.Text);
end;

end.
