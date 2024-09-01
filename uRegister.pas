unit uRegister;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, Data.DB, dmDB,
  FMX.Objects, uGlobal;

type
  TfrmRegister = class(TForm)
    layMessage: TLayout;
    lblSLC: TLabel;
    flwForm: TFlowLayout;
    lblUsername: TLabel;
    edtUsername: TEdit;
    lblPassword: TLabel;
    edtPassword: TEdit;
    lblReenterPassword: TLabel;
    edtReenterPassword: TEdit;
    layRegister: TLayout;
    btnRegister: TButton;
    btnBack: TButton;
    imgBG: TImage;
    procedure btnBackClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegister: TfrmRegister;

implementation

{$R *.fmx}

procedure TfrmRegister.btnBackClick(Sender: TObject);
begin
  frmRegister.Close;
end;

procedure TfrmRegister.btnRegisterClick(Sender: TObject);
var
  sUsername, sPassword, sSalt, sHash: String;
  bExists: Boolean;
begin
  if edtPassword.text.trim <> edtReenterPassword.text.trim then
  begin
    ShowMessage('Mismatching passwords');
    exit;
  end;

  sUsername := edtUsername.text.trim;
  sPassword := edtPassword.text.trim;

  with dmDB.dmMain do
  begin
    bExists := tblUser.Locate('Username', sUsername, [loCaseInsensitive]);

    if bExists then
    begin
      ShowMessage('User ' + sUsername +
        ' already exists - please login or use a different username.');
      exit;
    end;

    sSalt := NewSalt;
    sHash := HashPassword(sPassword, sSalt);

    tblUser.Last;
    tblUser.Insert;
    tblUser['Username'] := sUsername;
    tblUser['Role'] := 'user';
    tblUser['Password Hash'] := sHash;
    tblUser['Salt'] := sSalt;
    tblUser['Suspended'] := False;
    tblUser.Post;
  end;

  ShowMessage('User registered successfully!');
  edtUsername.text := '';
  edtPassword.text := '';
  edtReenterPassword.text := '';
  frmRegister.Close;
end;

procedure TfrmRegister.FormCreate(Sender: TObject);
begin
  loadbackground(frmRegister.width, frmRegister.height, frmRegister.imgBG);
end;

end.
