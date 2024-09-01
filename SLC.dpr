program SLC;

uses
  System.StartUpCopy,
  FMX.Forms,
  uHome in 'uHome.pas' {frmHome},
  dmDB in 'dmDB.pas' {dmMain: TDataModule},
  uConfig in 'uConfig.pas',
  uRegister in 'uRegister.pas' {frmRegister};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmRegister, frmRegister);
  Application.Run;
end.
