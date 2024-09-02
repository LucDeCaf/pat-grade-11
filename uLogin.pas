unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation, Data.DB, dmDB, uGlobal,
  FMX.Objects;

type
  TfrmLogin = class(TForm)
    btnBack: TButton;
    flwForm: TFlowLayout;
    lblUsername: TLabel;
    edtUsername: TEdit;
    lblPassword: TLabel;
    edtPassword: TEdit;
    layMessage: TLayout;
    lblSLC: TLabel;
    layRegister: TLayout;
    btnLogin: TButton;
    imgBG: TImage;
    procedure btnLoginClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.btnBackClick(Sender: TObject);
begin
  frmLogin.Close;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  sUsername, sPassword: String;
  bExists: Boolean;
begin
  sUsername := edtUsername.Text.Trim;
  sPassword := edtPassword.Text.Trim;

  with dmDB.dmMain do
  begin
    bExists := tbluser.Locate('Username', sUsername, [loCaseInsensitive]);
    if not bExists then
    begin
      ShowMessage('Incorrect username or password.');
      Exit;
    end;

    if hashpassword(sPassword, tbluser['Salt']) <> tbluser['PasswordHash'] then
    begin
      ShowMessage('Incorrect username or password.');
      Exit;
    end;

    uGlobal.activeUser.Username := tbluser['Username'];
    uGlobal.activeUser.Role := tbluser['Role'];
    uGlobal.activeUser.Suspended := tbluser['Suspended'];
  end;

  ShowMessage('Logged in as ' + uGlobal.activeUser.Username + '.');

  ModalResult := mrOk;
  frmLogin.CloseModal;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  loadbackground(frmLogin.width, frmLogin.height, frmLogin.imgBG);
end;

end.
