unit uHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Colors, FMX.Layouts,
  Data.DB, Datasnap.Provider, Data.Win.ADODB, uRegister, uLogin, uGlobal, uMain,
  dmDB;

type
  TfrmHome = class(TForm)
    lblSLC: TLabel;
    flwLoginOrSignup: TFlowLayout;
    brk1: TFlowLayoutBreak;
    cbnLogin: TCornerButton;
    layMessage: TLayout;
    layAbout: TLayout;
    lblAboutUs: TLabel;
    cbnRegister: TCornerButton;
    imgBG: TImage;
    procedure cbnLoginClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public const
    clFormBackground: TAlphaColor = $FF0C0C12;
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.fmx}

procedure TfrmHome.btnRegisterClick(Sender: TObject);
begin
  frmHome.Hide;
  frmRegister.ShowModal;
  frmHome.Show;
end;

procedure TfrmHome.cbnLoginClick(Sender: TObject);
var
  result: TModalResult;
begin
  frmHome.Hide;
  frmLogin.ModalResult := mrNone;

  if frmLogin.ShowModal = mrOk then
  begin
    frmMain.ShowModal;
  end;

  frmHome.Show;
end;

procedure EnsureDir(path: String);
begin
  if not DirectoryExists(path) then
  begin
    CreateDir(path);
  end;
end;

procedure TfrmHome.FormCreate(Sender: TObject);
begin
  EnsureDir('data');
  EnsureDir('data/workout_plans');
  LoadBackground(frmHome.width, frmHome.height, frmHome.imgBG);
end;

end.
