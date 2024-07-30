unit uHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Colors, FMX.Layouts;

type
  TfrmHome = class(TForm)
    lblSLC: TLabel;
    imgLogo: TImage;
    lblWelcome: TLabel;
    flwLoginOrSignup: TFlowLayout;
    brk1: TFlowLayoutBreak;
    cbnLogin: TCornerButton;
    btnRegister: TButton;
    layMessage: TLayout;
    procedure cbnLoginClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.fmx}

procedure TfrmHome.btnRegisterClick(Sender: TObject);
begin
  ShowMessage('No registering yet, im lazy');
end;

procedure TfrmHome.cbnLoginClick(Sender: TObject);
begin
  ShowMessage('No app means no accounts exist yet, liar');
end;

end.
