object frmTurbuMain: TfrmTurbuMain
  Left = 183
  Top = 38
  Caption = 'TURBU - The Ultimate Rpg BUilder'
  ClientHeight = 876
  ClientWidth = 1132
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object sbxMain: TScrollBox
    Left = 218
    Top = 26
    Width = 914
    Height = 850
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    HorzScrollBar.Tracking = True
    VertScrollBar.ButtonSize = 15
    VertScrollBar.Margin = 10
    VertScrollBar.Range = 131
    VertScrollBar.Size = 15
    VertScrollBar.Style = ssHotTrack
    VertScrollBar.ThumbSize = 10
    VertScrollBar.Tracking = True
    Align = alClient
    AutoScroll = False
    Color = clBlack
    ParentColor = False
    TabOrder = 0
    object imgLogo: TSdlFrame
      Left = 0
      Top = 0
      Width = 888
      Height = 824
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Framerate = 0
      Active = False
      OnAvailable = imgLogoAvailable
      Align = alClient
      OnDblClick = imgLogoDblClick
      OnMouseDown = imgLogoMouseDown
      OnMouseMove = imgLogoMouseMove
      OnMouseUp = imgLogoMouseUp
    end
    object pnlHorizScroll: TPanel
      Left = 0
      Top = 824
      Width = 910
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object sbHoriz: TScrollBar
        Left = 0
        Top = 0
        Width = 888
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        PageSize = 100
        TabOrder = 0
        OnScroll = OnScrollMap
      end
      object pnlCorner: TPanel
        Left = 888
        Top = 0
        Width = 22
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alRight
        Caption = 'pnlCorner'
        TabOrder = 1
      end
    end
    object pnlVertScroll: TPanel
      Left = 888
      Top = 0
      Width = 22
      Height = 824
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object sbVert: TScrollBar
        Left = 0
        Top = 0
        Width = 22
        Height = 824
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Kind = sbVertical
        PageSize = 100
        TabOrder = 0
        OnScroll = OnScrollMap
      end
    end
  end
  object pnlSidebar: TPanel
    Left = 0
    Top = 26
    Width = 218
    Height = 850
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object splSidebar: TSplitter
      Left = 0
      Top = 500
      Width = 218
      Height = 4
      Cursor = crVSplit
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      OnMoved = splSidebarMoved
      ExplicitTop = 502
      ExplicitWidth = 279
    end
    object sbxPallette: TScrollBox
      Left = 0
      Top = 0
      Width = 218
      Height = 500
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      HorzScrollBar.Visible = False
      VertScrollBar.ButtonSize = 15
      VertScrollBar.Margin = 15
      VertScrollBar.Range = 131
      VertScrollBar.Size = 10
      VertScrollBar.ThumbSize = 10
      VertScrollBar.Tracking = True
      Align = alTop
      AutoScroll = False
      Color = clGreen
      ParentColor = False
      TabOrder = 0
      object imgPalette: TSdlFrame
        Left = 0
        Top = 0
        Width = 192
        Height = 496
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Framerate = 0
        Active = False
        Align = alClient
        OnMouseDown = imgPaletteMouseDown
        OnMouseMove = imgPaletteMouseMove
      end
      object sbPalette: TScrollBar
        Left = 192
        Top = 0
        Width = 22
        Height = 496
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alRight
        Kind = sbVertical
        PageSize = 100
        TabOrder = 1
        OnScroll = sbPaletteScroll
      end
    end
    object trvMapTree: TTreeView
      Left = 0
      Top = 504
      Width = 218
      Height = 346
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alClient
      Indent = 19
      PopupMenu = mnuTreePopup
      ReadOnly = True
      TabOrder = 1
      OnChange = trvMapTreeChange
      OnContextPopup = trvMapTreeContextPopup
    end
  end
  object ToolBar2: TToolBar
    Left = 0
    Top = 0
    Width = 1132
    Height = 26
    ButtonHeight = 28
    Caption = 'ToolBar2'
    Images = ilToolbarIcons
    TabOrder = 2
    object btnLayer1: TToolButton
      Left = 0
      Top = 0
      Action = actLayer1
      Grouped = True
      Style = tbsCheck
    end
    object btnLayer2: TToolButton
      Left = 23
      Top = 0
      Action = actLayer2
      Grouped = True
      Style = tbsCheck
    end
    object btnMapObj: TToolButton
      Left = 46
      Top = 0
      Action = actMapObjects
      Grouped = True
      Style = tbsCheck
    end
    object ToolButton1: TToolButton
      Left = 69
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object btnSave: TToolButton
      Left = 77
      Top = 0
      Hint = 'Save map'
      Caption = '&Save'
      ImageIndex = 2
      OnClick = btnSaveClick
    end
    object btnSaveAll: TToolButton
      Left = 100
      Top = 0
      Hint = 'Save all'
      Caption = 'Save &All'
      ImageIndex = 3
      OnClick = btnSaveAllClick
    end
    object ToolButton2: TToolButton
      Left = 123
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnRun: TToolButton
      Left = 131
      Top = 0
      Hint = 'Play'
      Caption = 'btnRun'
      ImageIndex = 4
      OnClick = btnRunClick
    end
    object btnPause: TToolButton
      Left = 154
      Top = 0
      Hint = 'Pause'
      Caption = 'btnPause'
      Enabled = False
      ImageIndex = 5
      OnClick = btnPauseClick
    end
  end
  object mnuMain: TMainMenu
    Left = 544
    Top = 160
    object mnuFile: TMenuItem
      Caption = '&File'
      object mnuNew: TMenuItem
        Caption = '&New Project...'
        Enabled = False
        ShortCut = 16462
      end
      object mnuOpen: TMenuItem
        Caption = '&Open Project...'
        ShortCut = 16463
        OnClick = mnuOpenClick
      end
      object mnuImport: TMenuItem
        Caption = '&Import Project'
        object mnu2K: TMenuItem
          Caption = 'RPG Maker &2000/2003...'
          OnClick = mnu2KClick
        end
      end
      object mnuSep1: TMenuItem
        Caption = '-'
      end
      object mnuExit: TMenuItem
        Caption = 'E&xit'
        OnClick = mnuExitClick
      end
    end
    object mnuEdit1: TMenuItem
      Caption = '&Edit'
      object Layer11: TMenuItem
        Action = actLayer1
        AutoCheck = True
      end
      object Layer21: TMenuItem
        Action = actLayer2
        AutoCheck = True
      end
      object MapObjects1: TMenuItem
        Action = actMapObjects
        AutoCheck = True
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuDatabase: TMenuItem
        Caption = '&Database'
        Enabled = False
        ShortCut = 119
        OnClick = mnuDatabaseClick
      end
    end
    object mnuOptions: TMenuItem
      Caption = '&Options'
      object mnuAutosaveMaps: TMenuItem
        Caption = '&Autosave maps on change'
        OnClick = mnuAutosaveMapsClick
      end
      object mnuTestbugreps: TMenuItem
        Caption = '&Test bugreps'
        Visible = False
        OnClick = mnuTestbugrepsClick
      end
    end
  end
  object dlgOpen: TOpenDialog
    Filter = 'TURBU Projects (project.tdb)|project.tdb'
    Left = 472
    Top = 96
  end
  object pluginManager: TJvPluginManager
    Extension = 'TEP'
    PluginKind = plgPackage
    Left = 264
    Top = 48
  end
  object ilToolbarIcons: TImageList
    Left = 312
    Top = 152
    Bitmap = {
      494C01010800C800C40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080F9FF0000D6
      E10000D6E10000D6E10080F9FF00000000000000000080F9FF0000D6E10000D6
      E10000D6E10080F9FF000000000000000000241CED001D14EC00160DEB00160D
      EB00160DEB00160DEB00160DEB00160DEB00160DEB00160DEB00160DEB00160D
      EB00160DEB00160DEB001D14EC00241CED000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E6DCD4006F869A00406A8F00908D8D000000000000000000000000000000
      000000000000000000004B4B4B004B4B4B000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E10000000000000000001D14EC005B55F100918DF600918D
      F600918DF600918DF600918DF600918DF600918DF600918DF600918DF600918D
      F600918DF600918DF6005B55F1001D14EC000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5EA
      E0008093A3004577A4003A6D9900929292000000000000000000000000000000
      000000000000007F000000FF2A0000FF2A004B4B4B0000000000000000000000
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF600000000000000
      00000000000000000000E39B9400E5A39F00E39E9B00F8D2BA00000000000000
      00000000000000000000928EF600160DEB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F4E9DF009FA1
      A500487AA6003B6F9C0064758500E9DED3000000000000000000000000000000
      000000000000007F000000FF2A0000FF2A0000FF2A004B4B4B00000000000000
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF600000000000000
      000000000000D690BA00C2292100C2251B00C2251B00C2261B00F8D3A3000000
      00000000000000000000928EF600160DEB000000000000000000000000000000
      00000000000000000000000000000000000000000000E8DCD300678299004278
      A60046698600CFC5BE00F1E4D900000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF2A0000FF2A0000FF2A004B4B4B000000
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF600000000000000
      0000D9A6CE00C3291B00FFFBE2000000000000000000F1E4FB00C1221B00FDD1
      A3000000000000000000928EF600160DEB000000000000000000000000000000
      00000000000000000000F1E6DB00F1E6DB00F1E6DB008F959A00487DAA00426A
      8B00BFB8B200F1E4DA0000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF2A0000FF2A0000FF2A0000FF2A004B4B
      4B0000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF60000000000F9FF
      FF00C2303C00D847290000000000000000000000000000000000C6495300D038
      18000000000000000000928EF600160DEB000000000000000000F1E6DB00D0C8
      C0009E9A9600777674006565640076757400AAA6A10045759D003F6B8E00B3AF
      AC00F1E4DA000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF2A0000FF2A0000FF2A0000FF2A0000FF
      2A004B4B4B00000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF60000000000DAA2
      C900C32A1F00FFEDC40000000000000000000000000000000000EFEFFF00C329
      1E00F3AD820000000000928EF600160DEB0000000000E7DBD200A39E9A008784
      8400BFBCB900DDD8D500E2DDDA00C4C1BF0088898C00768FA400A2A09F00F0E4
      D900000000000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF2A0000FF2A0000FF2A0000FF2A0000FF
      2A0000FF2A004B4B4B000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF60000000000D590
      B300C42A2000FFF4CC0000000000000000000000000000000000F0F3FF00C42A
      2000EA8E640000000000928EF600160DEB00F1E4D9009C979300C2BFBC000000
      000000000000000000000000000000000000DCD8D6007F7C7900BAB3AE00F1E3
      D800000000000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF090000FF2A0000FF2A0000FF2A0000FF
      2A0000FF2A00007F00000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF60000000000D798
      BD00C42A2000FFEBC20000000000000000000000000000000000F0F5FF00C32A
      1F00ED9A700000000000928EF600160DEB00A29E9D00E1D7CB00000000000000
      00000000000000000000000000000000000000000000000000008C8A8900A6A2
      9D00000000000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF090000FF090000FF2A0000FF2A0000FF
      2A00007F0000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF60000000000E3C2
      E900C3291E00FDD2A70000000000000000000000000000000000EADBFF00C32A
      2000F2AB800000000000928EF600160DEB00A9A4A000EDDDCB00000000000000
      0000000000000000000000000000000000000000000000000000C8C0BF007474
      7200000000000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF090000FF090000FF090000FF2A00007F
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF600000000000000
      0000CA6F9600C228200000000000000000000000000000000000C4293600D742
      23000000000000000000928EF600160DEB00AEA59A00F6E2CF00000000000000
      0000000000000000000000000000000000000000000000000000E5D6D5006263
      6200000000000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF090000FF090000FF2A00007F00000000
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF600000000000000
      0000FDFFFF00C74C5700DB684900E6A9A600E7A8A100D2778A00C92D1800FFFD
      DA000000000000000000928EF600160DEB00A99F9600F1DBC500000000000000
      0000000000000000000000000000000000000000000000000000E2D2CF006D6D
      6B00000000000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF090000FF2A00007F0000000000000000
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF600000000000000
      00000000000000000000C0384600C2231600C2251B00C41F1400FFFFEC000000
      00000000000000000000928EF600160DEB00A9A19900E4CDB400000000000000
      0000000000000000000000000000000000000000000000000000CBBFBC008E8C
      8A00000000000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A0000FF2A00007F000000000000000000000000
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E1000000000000000000160DEB00928EF600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000928EF600160DEB00F6EEE700AAA09400DAC5AD00FEF2
      E2000000000000000000000000000000000000000000CABCB500908D8B00F6EE
      E700000000000000000000000000000000000000000000000000000000000000
      000000000000007F000000FF2A00007F00000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000D6E10000F2
      FF0000F2FF0000F2FF0000D6E100000000000000000000D6E10000F2FF0000F2
      FF0000F2FF0000D6E10000000000000000001D14EC005B55F100918DF600918D
      F600918DF600918DF600918DF600918DF600918DF600918DF600918DF600918D
      F600918DF600918DF6005B55F1001D14EC0000000000EBE4DE00AFA79E00CAB9
      A800F1DECB00000000000000000000000000BDAFA60096939100EDE5DF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000007F0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080F9FF0000D6
      E10000D6E10000D6E10080F9FF00000000000000000080F9FF0000D6E10000D6
      E10000D6E10080F9FF000000000000000000241CED001D14EC00160DEB00160D
      EB00160DEB00160DEB00160DEB00160DEB00160DEB00160DEB00160DEB00160D
      EB00160DEB00160DEB001D14EC00241CED000000000000000000F8F0E900CFC9
      C400B0A8A000ACA09200B1A29400ADA19600C7C2BE0000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF004CB122004CB1
      22004CB122004CB122004CB122004CB122004CB122004CB122004CB122004CB1
      22004CB122004CB122004CB122004CB12200FFFFFF00FFFFFF004CB122004CB1
      22004CB122004CB122004CB122004CB122004CB122004CB122004CB122004CB1
      22004CB122004CB122004CB122004CB12200F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200FFFFFF00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F000F0F0F000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F0F0F000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F0F0F0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200FFFFFF00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F009936
      2F00000000000000000000000000000000000000000000000000F0F0F000F0F0
      F0000000000099362F0000000000F0F0F000FFFFFF00FFFFFF00F0F0F0000000
      00000000000099362F000000000000000000000000000000000000000000F0F0
      F000F0F0F0000000000000000000FFFFFF00241CED00241CED00241CED00241C
      ED00241CED00241CED00241CED00241CED00241CED00241CED00241CED00241C
      ED00241CED00241CED00FFFFFF004CB12200241CED00241CED004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F009936
      2F00000000000000000000000000000000000000000000000000F0F0F000F0F0
      F0000000000099362F0000000000F0F0F000F0F0F000F0F0F000000000009936
      2F000000000099362F000000000000000000000000000000000000000000F0F0
      F000F0F0F0000000000000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF003A90DB00000000000000000000000000FFB6
      6600FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F009936
      2F00000000000000000000000000000000000000000000000000F0F0F000F0F0
      F0000000000099362F0000000000F0F0F000F0F0F000F0F0F000000000009936
      2F000000000099362F0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0066B6FF00B6660000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F009936
      2F00000000000000000000000000000000000000000000000000000000000000
      00000000000099362F0000000000F0F0F000F0F0F00000000000000000009936
      2F000000000099362F0099362F0099362F0099362F0099362F0099362F009936
      2F0099362F0099362F0000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF003A90DB0000000000B6660000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0066B6FF00FFB66600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F009936
      2F0099362F0099362F0099362F0099362F0099362F0099362F0099362F009936
      2F0099362F0099362F0000000000F0F0F000F0F0F00000000000000000009936
      2F000000000099362F00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000000000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009090B600FFFF
      DB00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F009936
      2F00000000000000000000000000000000000000000000000000000000000000
      000099362F0099362F0000000000F0F0F000F0F0F00000000000000000009936
      2F000000000099362F00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000000000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003A66B600FFDB
      9000FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F000000
      0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F0000000000099362F0000000000F0F0F000F0F0F00000000000000000009936
      2F000000000099362F00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000000000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009090DB00FFFFB600B6FFFF0066006600FFFF
      B600FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F000000
      0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F0000000000099362F0000000000F0F0F000F0F0F00000000000000000009936
      2F000000000099362F00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000000000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00B6FFFF000000660000000000DB903A00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F000000
      0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F0000000000099362F0000000000F0F0F000F0F0F00000000000000000009936
      2F000000000099362F00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000000000000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F000000
      0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F0000000000099362F0000000000F0F0F000F0F0F00000000000000000009936
      2F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF003A90DB0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF004CB12200241CED00FFFFFF004CB12200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF004CB12200F0F0F0000000000099362F000000
      0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000000000000000000000000000F0F0F000F0F0F00000000000000000009936
      2F0000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0000000
      0000F0F0F00000000000FFFFFF00FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED004CB122004CB12200241CED00FFFFFF004CB122004CB1
      22004CB122004CB122004CB122004CB122004CB122004CB122004CB122004CB1
      22004CB122004CB122004CB122004CB12200F0F0F0000000000099362F000000
      0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F00000000000F0F0F00000000000F0F0F000F0F0F00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF00FFFFFF00241CED00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00241CED00FFFFFF00FFFFFF00F0F0F00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F0F0F000F0F0F00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0F0F000FFFFFF00FFFFFF00FFFFFF00241CED00241CED00241CED00241C
      ED00241CED00241CED00241CED00241CED00241CED00241CED00241CED00241C
      ED00241CED00241CED00FFFFFF00FFFFFF00241CED00241CED00241CED00241C
      ED00241CED00241CED00241CED00241CED00241CED00241CED00241CED00241C
      ED00241CED00241CED00FFFFFF00FFFFFF00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000FFFFFF00FFFFFF00FFFFFF00424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFC1830000FFF0FCFFC1830000FFE0
      F87FC1833C3CFFC0F83FC183381CFF81F81FC183318CFC03F80FC18323CCC007
      F807C18323C4800FF803C18323C41F0FF803C18323C43FCFF807C18323C43FCF
      F80FC18333CC3FCFF81FC183300C3FCFF83FC1833C1C3FCFF87FC1833FFC0F8F
      F8FFC1830000871FFDFFC1830000C07F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object mnuTreePopup: TPopupMenu
    Left = 96
    Top = 592
    object mnuEditMapProperties: TMenuItem
      Caption = 'Map &Properties'
      OnClick = mnuEditMapPropertiesClick
    end
    object mnuAddNewMap: TMenuItem
      Caption = 'Add &New Map'
      OnClick = mnuAddNewMapClick
    end
    object mnuDeleteMap: TMenuItem
      Caption = '&Delete Map...'
      OnClick = mnuDeleteMapClick
    end
  end
  object ActionManager: TActionManager
    Images = ilToolbarIcons
    Left = 424
    Top = 200
    StyleName = 'Platform Default'
    object actLayer1: TAction
      AutoCheck = True
      Caption = 'Layer &1'
      Checked = True
      GroupIndex = 1
      ImageIndex = 0
      ShortCut = 116
      OnExecute = btnLayer1Click
    end
    object actLayer2: TAction
      AutoCheck = True
      Caption = 'Layer &2'
      GroupIndex = 1
      ImageIndex = 1
      ShortCut = 117
      OnExecute = btnLayer2Click
    end
    object actMapObjects: TAction
      AutoCheck = True
      Caption = 'Map &Objects'
      GroupIndex = 1
      ImageIndex = 6
      ShortCut = 118
      OnExecute = btnMapObjClick
    end
  end
end
