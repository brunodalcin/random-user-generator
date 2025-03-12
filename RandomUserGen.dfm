object frmProcessGenerateProfile: TfrmProcessGenerateProfile
  Left = 0
  Top = 0
  Caption = 'frmProcessGenerateProfile'
  ClientHeight = 383
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Bevel1: TBevel
    Left = 96
    Top = 72
    Width = 577
    Height = 209
  end
  object Bevel2: TBevel
    Left = 96
    Top = 8
    Width = 577
    Height = 41
  end
  object Label1: TLabel
    Left = 101
    Top = 14
    Width = 556
    Height = 28
    Alignment = taCenter
    AutoSize = False
    Caption = 'Random User Explorer API'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Image: TImage
    Left = 486
    Top = 112
    Width = 140
    Height = 140
  end
  object Label2: TLabel
    Left = 144
    Top = 139
    Width = 74
    Height = 21
    Caption = 'Username:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 144
    Top = 112
    Width = 45
    Height = 21
    Caption = 'Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 144
    Top = 166
    Width = 41
    Height = 21
    Caption = 'Email:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 144
    Top = 220
    Width = 59
    Height = 21
    Caption = 'Address:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 144
    Top = 193
    Width = 47
    Height = 21
    Caption = 'Phone:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbAddress: TLabel
    Left = 224
    Top = 220
    Width = 9
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbPhone: TLabel
    Left = 224
    Top = 193
    Width = 9
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbEmail: TLabel
    Left = 224
    Top = 166
    Width = 9
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbUsername: TLabel
    Left = 224
    Top = 139
    Width = 9
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbName: TLabel
    Left = 224
    Top = 112
    Width = 9
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Bevel3: TBevel
    Left = 96
    Top = 296
    Width = 577
    Height = 73
  end
  object btnNewProfile: TButton
    Left = 144
    Top = 320
    Width = 482
    Height = 25
    Caption = 'Generate new profile'
    TabOrder = 0
    OnClick = btnNewProfileClick
  end
  object RESTClient: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 40
    Top = 80
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 40
    Top = 136
  end
  object RESTResponse: TRESTResponse
    Left = 40
    Top = 192
  end
  object NetHTTPClient: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 40
    Top = 256
  end
end
