unit Umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, MDClock, jpeg, IniFiles , ColorGrd;

type
  TFMain = class(TForm)
    Button1: TButton;
    RB: TRadioButton;
    Panel2: TPanel;
    B1: TCheckBox;
    B2: TCheckBox;
    B3: TCheckBox;
    B4: TCheckBox;
    B5: TCheckBox;
    B6: TCheckBox;
    B7: TCheckBox;
    B8: TCheckBox;
    B9: TCheckBox;
    B10: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    GCA: TRadioGroup;
    CA: TColorGrid;
    RA: TRadioButton;
    GAig: TRadioGroup;
    GTaille: TGroupBox;
    SB1: TScrollBar;
    SB2: TScrollBar;
    LAV: TLabel;
    LAR: TLabel;
    LARG: TLabel;
    SB3: TScrollBar;
    av: TLabel;
    ar: TLabel;
    la: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure B2Click(Sender: TObject);
    procedure B3Click(Sender: TObject);
    procedure B4Click(Sender: TObject);
    procedure B5Click(Sender: TObject);
    procedure B6Click(Sender: TObject);
    procedure B7Click(Sender: TObject);
    procedure B8Click(Sender: TObject);
    procedure B9Click(Sender: TObject);
    procedure B10Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CAChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GAigClick(Sender: TObject);
    procedure SB1Change(Sender: TObject);
    procedure SB2Change(Sender: TObject);
    procedure SB3Change(Sender: TObject);
    procedure GCAClick(Sender: TObject);
  private
    { Déclarations privées }
    function GetFontList:Tstrings;
    procedure LireIni;
    Procedure EcrireIni;
  public
    { Déclarations publiques }
    Pendule : TClock;
    Compteur : Integer;
    Chemin : String;
    Procedure DoSeconde(Sender: TObject);
    Procedure DoMinute(Sender: TObject);
  end;

var
  FMain: TFMain;
Const
  Forme :Array[0..6]of TForme = (LigneSimple,Rectangle,RectanglePointu,Losange,Fleche,Cercle,Triangle);
implementation

{$R *.dfm}
function TFMain.GetFontList;
var
screen :Tscreen;
begin
  screen := Tscreen.Create(nil);
  Getfontlist := screen.fonts;
end;

Procedure TFMain.LireIni;
// Lire le Fichier Pendule.INI
var
  INI : Tinifile;
Begin
  INI := Tinifile.Create(Chemin+'Pendule.INI');

  Pendule.Logo.Texte := INI.ReadString('Michel','TexteLogo','Inform@tSystem');
  Pendule.Font.Name:=INI.ReadString('Michel','Fonte','Comic Sans MS');
  Pendule.Aig_Centieme.CouleurFond:=Ini.ReadInteger('Aiguille','CoulCentieme',ClSilver);
  Pendule.Aig_Seconde.CouleurFond:=Ini.ReadInteger('Aiguille','CoulSeconde',ClRed);
  Pendule.Aig_Minute.CouleurFond:=Ini.ReadInteger('Aiguille','CoulMinute',ClGray);
  Pendule.Aig_Heure.CouleurFond:=Ini.ReadInteger('Aiguille','CoulHeure',ClGray);
  Pendule.Pinceau:=Ini.ReadInteger('Cadre','Coulpinceau',ClGray);
  GCA.ItemIndex:=Ini.ReadInteger('Option','ChoixCouleur',4);
  B1.Checked:=Ini.ReadBool('Option','B1',True);
  B2.Checked:=Ini.ReadBool('Option','B2',True);
  B3.Checked:=Ini.ReadBool('Option','B3',True);
  B4.Checked:=Ini.ReadBool('Option','B4',True);
  B5.Checked:=Ini.ReadBool('Option','B5',True);
  B6.Checked:=Ini.ReadBool('Option','B6',True);
  B7.Checked:=Ini.ReadBool('Option','B7',True);
  B8.Checked:=Ini.ReadBool('Option','B8',True);
  B9.Checked:=Ini.ReadBool('Option','B9',True);
  B10.Checked:=Ini.ReadBool('Option','B10',True);

  INI.free;

End;

Procedure TFMain.EcrireIni;
// Ecrire le fichier Pendule.INI
var
  INI : Tinifile;
begin
  INI := Tinifile.Create(Chemin+'Pendule.INI');

  INI.WriteString('Michel','texteLogo',Edit1.Text);
  INI.WriteString('Michel','Fonte',Pendule.Font.Name);
  INI.WriteInteger('Aiguille','CoulCentieme',Pendule.Aig_Centieme.CouleurFond);
  INI.WriteInteger('Aiguille','CoulSeconde',Pendule.Aig_Seconde.CouleurFond);
  INI.WriteInteger('Aiguille','CoulMinute',Pendule.Aig_Minute.CouleurFond);
  INI.WriteInteger('Aiguille','CoulHeure',Pendule.Aig_Heure.CouleurFond);
  INI.WriteInteger('Cadre','CoulPinceau',Pendule.Pinceau);
  INI.WriteInteger('Option','ChoixCouleur',GCA.ItemIndex);
  INI.WriteBool('Option','B1',B1.Checked);
  INI.WriteBool('Option','B2',B2.Checked);
  INI.WriteBool('Option','B3',B3.Checked);
  INI.WriteBool('Option','B4',B4.Checked);
  INI.WriteBool('Option','B5',B5.Checked);
  INI.WriteBool('Option','B6',B6.Checked);
  INI.WriteBool('Option','B7',B7.Checked);
  INI.WriteBool('Option','B8',B8.Checked);
  INI.WriteBool('Option','B9',B9.Checked);
  INI.WriteBool('Option','B10',B10.Checked);

  INI.free;
End;

procedure TFMain.B2Click(Sender: TObject);
begin
  Pendule.Chiffre_Heure:=B2.Checked;
end;

procedure TFMain.B3Click(Sender: TObject);
begin
  Pendule.Aig_Centieme.Visible:=B3.Checked;
end;

procedure TFMain.B4Click(Sender: TObject);
begin
  Pendule.Aig_Seconde.Visible:=B4.Checked;
end;

procedure TFMain.B5Click(Sender: TObject);
begin
  Pendule.Aig_Minute.Visible:=B5.Checked;
end;

procedure TFMain.B6Click(Sender: TObject);
begin
  pendule.Aig_Heure.Visible:=B6.Checked;
end;

procedure TFMain.B7Click(Sender: TObject);
begin
  Pendule.Date.Visible:=B7.Checked;
end;

procedure TFMain.B8Click(Sender: TObject);
begin
  Pendule.Logo.Visible:=B8.Checked;
end;

procedure TFMain.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFMain.CAChange(Sender: TObject);
begin
  case GCA.ItemIndex of
  0 :Pendule.Aig_Heure.CouleurFond:=CA.ForegroundColor;
  1 :Pendule.Aig_Minute.CouleurFond:=CA.ForegroundColor;
  2 :Pendule.Aig_Seconde.CouleurFond:=CA.ForegroundColor;
  3 :Pendule.Aig_Centieme.CouleurFond:=CA.ForegroundColor;
  4 :Pendule.Pinceau:=CA.ForegroundColor;
  end;
end;

procedure TFMain.B10Click(Sender: TObject);
begin
  Pendule.Graduation:=B10.Checked;
end;

procedure TFMain.B1Click(Sender: TObject);
begin
  pendule.Chiffre_Minute:=B1.Checked;
end;

procedure TFMain.B9Click(Sender: TObject);
begin
  Pendule.Glissement:=B9.Checked;
end;

procedure TFMain.DoMinute;
begin
  Compteur:=Compteur + 1;
  label2.Caption:=('Il y a '+IntToStr(Compteur)+' Minute(s) Ecoulée(s) ( Evenement OnMinute)');
end;

procedure TFMain.Edit1Change(Sender: TObject);
begin
  Pendule.Logo.Texte:=Edit1.Text;
end;

procedure TFMain.FormActivate(Sender: TObject);
begin
  LireIni;
  label2.Caption:=('Il y a '+IntToStr(Compteur)+' Minute(s) Ecoulée(s) ( Evenement OnMinute)');
  Edit1.Text:=Pendule.Logo.Texte;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  Chemin:=ExtractFilePath(Application.ExeName);
  DoubleBuffered:=True;
  Pendule:=TClock.Create(Self);
  Pendule.Parent:=Self;
  Pendule.Align:=AlClient;
  Pendule.OnSeconde:=DoSeconde;
  Pendule.OnMinute:=DoMinute;
  Compteur:=0;

end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  EcrireIni;
  Pendule.Free;
end;

procedure TFMain.DoSeconde;
begin
   RB.Checked:=Not RB.Checked;
   RA.Checked:=Not RB.Checked;
end;
procedure TFMain.GAigClick(Sender: TObject);
begin
  case GCA.ItemIndex of
  0 : Pendule.Aig_Heure.Forme:= Forme[Gaig.ItemIndex];
  1 :Pendule.Aig_Minute.Forme:=Forme[Gaig.ItemIndex];
  2 :Pendule.Aig_Seconde.Forme:=Forme[Gaig.ItemIndex];
  3 :Pendule.Aig_Centieme.Forme:=Forme[Gaig.ItemIndex];
  end;
end;

procedure TFMain.SB1Change(Sender: TObject);
begin
  case GCA.ItemIndex of
  0 :Pendule.Aig_Heure.LongAvant:=SB1.Position;
  1 :Pendule.Aig_Minute.LongAvant:=SB1.Position;
  2 :Pendule.Aig_Seconde.LongAvant:=SB1.Position;
  3 :Pendule.Aig_Centieme.LongAvant:=SB1.Position;
  end;
  AV.Caption:=IntToStr(SB1.Position)+' %';
end;

procedure TFMain.SB2Change(Sender: TObject);
begin
  case GCA.ItemIndex of
  0 :Pendule.Aig_Heure.LongArriere:=SB2.Position;
  1 :Pendule.Aig_Minute.LongArriere:=SB2.Position;
  2 :Pendule.Aig_Seconde.LongArriere:=SB2.Position;
  3 :Pendule.Aig_Centieme.LongArriere:=SB2.Position;
  end;
  AR.Caption:=IntToStr(SB2.Position)+' %';
end;

procedure TFMain.SB3Change(Sender: TObject);
begin
  case GCA.ItemIndex of
  0 :Pendule.Aig_Heure.Largeur:=SB3.Position;
  1 :Pendule.Aig_Minute.Largeur:=SB3.Position;
  2 :Pendule.Aig_Seconde.Largeur:=SB3.Position;
  3 :Pendule.Aig_Centieme.Largeur:=SB3.Position;
  end;
  LA.Caption:=IntToStr(SB3.Position)+' %';
end;

procedure TFMain.GCAClick(Sender: TObject);
begin
  case GCA.ItemIndex of
  0 :Begin
      SB1.Position:=Pendule.Aig_Heure.LongAvant;
      SB2.Position:=Pendule.Aig_Heure.LongArriere;
      SB3.Position:=Pendule.Aig_Heure.Largeur;
    End;
  1 :Begin
      SB1.Position:=Pendule.Aig_Minute.LongAvant;
      SB2.Position:=Pendule.Aig_Minute.LongArriere;
      SB3.Position:=Pendule.Aig_Minute.Largeur;
    End;
  2 :Begin
      SB1.Position:=Pendule.Aig_Seconde.LongAvant;
      SB2.Position:=Pendule.Aig_Seconde.LongArriere;
      SB3.Position:=Pendule.Aig_Seconde.Largeur;
    End;
  3 :Begin
      SB1.Position:=Pendule.Aig_Centieme.LongAvant;
      SB2.Position:=Pendule.Aig_Centieme.LongArriere;
      SB3.Position:=Pendule.Aig_Centieme.Largeur;
    End;
  4 :Begin
      SB1.Position:=100;
      SB2.Position:=100;
      SB3.Position:=100;
    End;
  End;
End;

end.
