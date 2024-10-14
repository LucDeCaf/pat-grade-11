unit uEditSet;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uGlobal,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.EditBox, FMX.NumberBox, Math;

type
  TfrmEditSet = class(TForm)
    imgBG: TImage;
    layBack: TLayout;
    btnBack: TButton;
    btnDelete: TButton;
    flwMetadata: TFlowLayout;
    flwReps: TFlowLayout;
    lblReps: TLabel;
    flwWeight: TFlowLayout;
    lblWeight: TLabel;
    numReps: TNumberBox;
    numWeight: TNumberBox;
    procedure FormCreate(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure HandleDeleteDialogClose(const AResult: TModalResult);
    procedure numRepsChange(Sender: TObject);
    procedure numWeightChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    PSet: ^TSet;
  end;

var
  frmEditSet: TfrmEditSet;

implementation

{$R *.fmx}

procedure TfrmEditSet.HandleDeleteDialogClose(const AResult: TModalResult);
begin
  if AResult = mrYes then
  begin
    ModalResult := mrYes;
    CloseModal;
  end;
end;

procedure TfrmEditSet.numRepsChange(Sender: TObject);
begin
  PSet.Reps := Floor(numReps.Value);
end;

procedure TfrmEditSet.numWeightChange(Sender: TObject);
begin
  PSet.Weight := numWeight.Value;
end;

procedure TfrmEditSet.btnBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditSet.btnDeleteClick(Sender: TObject);
begin
  MessageDlg('Are you sure you want to delete this set?',
    tmsgdlgtype.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo,
    TMsgDlgBtn.mbCancel], 0, TMsgDlgBtn.mbNo, HandleDeleteDialogClose);
end;

procedure TfrmEditSet.FormCreate(Sender: TObject);
begin
  LoadBackground(width, height, imgBG);
end;

procedure TfrmEditSet.FormShow(Sender: TObject);
begin
  numReps.Value := PSet.Reps;
  numWeight.Value := PSet.Weight;
end;

end.
