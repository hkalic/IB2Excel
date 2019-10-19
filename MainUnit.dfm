object Form1: TForm1
  Left = 236
  Top = 162
  Width = 696
  Height = 480
  Caption = 'SQL u XLS, HTML, TXT'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 29
    Width = 688
    Height = 155
    Align = alClient
    Caption = ' Upit '
    TabOrder = 0
    object Memo1: TMemo
      Left = 2
      Top = 15
      Width = 684
      Height = 138
      Align = alClient
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 184
    Width = 688
    Height = 269
    Align = alBottom
    Caption = ' Rezultat '
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 2
      Top = 15
      Width = 684
      Height = 252
      Align = alClient
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        DataController.DataSource = DataSource1
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 688
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 2
    object BitBtn4: TBitBtn
      Left = 0
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Open query'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object BitBtn8: TBitBtn
      Left = 75
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Snimi query'
      TabOrder = 7
      OnClick = BitBtn8Click
    end
    object ToolButton1: TToolButton
      Left = 150
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object BitBtn1: TBitBtn
      Left = 158
      Top = 2
      Width = 75
      Height = 22
      Caption = 'START'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn3: TBitBtn
      Left = 233
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Disconnect'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object ToolButton2: TToolButton
      Left = 308
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object BitBtn2: TBitBtn
      Left = 316
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Snimi u Excel'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn5: TBitBtn
      Left = 391
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Snimi u HTML'
      TabOrder = 4
      OnClick = BitBtn5Click
    end
    object BitBtn6: TBitBtn
      Left = 466
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Snimi u TXT'
      TabOrder = 5
      OnClick = BitBtn6Click
    end
    object BitBtn7: TBitBtn
      Left = 541
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Snimi u XML'
      TabOrder = 6
      OnClick = BitBtn7Click
    end
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 488
    Top = 40
  end
  object Database1: TDatabase
    AliasName = 'Video'
    DatabaseName = 'PISIPIS'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'ENABLE BCD=TRUE'
      'OPEN MODE=READ ONLY'
      'USER NAME=sysdba'
      'PASSWORD=masterkey'
      'SERVER NAME=192.168.100.100://DBS/interbase/pisdb.gdb')
    SessionName = 'Default'
    Left = 584
    Top = 40
  end
  object Query1: TQuery
    BeforeOpen = Query1BeforeOpen
    AfterOpen = Query1AfterOpen
    DatabaseName = 'PISIPIS'
    SQL.Strings = (
      
        'SELECT c.cj_sifmat, m.ms_nazmat, m.ms_sifkla, c.cj_cijvp-c.cj_ci' +
        'jznc'
      'FROM cj_cjenik c, ms_matsta m'
      'WHERE c.cj_sifktg in ('#39'KOS'#39')'
      'AND c.cj_datvaz<'#39'31.03.2004'#39
      'AND c.cj_cijvp-c.cj_cijznc BETWEEN -5 AND 8'
      'AND m.ms_sifmat=c.cj_sifmat'
      'ORDER BY m.ms_sifkla, c.cj_sifmat, c.cj_datvaz DESC')
    Left = 520
    Top = 40
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'sql'
    Filter = 'SQL query|*.sql|All files|*.*'
    Options = [ofHideReadOnly, ofShareAware, ofEnableSizing]
    Left = 384
    Top = 72
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Execl files|*.xls|All files|*.*'
    Left = 416
    Top = 72
  end
end
