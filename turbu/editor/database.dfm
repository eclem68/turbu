object frmDatabase: TfrmDatabase
  Left = 0
  Top = 0
  Caption = 'Database Viewer'
  ClientHeight = 730
  ClientWidth = 1046
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object btnOK: TButton
    Left = 514
    Top = 654
    Width = 110
    Height = 39
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 632
    Top = 654
    Width = 106
    Height = 39
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnApply: TButton
    Left = 745
    Top = 654
    Width = 104
    Height = 39
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Apply'
    Enabled = False
    TabOrder = 2
    OnClick = applyChanges
  end
  object btnHelp: TButton
    Left = 897
    Top = 654
    Width = 105
    Height = 39
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&Help'
    Enabled = False
    TabOrder = 3
  end
  object tabPages: TPageControl
    Left = 10
    Top = 9
    Width = 1037
    Height = 637
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ActivePage = tshClass
    TabOrder = 4
    object tshClass: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&Class'
      OnShow = tshClassShow
      inline frmClass: TframeClass
        Left = 0
        Top = 0
        Width = 1027
        Height = 600
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 0
        TabStop = True
        inherited lblClasses: TLabel
          Left = 21
          Top = 4
          Width = 179
          Height = 37
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Font.Height = -28
        end
        inherited pnlClass: TPanel
          Left = 208
          Top = 21
          Width = 798
          Height = 556
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          inherited grpClassName: TGroupBox
            Left = 10
            Top = 10
            Width = 242
            Height = 54
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited dbTxtName: TDBEdit
              Left = 10
              Top = 21
              Width = 221
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
          end
          inherited grpClassStats: TGroupBox
            Left = 260
            Top = 10
            Width = 242
            Height = 167
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited imgStats: TImage
              Left = 10
              Top = 18
              Width = 220
              Height = 105
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited cbxBaseStats: TComboBox
              Left = 10
              Top = 131
              Width = 220
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
          end
          inherited grpClassOptions: TGroupBox
            Left = 260
            Top = 184
            Width = 242
            Height = 189
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited radWeaponStyle: TDBIndexComboBox
              Left = 10
              Top = 18
              Width = 221
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited chkEqLocked: TDBCheckBox
              Left = 10
              Top = 109
              Width = 159
              Height = 23
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited chkStrongDef: TDBCheckBox
              Left = 10
              Top = 134
              Width = 127
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited chkGuest: TDBCheckBox
              Left = 10
              Top = 160
            end
          end
          inherited grpClassExp: TGroupBox
            Left = 10
            Top = 341
            Width = 242
            Height = 204
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited lblExpVal1: TLabel
              Left = 10
              Top = 52
              Width = 52
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited lblExpVal2: TLabel
              Left = 126
              Top = 52
              Width = 63
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited lblExpVal3: TLabel
              Left = 10
              Top = 105
              Width = 76
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited lblExpVal4: TLabel
              Left = 132
              Top = 105
              Width = 27
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited btnExpCurveEditor: TButton
              Left = 41
              Top = 161
              Width = 138
              Height = 33
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited spnExpVal1: TJvDBSpinEdit
              Left = 10
              Top = 73
              Width = 96
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited spnExpVal2: TJvDBSpinEdit
              Left = 126
              Top = 73
              Width = 95
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited spnExpVal3: TJvDBSpinEdit
              Left = 10
              Top = 126
              Width = 96
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited spnExpVal4: TJvDBSpinEdit
              Left = 126
              Top = 126
              Width = 95
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
            inherited cbxExpAlgorithm: TDBLookupComboBox
              Left = 10
              Top = 18
              Width = 211
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
          end
          inherited grpGraphics: TGroupBox
            Left = 10
            Top = 72
            Width = 242
            Height = 254
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited tabGraphics: TTabControl
              Left = 10
              Top = 33
              Width = 227
              Height = 210
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              inherited btnSetGfx: TButton
                Left = 21
                Top = 165
                Width = 98
                Height = 32
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
              end
              inherited imgMapSprite: TSdlFrame
                Left = 10
                Top = 31
                Width = 126
                Height = 126
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                LogicalWidth = 126
                LogicalHeight = 126
              end
            end
          end
          inherited grpRepertoire: TGroupBox
            Left = 510
            Top = 72
            Width = 276
            Height = 272
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited pageRepertoire: TPageControl
              Left = 10
              Top = 21
              Width = 257
              Height = 243
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              inherited tshEquipment: TTabSheet
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                inherited lblEquip1: TLabel
                  Left = 10
                  Top = 10
                  Width = 57
                  Height = 17
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited lblEquip2: TLabel
                  Left = 10
                  Top = 50
                  Height = 17
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited lblEquip3: TLabel
                  Left = 10
                  Top = 84
                  Width = 43
                  Height = 17
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited lblEquip4: TLabel
                  Left = 10
                  Top = 120
                  Width = 47
                  Height = 17
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited lblEquip5: TLabel
                  Left = 10
                  Top = 160
                  Width = 67
                  Height = 17
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited cbxEquip1: TDBLookupComboBox
                  Left = 84
                  Top = 7
                  Width = 158
                  Height = 25
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited cbxEquip4: TDBLookupComboBox
                  Left = 84
                  Top = 116
                  Width = 158
                  Height = 25
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited cbxEquip3: TDBLookupComboBox
                  Left = 84
                  Top = 81
                  Width = 158
                  Height = 25
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited cbxEquip5: TDBLookupComboBox
                  Left = 84
                  Top = 160
                  Width = 158
                  Height = 25
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
                inherited cbxEquip2: TDBLookupComboBox
                  Left = 84
                  Top = 46
                  Width = 158
                  Height = 25
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
              end
              inherited tshSkills: TTabSheet
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                inherited frameHeroCommands: TframeHeroCommands
                  Width = 242
                  Height = 204
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  inherited lblNumber: TLabel
                    Left = 144
                    Top = 4
                    Width = 54
                    Height = 17
                    Margins.Left = 4
                    Margins.Top = 4
                    Margins.Right = 4
                    Margins.Bottom = 4
                  end
                  inherited spnCount: TJvSpinEdit
                    Left = 144
                    Top = 29
                    Width = 53
                    Height = 25
                    Margins.Left = 4
                    Margins.Top = 4
                    Margins.Right = 4
                    Margins.Bottom = 4
                  end
                  inherited cbxCommand1: TDBLookupComboBox
                    Left = 10
                    Top = 8
                    Width = 126
                    Height = 25
                    Margins.Left = 4
                    Margins.Top = 4
                    Margins.Right = 4
                    Margins.Bottom = 4
                  end
                end
              end
              inherited tshRepertoire: TTabSheet
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                inherited lstSkills: TRpgListGrid
                  Left = 5
                  Top = 5
                  Width = 237
                  Height = 198
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  TitleFont.Height = -14
                end
              end
            end
          end
          inherited grpScriptEvents: TGroupBox
            Left = 260
            Top = 381
            Width = 242
            Height = 164
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited lstScripts: TListView
              Left = 10
              Top = 21
              Width = 215
              Height = 131
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Columns = <
                item
                  Caption = 'Event'
                  Width = 92
                end
                item
                  Caption = 'Script'
                  Width = 95
                end>
            end
          end
          inherited grpUnarmed: TGroupBox
            Left = 510
            Top = 10
            Width = 276
            Height = 54
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited cbxUnarmedAnim: TDBLookupComboBox
              Left = 10
              Top = 21
              Width = 253
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
            end
          end
          inherited grpResistVuln: TGroupBox
            Left = 510
            Top = 352
            Width = 276
            Height = 193
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            inherited pageResists: TPageControl
              Left = 10
              Top = 21
              Width = 257
              Height = 165
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              inherited tshAttributes: TTabSheet
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                inherited lstAttributes: TRpgListGrid
                  Left = 4
                  Top = 4
                  Width = 186
                  Height = 118
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  TitleFont.Height = -14
                end
                inherited btnEditAttributes: TButton
                  Left = 197
                  Top = 88
                  Width = 45
                  Height = 32
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                end
              end
              inherited tshConditions: TTabSheet
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                inherited RpgListGrid1: TRpgListGrid
                  Left = 4
                  Top = 4
                  Width = 186
                  Height = 118
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  TitleFont.Height = -14
                end
              end
            end
          end
        end
        inherited grdClasses: TRpgListGrid
          Left = 21
          Top = 48
          Width = 179
          Height = 529
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TitleFont.Height = -14
        end
        inherited navAdd: TDBNavigator
          Left = 931
          Top = 432
          Width = 45
          Height = 32
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Hints.Strings = ()
        end
        inherited navDel: TDBNavigator
          Left = 931
          Top = 472
          Width = 45
          Height = 33
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Hints.Strings = ()
        end
      end
    end
    object tshHero: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&Hero'
      ImageIndex = 1
    end
    object tshVocab: TTabSheet
      Caption = 'Vocabulary'
      ImageIndex = 4
      inline frameVocab: TframeVocab
        Left = 0
        Top = 0
        Width = 1029
        Height = 588
        TabOrder = 0
        inherited pnlVocab: TPanel
          inherited pnlSysVocab: TPanel
            inherited lstSysVocab: TRpgListGrid
              TitleFont.Height = -14
            end
            inherited StaticText1: TStaticText
              Width = 127
              Height = 21
            end
          end
          inherited pnlCustomVocab: TPanel
            inherited lstCustomVocab: TRpgListGrid
              TitleFont.Height = -14
            end
            inherited StaticText2: TStaticText
              Width = 129
              Height = 21
            end
            inherited StaticText3: TStaticText
              Width = 30
              Height = 21
            end
            inherited StaticText4: TStaticText
              Width = 42
              Height = 21
            end
          end
        end
        inherited DBNavigator1: TDBNavigator
          Hints.Strings = ()
        end
      end
    end
    object tshItems: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Raw &Data Viewer'
      ImageIndex = 3
      inline frameItems1: TframeItems
        Left = -4
        Top = 0
        Width = 1027
        Height = 704
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabOrder = 0
        inherited pnlItems: TPanel
          Left = -4
          Width = 1027
          Height = 600
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          inherited DBGrid1: TDBGrid
            Left = 9
            Top = 4
            Width = 985
            Height = 545
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            TitleFont.Height = -14
          end
          inherited cboDatasets: TComboBox
            Left = 366
            Top = 543
            Width = 190
            Height = 25
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
          end
        end
        inherited dsWeapons: TDataSource
          DataSet = nil
        end
      end
    end
    object tshGlobalEvents: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&Global Events'
      ImageIndex = 1
      object lblGlobalEvents: TLabel
        Left = 21
        Top = 21
        Width = 250
        Height = 37
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taCenter
        AutoSize = False
        Caption = 'GLOBAL EVENTS'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -28
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lstEvents: TRpgListGrid
        Left = 21
        Top = 51
        Width = 250
        Height = 535
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataSource = srcGlobals
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Name'
            Width = 162
            Visible = True
          end>
      end
      object pnlEvents: TPanel
        Left = 303
        Top = 0
        Width = 724
        Height = 598
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        BevelInner = bvLowered
        BevelOuter = bvLowered
        TabOrder = 1
        object grpName: TGroupBox
          Left = 21
          Top = 10
          Width = 221
          Height = 54
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Name'
          TabOrder = 0
          object txtName: TDBEdit
            Left = 10
            Top = 17
            Width = 201
            Height = 25
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            DataField = 'Name'
            DataSource = srcGlobals
            TabOrder = 0
          end
        end
        object grpStartCondition: TGroupBox
          Left = 250
          Top = 10
          Width = 242
          Height = 54
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Event Start Condition'
          TabOrder = 1
          object cbxStartCondition: TComboBox
            Left = 10
            Top = 17
            Width = 221
            Height = 25
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'Auto Start'
              'Parallel Process'
              'Call')
          end
        end
        object grpConditionSwitch: TGroupBox
          Left = 500
          Top = 10
          Width = 223
          Height = 54
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Condition Switch'
          TabOrder = 2
          object chkHasSwitch: TDBCheckBox
            Left = 4
            Top = 20
            Width = 29
            Height = 22
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            DataField = 'HasSwitch'
            DataSource = srcGlobals
            TabOrder = 0
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            OnClick = chkHasSwitchClick
          end
          object selConditionSwitch: TSwitchSelector
            Left = 30
            Top = 17
            Width = 186
            Height = 25
          end
        end
        object grpEventCommands: TGroupBox
          Left = 21
          Top = 72
          Width = 702
          Height = 514
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Event Commands'
          TabOrder = 3
          object trvGlobal: TEBTreeView
            Left = 2
            Top = 19
            Width = 698
            Height = 493
            Align = alClient
            Indent = 19
            TabOrder = 0
          end
        end
      end
    end
  end
  object srcGlobals: TDataSource
    DataSet = dmDatabase.GlobalScripts
    Left = 48
    Top = 664
  end
end
