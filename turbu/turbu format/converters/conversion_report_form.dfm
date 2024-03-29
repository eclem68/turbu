object frmConversionReport: TfrmConversionReport
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Converting...'
  ClientHeight = 369
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object Panel1: TPanel
    Left = 10
    Top = 21
    Width = 380
    Height = 284
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 0
    object lblProgress: TLabel
      Left = 144
      Top = 56
      Width = 61
      Height = 18
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Progress:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblSteps: TLabel
      Left = 144
      Top = 122
      Width = 74
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taCenter
      Caption = 'Conversion:'
    end
    object lblStatusLabel: TLabel
      Left = 52
      Top = 21
      Width = 44
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Status:'
    end
    object lblCurrentStatus: TLabel
      Left = 210
      Top = 21
      Width = 116
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taRightJustify
      Caption = 'Converting project'
    end
    object prgConversion: TProgressBar
      Left = 52
      Top = 81
      Width = 274
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Max = 14
      Step = 1
      TabOrder = 0
    end
    object prgSteps: TProgressBar
      Left = 52
      Top = 146
      Width = 274
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Max = 14
      Step = 1
      TabOrder = 1
    end
    object pnlHints: TPanel
      Left = 21
      Top = 220
      Width = 95
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelOuter = bvLowered
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      TabOrder = 2
      object Label1: TLabel
        Left = 6
        Top = 6
        Width = 35
        Height = 17
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Hints:'
      end
      object lblHintCount: TLabel
        Left = 81
        Top = 6
        Width = 8
        Height = 17
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alRight
        Caption = '0'
      end
    end
    object pnlWarnings: TPanel
      Left = 137
      Top = 220
      Width = 106
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelOuter = bvLowered
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      TabOrder = 3
      object Label2: TLabel
        Left = 6
        Top = 6
        Width = 40
        Height = 17
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Notes:'
      end
      object lblWarningCount: TLabel
        Left = 92
        Top = 6
        Width = 8
        Height = 17
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alRight
        Caption = '0'
      end
    end
    object pnlErrors: TPanel
      Left = 251
      Top = 218
      Width = 106
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelOuter = bvLowered
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      TabOrder = 4
      object Label3: TLabel
        Left = 6
        Top = 6
        Width = 37
        Height = 17
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'Errors'
      end
      object lblErrorCount: TLabel
        Left = 92
        Top = 6
        Width = 8
        Height = 17
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alRight
        Caption = '0'
      end
    end
  end
  object btnDone: TButton
    Left = 149
    Top = 324
    Width = 98
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnDoneClick
  end
end
