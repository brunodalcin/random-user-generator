object frmNavFavoriteUsers: TfrmNavFavoriteUsers
  Left = 0
  Top = 0
  Caption = 'Favorited Users'
  ClientHeight = 487
  ClientWidth = 865
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Bevel3: TBevel
    Left = 32
    Top = 392
    Width = 801
    Height = 73
  end
  object grdFavUser: TDBGrid
    Left = 32
    Top = 32
    Width = 801
    Height = 345
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnCsv: TButton
    Left = 86
    Top = 416
    Width = 153
    Height = 25
    Caption = 'Extract to CSV'
    TabOrder = 1
    OnClick = btnCsvClick
  end
  object btnNavFavorites: TButton
    Left = 641
    Top = 416
    Width = 153
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = btnNavFavoritesClick
  end
  object dsFavUser: TDataSource
    Left = 752
    Top = 88
  end
end
