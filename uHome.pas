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
    procedure LoadBackground;
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
  ShowMessage('Nah im working on it');
end;

procedure TfrmHome.FormCreate(Sender: TObject);
begin
  LoadBackground;
end;

procedure TfrmHome.LoadBackground;
var
  iLargest: Integer;
begin
  if frmHome.Width > frmHome.Height then
    iLargest := frmHome.Width
  else
    iLargest := frmHome.Height;

  imgBG.Bitmap.LoadFromFile('..\..\assets\Bodybuilder.jpg');
  imgBG.WrapMode := TImageWrapMode.Fit;
  imgBG.Opacity := 0.2;

  imgBG.Width := iLargest;
  imgBG.Height := iLargest;
  imgBG.Position.X := -(frmHome.Width div 2);
  imgBG.Position.Y := 0;
end;

end.
