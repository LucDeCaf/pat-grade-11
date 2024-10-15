unit uDataExport;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uGlobal,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TfrmDataExport = class(TForm)
    imgBG: TImage;
    btnBack: TButton;
    flwControls: TFlowLayout;
    cbnImport: TCornerButton;
    brk1: TFlowLayoutBreak;
    cbnExport: TCornerButton;
    lblImportOrExport: TLabel;
    lblDisclaimer: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDataExport: TfrmDataExport;

implementation

{$R *.fmx}

procedure TfrmDataExport.btnBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDataExport.FormCreate(Sender: TObject);
begin
  LoadBackground(width, height, imgBG);
end;

end.
