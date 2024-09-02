unit uEditWorkout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, uGlobal, dmDB, FMX.Layouts, FMX.Edit,
  FMX.DateTimeCtrls, FMX.Objects;

type
  TfrmEditWorkout = class(TForm)
    edtTitle: TEdit;
    lblTitle: TLabel;
    flwTitle: TFlowLayout;
    layBack: TLayout;
    btnBack: TButton;
    flwDateTime: TFlowLayout;
    lblDateTime: TLabel;
    flwDescription: TFlowLayout;
    lblDescription: TLabel;
    edtDescription: TEdit;
    flwMetadata: TFlowLayout;
    scroll: TVertScrollBox;
    dedDate: TDateEdit;
    imgBG: TImage;
    flwSetGroups: TFlowLayout;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure HandleDialogClose(const AResult: TModalResult);
    procedure LoadSetGroups;
    procedure AddSetGroup(const setGroup: TSetGroup; const i: Integer = -1);
  private
    { Private declarations }
  public
  var
    workout: TWorkout;
  end;

var
  frmEditWorkout: TfrmEditWorkout;

implementation

{$R *.fmx}

procedure TfrmEditWorkout.HandleDialogClose(const AResult: TModalResult);
begin
  if AResult = mrYes then
  begin
    dmDB.dmMain.SaveWorkout(workout);
    Close;
  end;

  if AResult = mrNo then
  begin
    Close;
  end;
end;

procedure TfrmEditWorkout.btnBackClick(Sender: TObject);
begin
  MessageDlg('Save changes to workout "' + workout.Title + '"?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo,
    TMsgDlgBtn.mbCancel], 0, TMsgDlgBtn.mbYes, HandleDialogClose);
end;

procedure TfrmEditWorkout.FormCreate(Sender: TObject);
begin
  LoadBackground(width, height, imgBG);
end;

procedure TfrmEditWorkout.FormShow(Sender: TObject);
begin
  edtTitle.Text := workout.Title;
  edtDescription.Text := workout.Description;
  dedDate.DateTime := workout.Timestamp;

  LoadSetGroups;
end;

procedure TfrmEditWorkout.LoadSetGroups;
var
  i: Integer;
begin
  flwSetGroups.DeleteChildren;
  for i := 0 to length(workout.SetGroups) - 1 do
    AddSetGroup(workout.SetGroups[i]);
end;

procedure TfrmEditWorkout.AddSetGroup(const setGroup: TSetGroup;
  const i: Integer = -1);
begin
  ShowMessage('WIP');
end;

end.
