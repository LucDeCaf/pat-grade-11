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
  uEditWorkout in 'uEditWorkout.pas' {frmEditWorkout},
  uEditSetGroup in 'uEditSetGroup.pas' {frmEditSetGroup},
  uEditSet in 'uEditSet.pas' {frmEditSet},
  uDataExport in 'uDataExport.pas' {frmDataExport};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmRegister, frmRegister);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmEditWorkout, frmEditWorkout);
  Application.CreateForm(TfrmEditSetGroup, frmEditSetGroup);
  Application.CreateForm(TfrmEditSet, frmEditSet);
  Application.CreateForm(TfrmDataExport, frmDataExport);
  Application.Run;
end.
