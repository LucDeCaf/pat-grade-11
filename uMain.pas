unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, uGlobal,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TfrmMain = class(TForm)
    btnBack: TButton;
    layMessage: TLayout;
    lblSLC: TLabel;
    imgBG: TImage;
    lstFeed: TListView;
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnBackClick(Sender: TObject);
begin
  frmMain.Close;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  lstFeed.Items.Add.Text := 'test1';
  lstFeed.Items.Add.Text := 'test2';
  lstFeed.Items.Add.Text := 'test3';
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  LoadBackground(frmMain.width, frmMain.height, frmMain.imgBG)
end;

end.
