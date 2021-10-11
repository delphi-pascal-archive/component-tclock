unit MDClock;
//  Merci a beaucoup de monde de Code Source , pour avoir puisé des idées dans
// leurs travaux , d'avoir repondu a des questions sur le forum, Bref tout
// simplement pour ce site consacré a l'amitié et aux conseils.
interface

uses
  Windows, Messages,SysUtils, Variants,Classes, Graphics,Controls, Forms,
  Dialogs, ExtCtrls,StdCtrls ,Math ,DateUtils, jpeg ,MMSystem  ;

type

  // Forme d'Aiguille
  TForme = (LigneSimple,Rectangle,RectanglePointu,Losange,Fleche,Cercle,Triangle);

  // Position d'un texte rapport au cadran
  TPosition = (Gauche,Droite,Haut,Bas);

  // Creation d'un Texte personalise
  TTexte = Class(TPersistent)
  Private
    VTexte : String;
    VTaille : Integer;
    VCouleur : TColor;
    Vposition : TPosition;
    VVisible : Boolean;
    Procedure SetTexte (Value:String);
    Procedure SetTaille(Value:Integer);
    Procedure SetCouleur(Value:TColor);
    Procedure SetPosition(Value:TPosition);
    Procedure SetVisible(Value:Boolean);
  Protected
  Public
  Published
    Property Texte : String Read VTexte Write SetTexte;
    Property Taille : Integer Read VTaille Write SetTaille;
    Property Couleur : TColor Read VCouleur Write SetCouleur;
    Property Position : TPosition Read VPosition Write SetPosition;
    Property Visible : Boolean Read VVisible Write SetVisible;
  End;

  // Creation d'une Aiguille
  TAiguille = Class(TPersistent)
  Private
   VForme : TForme;
   VCouleurFond : TColor;
   VCouleurTrait : TColor;
   VLongAV : Integer;
   VLongAR : Integer;
   VLargeur : Integer;
   VEpaisseur : Integer;
   VVisible : Boolean;
   Procedure SetForme(value :TForme);
   Procedure SetCouleurFond(Value:TColor);
   Procedure SetCouleurtrait(Value:TColor);
   Procedure SetlongueurAV(Value:Integer);
   Procedure SetLongueurAR(Value:Integer);
   Procedure SetLargeur(Value:Integer);
   Procedure SetEpaisseur(Value:Integer);
   Procedure SetVisible(Value:Boolean);  
  Protected
  Public
  Published
   Property CouleurFond: TColor Read VCouleurFond Write SetCouleurFond Default ClBtnFace;
   Property CouleurTrait: TColor Read VCouleurTrait Write SetCouleurtrait Default Clblack;
   Property Epaisseur: Integer Read VEpaisseur Write SetEpaisseur Default 1;
   Property LongAvant: Integer Read VLongAV Write SetlongueurAV Default 90;
   Property LongArriere: Integer Read VLongAR Write SetLongueurAR Default 20;
   Property Forme: TForme Read VForme Write SetForme;
   Property Visible:Boolean Read VVisible Write SetVisible Default True;
   Property Largeur:Integer Read VLargeur Write SetLargeur Default 3;
  End;

  // Creation du cadran
  TClock = class(TImage)
  Private
    { Déclarations privées }
    VHeure : TAiguille;  // Variable Heure
    VMinute : TAiguille; // Variable Minute
    VSeconde: TAiguille; // Variable Seconde
    VCentieme : TAiguille;  // Variable centieme de Seconde
    VGlisser : Boolean; // Variable Glisser pour avoir un mouvement de Glissé
                        // ou Saccadé de la trotteuse .
    VChiffreH : Boolean;  //Voir les Chiffres des Heures du cadran
    VChiffreM : Boolean;  // Voir les chiffres des Minutes  du cadran
    VGraduation : Boolean;  // Voir les Graduationsdu cadran
    VTempo  : TTimer;   // Variable du Timer
    VHorloge : TBitMap;    // Variable Image Horloge
    VAiguille : TBitMap;   //Variable image Aiguille
    VPinceau : TColor;    // Variable Couleur des Elements du Cadran
    VOnSeconde : TNotifyEvent;  // Variale d'un evenement des secondes
    VOnMinute : TNotifyEvent;   // Variable d'un evenement des minutes
    VOnHeure : TNotifyEvent;    // Variable d'un evenement des heures
    VDate : TTexte; // Texte du jour
    VLogo : TTexte; // Texte de ton logo
    Procedure SetGlisser(value : Boolean);
    Procedure SetChiffreH(Value :Boolean);
    Procedure SetChiffreM(Value :Boolean);
    Procedure SetGraduation(value:Boolean);
    Procedure SetPinceau(Value : TColor);
    Procedure SetHeure(Value: TAiguille);
    Procedure SetMinute(Value: TAiguille);
    Procedure SetSeconde(Value: TAiguille);
    Procedure SetCentieme(Value: TAiguille);
    Procedure SetDate(Value:TTexte);
    Procedure SetLogo(Value:TTexte);
    function CalculAngle(Indice : Integer ;Heu,Min,Sec,Csec: Word): Real;
    Procedure DessinerFond;
    Procedure DessinerAiguille;
  Protected
    Procedure Evenement_Tempo(Sender:TObject);
    procedure ImageChange(Sender: TObject);
    Procedure DessinAiguille(Aiguille : integer; Support : TCanvas ;
                              POrig : TPoint);
  public
    PO : Tpoint; // coordonnées du centre de l'horloge
    Rayon,                  // Rayon initial
    HT,MT,ST,CsT : Word;    // Recuperation des variables du format DateTime
    OldH,OldM,OldS,OldC : Word;  // Sauvegarde de l'heure

    Constructor Create(Aowner : TComponent);Override;
    Destructor Destroy ; Override;
  Published
    Property Glissement : Boolean Read VGlisser Write SetGlisser;
    Property Chiffre_Heure :Boolean Read VChiffreH Write SetChiffreH;
    Property Chiffre_Minute :Boolean Read VChiffreM Write SetChiffreM;
    Property Graduation :Boolean Read VGraduation Write SetGraduation;
    Property Pinceau : TColor Read VPinceau Write SetPinceau;
    Property Aig_Heure: TAiguille Read Vheure Write SetHeure;
    Property Aig_Minute: TAiguille Read VMinute Write SetMinute;
    Property Aig_Seconde: TAiguille Read VSeconde Write SetSeconde;
    Property Aig_Centieme: TAiguille Read VCentieme Write SetCentieme;
    property OnSeconde : TNotifyEvent read VOnSeconde write VOnSeconde;
    property OnMinute : TNotifyEvent read VOnMinute write VOnMinute;
    property OnHeure   : TNotifyEvent read VOnHeure   write VOnHeure;
    Property Date : TTexte read VDate Write SetDate;
    Property Logo : TTexte Read VLogo Write SetLogo;
    Property Font;
  End;
  Procedure Register;

CONST
  Non: Boolean = False;
  Oui: Boolean = True;
  // c'est pour mon cadran exterieur, c'est vraiment du basic
  Degrade : Array[0..7]of TColor=(ClGray,$00004444,$00005E5E,$00009191,
                                  $0000A8A8,$0000BBBB,$00009191,ClBlack);

implementation

procedure Register;
begin
  RegisterComponents('Michel34', [TClock]);
end;
//  construction de mon composant
Constructor TClock.Create(Aowner: TComponent);
Begin
  Inherited Create(Aowner);
  // creation de l'aiguille des heures
  Aig_Heure:=TAiguille.Create;
  With Aig_Heure do
  Begin
    CouleurFond:= ClBtnFace;
    Couleurtrait:= ClBlack;
    Forme:=Losange;
    Epaisseur:=1;
    LongAvant:=50;
    LongArriere:=20;
    Largeur:=4;
    Visible:=OUI;
  End;
  // creation de l'aiguille des Minutes
  Aig_Minute:=TAiguille.Create;
  With Aig_Minute do
  Begin
    CouleurFond:= ClBtnFace;
    Couleurtrait:= ClBlack;
    Forme:=Losange;
    Epaisseur:=1;
    LongAvant:=75;
    LongArriere:=20;
    Largeur:=4;
    Visible:=OUI;
  End;
  // creation de l'aiguille des Secondes
  Aig_Seconde:=TAiguille.Create;
  With Aig_Seconde Do
  Begin
    CouleurFond:= ClBtnFace;
    Couleurtrait:= ClSilver;
    Forme:=Rectangle;
    Epaisseur:=1;
    LongAvant:=85;
    LongArriere:=35;
    Largeur:=2;
    Visible:=OUI;
  End;
  // creation de l'aiguille des Centiemes de Seconde
  Aig_Centieme:=TAiguille.Create;
  With Aig_Centieme Do
  Begin
    CouleurFond:= ClBtnFace;
    Couleurtrait:= ClBlack;
    Forme:=LigneSimple;
    Epaisseur:=1;
    LongAvant:=70;
    LongArriere:=10;
    Largeur:=2;
    Visible:=OUI;
  End;
  // Creation de la Date
  Date:=TTexte.Create;
  Date.Texte:='DDD DD';
  Date.Taille:=10;
  Date.Couleur:=ClRed;
  Date.Position:=Haut;
  Date.Visible:=OUI;
  // Creation du Logo
  Logo:=TTexte.Create;
  Logo.Texte:='Inform@tSystem';
  Logo.Taille:=6;
  Logo.Couleur:=ClGray;
  Logo.Position:=Bas;
  Logo.Visible:=OUI;
  // On continue
  Width := 200;
  Height := 200;
  Picture.Bitmap.PixelFormat := Pf24Bit;
  Transparent:=OUI;
  Color:=ClBtnFace;
  VChiffreH:=OUI;
  VChiffreM:=OUI;
  VGraduation:=OUI;
  VGlisser:=OUI;
  DecodeTime(Now,OldH,OldM,OldS,OldC);
  Picture.OnChange:=ImageChange;
  // Je cree le BitMap qui va servir de support pour le cadran et celui qui
  // affichera mes aiguilles
  VHorloge:=TBitmap.Create;
  VAiguille:=TBitMap.Create;
  // Je cree mon Timer et le regle a 1 seconde,
  VTempo:=TTimer.Create(Self);
  VTempo.Interval:=1000;
  VTempo.OnTimer:=Evenement_Tempo;
  VTempo.Enabled:=OUI;
End;
// Destruction de tous les Objets cree par mes soins.
Destructor TClock.Destroy;
Begin
  VHorloge.Free;
  VAiguille.Free;
  VTempo.Free;
  Inherited Destroy;
End;

Procedure TTexte.SetTexte(Value: string);
begin
  VTexte:=Value;
end;

Procedure TTexte.SetTaille(Value: Integer);
begin
  Vtaille:=Value ;
end;

Procedure TTexte.SetCouleur(Value: TColor);
begin
  VCouleur:=Value;
end;

Procedure TTexte.SetPosition(Value: TPosition);
begin
  VPosition:=Value;
end;

Procedure TTexte.SetVisible(Value: Boolean);
begin
  VVisible:=Value;
end;

Procedure TAiguille.SetCouleurFond(Value:TColor);
Begin
  VCouleurFond:=Value;
End;

Procedure TAiguille.SetCouleurtrait(Value:TColor);
Begin
  VCouleurTrait:=Value;
End;

Procedure TAiguille.SetEpaisseur(Value:Integer);
Begin
  If (Value < 1) Or (Value > 100) Then
  Begin
   ShowMessage('Valeur comprise entre 1 et 100');
   Exit;
  End;
  VEpaisseur:=Value;
End;

Procedure TAiguille.SetForme(Value:TForme);
Begin
  VForme:=Value;
End;

Procedure TAiguille.SetLargeur(Value:Integer);
Begin
  If (Value < 1) Or (Value > 100) Then
  Begin
   ShowMessage('Valeur comprise entre 1 et 100');
   Exit;
  End;
  VLargeur:=Value;
End;

Procedure TAiguille.SetLongueurAR(Value:integer);
Begin
  If (Value < 1) Or (Value > 100) Then
  Begin
   ShowMessage('Valeur comprise entre 1 et 100');
   Exit;
  End;
  VLongAR:=Value;
End;

Procedure TAiguille.SetlongueurAV(Value:Integer);
Begin
  If (Value < 1) Or (Value > 100) Then
  Begin
   ShowMessage('Valeur comprise entre 1 et 100');
   Exit;
  End;
  VLongAV:=Value;
End;

Procedure TAiguille.SetVisible(Value:Boolean);
Begin
  VVisible:=Value;
End;

Procedure TClock.Evenement_Tempo(Sender : Tobject);
Var
  H,M,S,C : Word;
Begin
  DecodeTime(Now,H,M,S,C);
  //
  if Assigned( VOnSeconde) AND (S <> OldS) then
  Begin
    VOnSeconde( Self);
    OldS:=S;
  End;
  if Assigned( VOnMinute) AND (M <> OldM) then
  Begin
    VOnMinute( Self);
    OldM:=M;
  End;
  if Assigned( VOnHeure) AND (H <> OldH) then
  Begin
    VOnHeure( Self);
    OldH:=H;
  End;
  DessinerAiguille;
End;

Procedure TClock.DessinerFond;
var
  N,X,Y,Z : integer;
  Delta : Integer;
  Decalage  : Extended;
  S     : String;
  DG : Integer;
Begin
  // on calcul le centre de l'image
  PO  := point(width div 2, height div 2);
  // Ensuite le rayon de notre Horloge
  Rayon := Min(PO.X,PO.Y)-5;
  VHorloge.Width:=Width;
  VHorloge.Height:=Height;
  // Dessiner les chiffres et tout ce que l'on veut
  with VHorloge.Canvas do begin
  // Fond
  Brush.Color := Color;
  Pen.Color   := Color;
  Rectangle(0,0,Width,Height);
  Pen.Color := VPinceau;
  // Cadran
  Delta:=(Rayon *1)div 100;
  For Z := 0 To 7 Do
  Begin
    pen.Width := Delta+1;
    If Z = 7 then Pen.Width:=2;
    Pen.Color:=Degrade[Z];
    X := PO.X ;
    Y := PO.Y ;
    DG:= Rayon - Z - ((Delta)*Z);
    Ellipse(X+DG,Y+DG,X-DG,Y-DG);
  End;
  // Je calcul mon diviseur Par rapport a la taille du rayon
  // pour etre coherent quand je change de resolution
  // j'ai choisi un pourcentage  ICI --> 15 %

  Delta:=(Rayon *15)div 100;
  Brush.Color:=ClBlack;
  // Graduation des heures et des minutes
  If VGraduation Then
  for N := 1 to 60 do
  begin
    if (N mod 5=0)And(Chiffre_minute=OUI) then
      pen.Color := Color else
      If (N Mod 5=0)Then Pen.Width:=3 Else Pen.Width:=1;
      pen.Color := VPinceau;

    Decalage := CalculAngle(3,0,N,0,0);
    X := PO.X + ROUND((Rayon-Delta)*Cos(Decalage));
    Y := PO.Y + ROUND((Rayon-Delta)*Sin(Decalage));
    MoveTo(X, Y);
    Ellipse(X+(Delta div 10),Y+(Delta div 10),
            X-(Delta div 10),Y-(Delta div 10));
  End;
   Brush.Color:=Color;

  // Ecriture de la date
  if Date.Visible then
  Begin
    Font.Size:=(Rayon * Date.Taille) div 100;
    Pen.Color:=Date.Couleur;
    case Date.Position of
      Droite:Decalage := CalculAngle(3,0,0,0,0);
      Haut:Decalage := CalculAngle(3,0,45,0,0);
      Gauche:Decalage := CalculAngle(3,0,90,0,0);
      Bas:Decalage := CalculAngle(3,0,135,0,0);
    end;
    X := PO.X + ROUND((Rayon div 3)*Cos(Decalage));
    Y := PO.Y + ROUND((Rayon div 3)*Sin(Decalage));
    MoveTo(X, Y);
    S:=FormatDateTime(Date.Texte,Now);
    S:=(UpperCase(S[1])+Copy(S,2,20));
    TextOut(X-(TextWidth(S) div 2),Y-(TextHeight(S) div 2),S);
  End;
  // Mon Logo
  if Logo.Visible then
  Begin
    Font.Size:=(Rayon*Logo.Taille) div 100;
    Pen.Color:=Logo.Couleur;
    case Logo.Position of
      Droite:Decalage := CalculAngle(3,0,0,0,0);
      Haut:Decalage := CalculAngle(3,0,45,0,0);
      Gauche:Decalage := CalculAngle(3,0,90,0,0);
      Bas:Decalage := CalculAngle(3,0,135,0,0);
    end;
    X := PO.X + ROUND((Rayon div 3)*Cos(Decalage));
    Y := PO.Y + ROUND((Rayon div 3)*Sin(Decalage));
    MoveTo(X,Y);
    S:=Logo.Texte;
    TextOut(X-(TextWidth(S) div 2),Y-(TextHeight(S) div 2),S);
  End;

  // Texte des Heures & Minutes
  Font.Color := VPinceau;
  Font.Name  := Self.Font.Name;
  for N := 1 to 12 do
  begin
    Decalage := CalculAngle(4,N+9,0,0,0);

    // Heures
    Delta:=(Rayon *30)div 100;
    Font.Size := (Delta *45) div 100;
    Font.Style:=Font.Style+[FsBold];
    X := PO.X + ROUND((Rayon-(Delta*1))*Cos(Decalage));
    Y := PO.Y + ROUND((Rayon-(Delta*1))*Sin(Decalage));
    S := IntToStr(N);
    If VChiffreH Then TextOut(X-(TextWidth(S) div 2),Y-(TextHeight(S) div 2),S);

    // Minutes
    Delta:=(Rayon *15)div 100;
    Font.Size := Round(Delta div 4);
    Font.Style:=Font.Style-[FsBold];
    X := PO.X + ROUND((Rayon-(Delta*1))*Cos(Decalage));
    Y := PO.Y + ROUND((Rayon-(Delta*1))*Sin(Decalage));
    S := IntToStr(N * 5);
    if s = '5' Then s := '05';
    if S = '60' then S := '00';
    If VChiffreM Then TextOut(X-(TextWidth(S) div 2),Y-(TextHeight(S) div 2),S);
    End;
  End;
  // Pour eviter les saccades de l'Image en mode conception, le doubleBuffered
  // n'est pas actif dans un TImage;
   if (csDesigning in ComponentState)
      //action souhaitée si on est en mode conception
    then VTempo.Interval:=800
      // action souhaitée si on est en mode exécution
    else VTempo.Interval:=20;
end;

Procedure TClock.DessinerAiguille;
Begin
  Self.Invalidate;
  VAiguille.Width:=Width;
  VAiguille.Height:=Height;
  with VAiguille.Canvas do
  begin
    Brush.Color := Color;
    // On recupere le fond a partir de l'image VHorloge
    Draw(0,0,VHorloge);
    // Et on affiche nos Aiguilles
    If Aig_Centieme.Visible Then DessinAiguille(1,VAiguille.Canvas,PO);
    If Aig_Heure.Visible Then DessinAiguille(4,VAiguille.Canvas,PO);
    If Aig_Minute.Visible Then DessinAiguille(3,VAiguille.Canvas,PO);
    If Aig_Seconde.Visible Then DessinAiguille(2,VAiguille.Canvas,PO);
  End;
    // Cercle interieur
  VAiguille.Canvas.Brush.Color:=ClWhite;
  VAiguille.Canvas.Ellipse(PO.X+(Rayon *2)div 100,
                            PO.Y+(Rayon *2)div 100,
                            PO.X-(Rayon *2)div 100,
                            PO.Y-(Rayon *2)div 100);
   //Notre horloge est complete alors
  // on assigne notre Bitmap a l'image de destination
  Self.Picture.Bitmap.Assign(VAiguille);
End;

Procedure TClock.DessinAiguille(Aiguille : integer; Support : TCanvas ;
                                POrig : TPoint);
Var
  // Notre grille de points
  pt            : Array[0..11] OF Tpoint;
  // Notre Polygone
  Dessin        : Array[0..5] Of TPoint;
  // Calcul de l'angle de l'aiguille
  DeportH       : Integer;
  DeportM       : Integer;
  DeportS       : Integer;
  DeportC       : Integer;
  Largeur       : Integer;
  AV            : Integer;
  AR            : Integer;
  Style         : TForme;

Begin
  // Type d'Aiguille pour le decalage,L'epaisseur du pinceau ,la couleur
  // du trait,la couleur de fond.
  Case Aiguille of
    1 : Begin   // Centieme de seconde
          DecodeTime(IncMillisecond(Now,-250),HT,MT,ST,CsT);
          With Support do
          Begin
            Pen.Width := Aig_Centieme.Epaisseur;
            pen.Color:=Aig_Centieme.CouleurTrait;
            Brush.Color:=Aig_Centieme.CouleurFond;
          End;
          Largeur:=Aig_Centieme.Largeur;
          Style:=Aig_Centieme.Forme;
          AV:=Aig_Centieme.LongAvant;
          AR:=Aig_Centieme.LongArriere;
        End;
    2 : Begin   // Seconde
          DecodeTime(Incsecond(Now,-15),HT,MT,ST,CsT);
          With Support do
          Begin
            Pen.Width := Aig_Seconde.Epaisseur;
            pen.Color:=Aig_Seconde.CouleurTrait;
            Brush.Color:=Aig_Seconde.CouleurFond;
          End;
          Largeur:=Aig_Seconde.Largeur;
          Style:=Aig_Seconde.Forme;
          AV:=Aig_Seconde.LongAvant;
          AR:=Aig_Seconde.LongArriere;
        End;
    3 : Begin   // Minute
          DecodeTime(IncMinute(Now,-15),HT,MT,ST,CsT);
          With Support do
          Begin
            Pen.Width := Aig_Minute.Epaisseur;
            pen.Color:=Aig_Minute.CouleurTrait;
            Brush.Color:=Aig_Minute.CouleurFond;
          End;
          Largeur:=Aig_Minute.Largeur;
          Style:=Aig_Minute.Forme;
          AV:=Aig_Minute.LongAvant;
          AR:=Aig_Minute.LongArriere;
        End;
    4 : Begin   // Heure
          DecodeTime(IncHour(Now,-3),HT,MT,ST,CsT);
          With Support do
          Begin
            Pen.Width := Aig_Heure.Epaisseur;
            pen.Color:=Aig_Heure.CouleurTrait;
            Brush.Color:=Aig_Heure.CouleurFond;
          End;
          Largeur:=Aig_Heure.Largeur;
          Style:=Aig_Heure.Forme;
          AV:=Aig_Heure.LongAvant;
          AR:=Aig_Heure.LongArriere;
        End;
    End;
  // On Convertis nos Variables de longueur avant et arriere , largeur .
  AV:=(Rayon*AV) div 100;
  AR:=(Rayon*AR)div 100;
  Largeur:=(Rayon*Largeur) div 100;
  // On calcul notre grille de point

  Pt[9].X:=POrig.X;
  Pt[9].Y:=POrig.Y;

  DeportH:=0;DeportM:=0;DeportS:=0;DeportC:=0;
  Case Aiguille Of
    1 : DeportC:=250;
    2 : DeportS:=15;
    3 : DeportM:=15;
    4 : DeportH:=3;
    End;

  Pt[10].X := Pt[9].X +ROUND(-(Largeur div 2)*Cos(CalculAngle(Aiguille,
                HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  Pt[10].Y := Pt[9].Y +ROUND(-(largeur div 2)*Sin(CalculAngle(Aiguille,
                HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));

  Case Aiguille Of
    1 : DeportC:=750;
    2 : DeportS:=45;
    3 : DeportM:=45;
    4 : DeportH:=9;
    End;

  Pt[11].X := Pt[9].X +ROUND(-(Largeur div 2)*Cos(CalculAngle(Aiguille,
                HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  Pt[11].Y := Pt[9].Y +ROUND(-(Largeur div 2)*Sin(CalculAngle(Aiguille,
                HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));

  Pt[0].X := Pt[9].X +ROUND((AV-AR)*Cos(CalculAngle(Aiguille,HT,MT,ST,CsT)));
  Pt[0].Y := Pt[9].Y +ROUND((AV-AR)*Sin(CalculAngle(Aiguille,HT,MT,ST,CsT)));

  DeportH:=0;DeportM:=0;DeportS:=0;DeportC:=0;
  Case Aiguille Of
    1 : DeportC:=250;
    2 : DeportS:=15;
    3 : DeportM:=15;
    4 : DeportH:=3;
    End;

  Pt[1].X := Pt[0].X +ROUND(-(Largeur div 2)*Cos(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  Pt[1].Y := Pt[0].Y +ROUND(-(largeur div 2)*Sin(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));

  Case Aiguille Of
    1 : DeportC:=750;
    2 : DeportS:=45;
    3 : DeportM:=45;
    4 : DeportH:=9;
    End;

  Pt[2].X := Pt[0].X +ROUND(-(Largeur div 2)*Cos(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  Pt[2].Y := Pt[0].Y +ROUND(-(Largeur div 2)*Sin(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));

  Pt[3].X := Pt[9].X +ROUND(AV*Cos(CalculAngle(Aiguille,HT,MT,ST,CsT)));
  Pt[3].Y := Pt[9].Y +ROUND(AV*Sin(CalculAngle(Aiguille,HT,MT,ST,CsT)));

  DeportH:=0;DeportM:=0;DeportS:=0;DeportC:=0;
  Case Aiguille Of
    1 : DeportC:=250;
    2 : DeportS:=15;
    3 : DeportM:=15;
    4 : DeportH:=3;
    End;

  Pt[4].X := Pt[3].X +ROUND(-(Largeur div 2)*Cos(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  Pt[4].Y := Pt[3].Y +ROUND(-(largeur div 2)*Sin(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));

  Case Aiguille Of
    1 : DeportC:=750;
    2 : DeportS:=45;
    3 : DeportM:=45;
    4 : DeportH:=9;
    End;

  Pt[5].X := Pt[3].X +ROUND(-(Largeur div 2)*Cos(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  Pt[5].Y := Pt[3].Y +ROUND(-(Largeur div 2)*Sin(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));

  Pt[6].X := Pt[9].X +ROUND(-(AR)*Cos(CalculAngle(Aiguille,HT,MT,ST,CsT)));
  Pt[6].Y := Pt[9].Y +ROUND(-(AR)*Sin(CalculAngle(Aiguille,HT,MT,ST,CsT)));

  DeportH:=0;DeportM:=0;DeportS:=0;DeportC:=0;
  Case Aiguille Of
    1 : DeportC:=250;
    2 : DeportS:=15;
    3 : DeportM:=15;
    4 : DeportH:=3;
    End;

  Pt[7].X := Pt[6].X +ROUND(-(Largeur div 2)*Cos(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  Pt[7].Y := Pt[6].Y +ROUND(-(largeur div 2)*Sin(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));

  Case Aiguille Of
    1 : DeportC:=750;
    2 : DeportS:=45;
    3 : DeportM:=45;
    4 : DeportH:=9;
    End;

  Pt[8].X := Pt[6].X +ROUND(-(Largeur div 2)*Cos(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  Pt[8].Y := Pt[6].Y +ROUND(-(Largeur div 2)*Sin(CalculAngle(Aiguille,
              HT+DeportH,MT+DeportM,ST+DeportS,CsT+DeportC)));
  // je cree mon polygone par rapport a ma grille de points
  Case Style Of
  LigneSimple :
    Begin
      Dessin[0]:=Pt[6];
      Dessin[1]:=Pt[6];
      Dessin[2]:=Pt[6];
      Dessin[3]:=Pt[6];
      Dessin[4]:=Pt[6];
      Dessin[5]:=Pt[3];
    End;
  Fleche :
    Begin
      Dessin[0]:=Pt[6];
      Dessin[1]:=Pt[0];
      Dessin[2]:=Pt[2];
      Dessin[3]:=Pt[3];
      Dessin[4]:=Pt[1];
      Dessin[5]:=Pt[0];
    End;
  Triangle :
    Begin
      Dessin[0]:=Pt[0];
      Dessin[1]:=Pt[0];
      Dessin[2]:=Pt[2];
      Dessin[3]:=Pt[3];
      Dessin[4]:=Pt[1];
      Dessin[5]:=Pt[0];
    End;
  Rectangle :
    Begin
      Dessin[0]:=Pt[8];
      Dessin[1]:=Pt[5];
      Dessin[2]:=Pt[4];
      Dessin[3]:=Pt[7];
      Dessin[4]:=Pt[8];
      Dessin[5]:=Pt[8];
    End;
  Rectanglepointu:
    Begin
      Dessin[0]:=Pt[8];
      Dessin[1]:=Pt[2];
      Dessin[2]:=Pt[3];
      Dessin[3]:=Pt[1];
      Dessin[4]:=Pt[7];
      Dessin[5]:=Pt[8];
    End;
  Losange :
    Begin
      Dessin[0]:=Pt[6];
      Dessin[1]:=Pt[11];
      Dessin[2]:=Pt[3];
      Dessin[3]:=Pt[10];
      Dessin[4]:=Pt[6];
      Dessin[5]:=Pt[6];
    End;
  Cercle :
    Begin
      Dessin[0]:=Pt[9];
      Dessin[1]:=Pt[9];
      Dessin[2]:=Pt[9];
      Dessin[3]:=Pt[9];
      Dessin[4]:=Pt[9];
      Dessin[5]:=Pt[9];
      Largeur:=Largeur div 2;
      Support.Ellipse(Pt[3].x+Largeur,Pt[3].y+largeur,Pt[3].x-Largeur,Pt[3].y-Largeur);
    End;
  End;
  // je dessine mon polygone.
  Support.Polygon(Dessin);
End;

function TClock.CalculAngle(Indice :Integer;Heu,Min,Sec,Csec: Word): Real;
begin
  Case Indice Of
  1 : Begin
        Result := ((Csec) * 2 * pi / 1000);
      End;
  2 : Begin
        if VGlisser then
          Result := ((Sec) * 2 * pi / 60 + CalculAngle(1,Heu, Min, Sec, Csec) / 60)
        else
          Result := ((Sec) * 2 * pi / 60);
      End;
  3 : Begin
        Result := ((Min) * 2 * pi / 60 + CalculAngle(2,Heu,Min,Sec,Csec) / 60);
      End;
  4 : Begin
        Result :=( ((Heu mod 12)) * 2 * pi / 12 + CalculAngle(3,Heu, Min, Sec, Csec) / 12);
      End;
    Else Result:=0;
  End;
end;

Procedure TClock.ImageChange(Sender: TObject);
begin
  DessinerFond;
  Invalidate;
end;

Procedure TClock.SetGlisser(Value : Boolean);
Begin
  VGlisser:=Value;
  Invalidate;
End;

Procedure TClock.SetChiffreH(Value : Boolean);
Begin
  VChiffreH:=Value;
  Invalidate;
End;

Procedure TClock.SetChiffreM(Value : Boolean);
Begin
  VChiffreM:=Value;
  Invalidate;
End;

Procedure TClock.SetGraduation(Value : Boolean);
Begin
  VGraduation:=Value;
  Invalidate;
End;

Procedure TClock.SetPinceau(Value: TColor);
begin
  VPinceau:=Value;
  Invalidate;
end;

Procedure TClock.SetCentieme(Value:TAiguille);
Begin
  VCentieme:=Value;
  Invalidate;
End;

Procedure TClock.SetHeure(Value:TAiguille);
Begin
  VHeure:=Value;
  Invalidate;
End;

Procedure TClock.SetMinute(Value:TAiguille);
Begin
  VMinute:=Value;
  Invalidate;
End;

Procedure TClock.SetSeconde(Value:TAiguille);
Begin
  VSeconde:=Value;
  Invalidate;
End;

Procedure TClock.SetDate(Value: TTexte);
begin
  VDate:=Value;
  Invalidate;
end;

Procedure TClock.SetLogo(Value: TTexte);
begin
  VLogo:=Value;
  Invalidate;
end;

end.
