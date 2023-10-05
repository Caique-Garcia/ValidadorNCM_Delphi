object uFormPrincipal: TuFormPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Pro NCM'
  ClientHeight = 587
  ClientWidth = 1012
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PanelContainer: TPanel
    Left = 0
    Top = 0
    Width = 1012
    Height = 587
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object PanelHeader: TPanel
      Left = 0
      Top = 0
      Width = 1012
      Height = 17
      Align = alTop
      BevelOuter = bvNone
      Color = 15329769
      ParentBackground = False
      TabOrder = 0
    end
    object PanelCorpo: TPanel
      Left = 0
      Top = 17
      Width = 1012
      Height = 570
      Align = alClient
      BevelOuter = bvNone
      Color = 15329769
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        1012
        570)
      object PanelBuscas: TPanel
        AlignWithMargins = True
        Left = 35
        Top = 0
        Width = 942
        Height = 65
        Margins.Left = 35
        Margins.Top = 0
        Margins.Right = 35
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          942
          65)
        object Shape1: TShape
          Left = 13
          Top = 13
          Width = 396
          Height = 41
          Anchors = [akLeft]
          Brush.Style = bsClear
          Pen.Color = clGray
        end
        object Shape2: TShape
          Left = 631
          Top = 13
          Width = 220
          Height = 41
          Anchors = [akRight]
          Brush.Style = bsClear
          Pen.Color = clGray
          ExplicitLeft = 752
        end
        object LabelRes: TLabel
          Left = 515
          Top = 24
          Width = 110
          Height = 17
          Anchors = [akRight]
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 636
        end
        object btnValidar: TButton
          Left = 857
          Top = 13
          Width = 65
          Height = 41
          Anchors = [akRight]
          Caption = 'Validar'
          TabOrder = 0
          OnClick = btnValidarClick
        end
        object Button1: TButton
          Left = 425
          Top = 13
          Width = 65
          Height = 41
          Anchors = [akRight]
          Caption = 'Teste'
          TabOrder = 1
          OnClick = Button1Click
        end
      end
      object EditNCM: TEdit
        Left = 679
        Top = 24
        Width = 193
        Height = 21
        Hint = 'Digite o  NCM para ser validado'
        Anchors = [akTop, akRight]
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TextHint = 'NCM'
      end
      object EditNome: TSearchBox
        Left = 58
        Top = 24
        Width = 375
        Height = 25
        Hint = 'Digite o nome para buscar o NCM pelo nome do produto'
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        TextHint = 'Nome '
        OnInvokeSearch = EditNomeInvokeSearch
      end
      object PanelGrid: TPanel
        AlignWithMargins = True
        Left = 35
        Top = 65
        Width = 942
        Height = 470
        Margins.Left = 35
        Margins.Top = 0
        Margins.Right = 35
        Margins.Bottom = 35
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 3
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 942
          Height = 470
          Align = alClient
          BorderStyle = bsNone
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = 10526880
          TitleFont.Height = -13
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnDblClick = DBGrid1DblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'CODNCM'
              Title.Caption = 'NCM'
              Width = 108
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Caption = 'DESCRI'#199#195'O'
              Width = 799
              Visible = True
            end>
        end
      end
    end
  end
  object ACBrNCMs1: TACBrNCMs
    ProxyPort = '8080'
    UrlConsulta = 
      'https://portalunico.siscomex.gov.br/classif/api/publico/nomencla' +
      'tura/download/json'
    CacheArquivo = 'ACBrNCM.json'
    Left = 800
    Top = 368
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODNCM'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'DATAINICIO'
        DataType = ftDate
      end
      item
        Name = 'DATAFIM'
        DataType = ftDate
      end
      item
        Name = 'TIPOATO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NUMEROATO'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'ANOATO'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 755
    Top = 368
    object ClientDataSet1CODNCM: TStringField
      FieldName = 'CODNCM'
      Size = 8
    end
    object ClientDataSet1DESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object ClientDataSet1DATAINICIO: TDateField
      FieldName = 'DATAINICIO'
    end
    object ClientDataSet1DATAFIM: TDateField
      FieldName = 'DATAFIM'
    end
    object ClientDataSet1TIPOATO: TStringField
      FieldName = 'TIPOATO'
    end
    object ClientDataSet1NUMEROATO: TStringField
      FieldName = 'NUMEROATO'
      Size = 6
    end
    object ClientDataSet1ANOATO: TIntegerField
      FieldName = 'ANOATO'
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 718
    Top = 369
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODNCM'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'DATAINICIO'
        DataType = ftDate
      end
      item
        Name = 'DATAFIM'
        DataType = ftDate
      end
      item
        Name = 'TIPOATO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NUMEROATO'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'ANOATO'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 755
    Top = 424
    object StringField1: TStringField
      FieldName = 'CODNCM'
      Size = 8
    end
    object StringField2: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object DateField1: TDateField
      FieldName = 'DATAINICIO'
    end
    object DateField2: TDateField
      FieldName = 'DATAFIM'
    end
    object StringField3: TStringField
      FieldName = 'TIPOATO'
    end
    object StringField4: TStringField
      FieldName = 'NUMEROATO'
      Size = 6
    end
    object IntegerField1: TIntegerField
      FieldName = 'ANOATO'
    end
  end
end
