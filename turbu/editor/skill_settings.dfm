object frmSkillLearning: TfrmSkillLearning
  Left = 0
  Top = 0
  Caption = 'Skill Settings'
  ClientHeight = 360
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object pnlSillData: TPanel
    Left = 10
    Top = 10
    Width = 390
    Height = 274
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 0
    object grpData1: TGroupBox
      Left = 10
      Top = 10
      Width = 106
      Height = 58
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Item1'
      TabOrder = 0
      object spnData1: TJvDBSpinEdit
        Left = 10
        Top = 18
        Width = 79
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ButtonKind = bkClassic
        TabOrder = 0
        DataField = 'nums[1]'
        DataSource = dsForeign
      end
    end
    object grpData2: TGroupBox
      Left = 10
      Top = 76
      Width = 106
      Height = 57
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Item2'
      TabOrder = 1
      object spnData2: TJvDBSpinEdit
        Left = 10
        Top = 18
        Width = 79
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ButtonKind = bkClassic
        TabOrder = 0
        DataField = 'nums[2]'
        DataSource = dsForeign
      end
    end
    object grpAlgorithm: TGroupBox
      Left = 146
      Top = 10
      Width = 232
      Height = 110
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Algorithm'
      TabOrder = 4
      object btnNewAlgorithm: TButton
        Left = 120
        Top = 63
        Width = 98
        Height = 32
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '&Add New...'
        TabOrder = 1
        OnClick = btnNewAlgorithmClick
      end
      object btnEdit: TButton
        Left = 24
        Top = 63
        Width = 78
        Height = 32
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '&Edit...'
        TabOrder = 2
        OnClick = btnEditClick
      end
      object cbxAlgorithm: TDBLookupComboBox
        Left = 10
        Top = 18
        Width = 211
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'algName'
        DataSource = dsForeign
        TabOrder = 0
      end
    end
    object grpSkill: TGroupBox
      Left = 146
      Top = 128
      Width = 232
      Height = 58
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Skill'
      TabOrder = 5
      object cbxSkill: TDBLookupComboBox
        Left = 10
        Top = 18
        Width = 211
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'name'
        DataSource = dsForeign
        TabOrder = 0
      end
    end
    object grpData3: TGroupBox
      Left = 10
      Top = 141
      Width = 106
      Height = 58
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Item3'
      TabOrder = 2
      object spnData3: TJvDBSpinEdit
        Left = 10
        Top = 18
        Width = 79
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ButtonKind = bkClassic
        TabOrder = 0
        DataField = 'nums[3]'
        DataSource = dsForeign
      end
    end
    object grpData4: TGroupBox
      Left = 10
      Top = 207
      Width = 106
      Height = 57
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Item4'
      TabOrder = 3
      object spnData4: TJvDBSpinEdit
        Left = 10
        Top = 18
        Width = 79
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ButtonKind = bkClassic
        TabOrder = 0
        DataField = 'nums[4]'
        DataSource = dsForeign
      end
    end
    object grpNull: TGroupBox
      Left = 148
      Top = 194
      Width = 230
      Height = 70
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 6
    end
  end
  object btnOK: TButton
    Left = 52
    Top = 314
    Width = 98
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 251
    Top = 314
    Width = 98
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object dsForeign: TDataSource
    DataSet = dmDatabase.charClasses_skillset
    Left = 248
    Top = 168
  end
end
