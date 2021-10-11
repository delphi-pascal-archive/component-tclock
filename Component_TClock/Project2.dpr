program Project2;

uses
  Forms,
  Umain in 'Umain.pas' {FMain},
  MDClock in 'MDClock.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
