object FMain: TFMain
  Left = 221
  Top = 129
  Width = 1140
  Height = 765
  Caption = 'Component TClock [ Inform@tSystem - Copyright 1980-2010 ]'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -14
  Font.Name = 'Franklin Gothic Medium'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 18
  object Button1: TButton
    Left = 0
    Top = 488
    Width = 84
    Height = 28
    Caption = 'Fermer'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel2: TPanel
    Left = 0
    Top = 37
    Width = 366
    Height = 700
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 137
      Width = 120
      Height = 18
      Caption = 'Texte de votre Logo: '
    end
    object B1: TCheckBox
      Left = 7
      Top = 12
      Width = 168
      Height = 19
      Caption = 'Voir Chiffre Minute'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = B1Click
    end
    object B2: TCheckBox
      Left = 7
      Top = 35
      Width = 168
      Height = 19
      Caption = 'Voir Chiffre Heure '
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = B2Click
    end
    object B3: TCheckBox
      Left = 190
      Top = 12
      Width = 168
      Height = 19
      Caption = 'Voir Aiguille Centieme'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = B3Click
    end
    object B4: TCheckBox
      Left = 190
      Top = 35
      Width = 168
      Height = 19
      Caption = 'Voir Aiguille Seconde'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = B4Click
    end
    object B5: TCheckBox
      Left = 190
      Top = 59
      Width = 168
      Height = 18
      Caption = 'Voir Aiguille Minute'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = B5Click
    end
    object B6: TCheckBox
      Left = 190
      Top = 82
      Width = 168
      Height = 19
      Caption = 'Voir Aiguille Heure'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = B6Click
    end
    object B7: TCheckBox
      Left = 7
      Top = 59
      Width = 168
      Height = 18
      Caption = 'Voir Date'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = B7Click
    end
    object B8: TCheckBox
      Left = 7
      Top = 82
      Width = 168
      Height = 19
      Caption = 'Voir Logo'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = B8Click
    end
    object B9: TCheckBox
      Left = 190
      Top = 106
      Width = 168
      Height = 19
      Caption = 'Voir Glissement'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = B9Click
    end
    object B10: TCheckBox
      Left = 7
      Top = 106
      Width = 168
      Height = 19
      Caption = 'Voir Graduations'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = B10Click
    end
    object Edit1: TEdit
      Left = 134
      Top = 135
      Width = 213
      Height = 25
      AutoSize = False
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 10
      Text = 'Inform@tSystem'
      OnChange = Edit1Change
    end
    object GCA: TRadioGroup
      Left = 10
      Top = 173
      Width = 174
      Height = 107
      Caption = ' Choisir la Couleur '
      Columns = 2
      Items.Strings = (
        'Heure'
        'Minute'
        'Seconde'
        'Centieme'
        'Chiffre')
      TabOrder = 11
      OnClick = GCAClick
    end
    object CA: TColorGrid
      Left = 190
      Top = 179
      Width = 160
      Height = 100
      TabOrder = 12
      OnChange = CAChange
      OnClick = CAChange
    end
    object GAig: TRadioGroup
      Left = 10
      Top = 288
      Width = 346
      Height = 107
      Caption = 'Forme des Aiguilles '
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Ligne Simple'
        'Rectangle'
        'Rect. Pointu'
        'Losange'
        'Fleche'
        'Cercle'
        'Triangle')
      TabOrder = 13
      OnClick = GAigClick
    end
    object GTaille: TGroupBox
      Left = 10
      Top = 403
      Width = 346
      Height = 134
      Caption = ' Taille des Aiguille (en pourcentage) '
      TabOrder = 14
      object LAV: TLabel
        Left = 5
        Top = 29
        Width = 60
        Height = 18
        AutoSize = False
        Caption = 'Long. Av'
        Transparent = True
        Layout = tlCenter
      end
      object LAR: TLabel
        Left = 5
        Top = 52
        Width = 60
        Height = 18
        AutoSize = False
        Caption = 'Long. AR'
        Transparent = True
        Layout = tlCenter
      end
      object LARG: TLabel
        Left = 5
        Top = 76
        Width = 60
        Height = 18
        AutoSize = False
        Caption = 'Largeur'
        Transparent = True
        Layout = tlCenter
      end
      object av: TLabel
        Left = 294
        Top = 29
        Width = 48
        Height = 18
        Alignment = taCenter
        AutoSize = False
        Caption = '100 %'
        Transparent = True
        Layout = tlCenter
      end
      object ar: TLabel
        Left = 294
        Top = 52
        Width = 48
        Height = 18
        Alignment = taCenter
        AutoSize = False
        Caption = '100 %'
        Transparent = True
        Layout = tlCenter
      end
      object la: TLabel
        Left = 294
        Top = 76
        Width = 48
        Height = 18
        Alignment = taCenter
        AutoSize = False
        Caption = '100 %'
        Transparent = True
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 2
        Top = 107
        Width = 342
        Height = 17
        Alignment = taCenter
        Caption = 'Amuser vous a modifier les Aiguilles ...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Franklin Gothic Medium'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object SB1: TScrollBar
        Left = 60
        Top = 30
        Width = 228
        Height = 17
        Cursor = crHandPoint
        Min = 1
        PageSize = 0
        Position = 50
        TabOrder = 0
        OnChange = SB1Change
      end
      object SB2: TScrollBar
        Left = 60
        Top = 53
        Width = 228
        Height = 17
        Cursor = crHandPoint
        Min = 1
        PageSize = 0
        Position = 50
        TabOrder = 1
        OnChange = SB2Change
      end
      object SB3: TScrollBar
        Left = 60
        Top = 77
        Width = 228
        Height = 17
        Cursor = crHandPoint
        Max = 20
        Min = 1
        PageSize = 0
        Position = 20
        TabOrder = 2
        OnChange = SB3Change
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1132
    Height = 37
    Align = alTop
    TabOrder = 2
    object Label2: TLabel
      Left = 528
      Top = 11
      Width = 570
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Label2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial Rounded MT Bold'
      Font.Style = []
      ParentFont = False
    end
    object RB: TRadioButton
      Left = 7
      Top = 7
      Width = 467
      Height = 25
      Alignment = taLeftJustify
      Caption = 
        ' La  LED est declenche chaque seconde (Evenement OnSeconde) ----' +
        '>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Cambria'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object RA: TRadioButton
      Left = 481
      Top = 10
      Width = 21
      Height = 20
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
end
