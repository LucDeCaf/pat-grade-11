program SLC;

uses
  System.StartUpCopy,
  FMX.Forms,
  uHome in 'uHome.pas' {frmHome},
  dmDB in 'dmDB.pas' {dmMain: TDataModule},
  uRegister in 'uRegister.pas' {frmRegister},
  uLogin in 'uLogin.pas' {frmLogin},
  uGlobal in 'uGlobal.pas',
  uMain in 'uMain.pas' {frmMain},
  uEditWorkout in 'uEditWorkout.pas' {frmEditWorkout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmRegister, frmRegister);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmEditWorkout, frmEditWorkout);
  Application.Run;
end.
