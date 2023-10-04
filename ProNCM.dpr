program ProNCM;

uses
  Vcl.Forms,
  formPrincipal in 'formPrincipal.pas' {uFormPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TuFormPrincipal, uFormPrincipal);
  Application.Run;
end.
