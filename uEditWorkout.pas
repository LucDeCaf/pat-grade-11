unit uEditWorkout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, uGlobal, dmDB, FMX.Layouts, FMX.Edit,
  FMX.DateTimeCtrls, FMX.Objects, FMX.EditBox, FMX.NumberBox, FMX.ListBox,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, uEditSetGroup;

type
  TSetGroupComponent = record
    layBase: TLayout;
    edtInput: TEdit;
    data: TSetGroup;
  end;

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
    cbnAddExercise: TCornerButton;
    lstSetGroups: TListView;
    btnDelete: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure HandleDialogClose(const AResult: TModalResult);
    procedure cbnAddExerciseClick(Sender: TObject);
    procedure lstSetGroupsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure edtTitleChange(Sender: TObject);
    procedure edtDescriptionChange(Sender: TObject);
    procedure dedDateChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure HandleDeleteDialogClose(const AResult: TModalResult);
  private
    procedure AddItems;
  public
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

procedure TfrmEditWorkout.HandleDeleteDialogClose(const AResult: TModalResult);
begin
  if AResult = mrYes then
  begin
    // Only delete workout if it already exists in the db.
    // This condition will be false if the user presses 'X'
    // without first saving the workout at a prior time.
    if dmDB.dmMain.tblWorkout.Locate('ID', workout.id, []) then
    begin
      dmDB.dmMain.DeleteWorkout(workout);
    end;
    Close;
  end;
end;

procedure TfrmEditWorkout.lstSetGroupsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  i: Integer;
  iResult: Integer;
begin
  i := AItem.data['Index'].AsInteger;

  frmEditSetGroup.PSetGroup := @workout.SetGroups[i];

  Hide;

  // Delete the set group if user picks 'yes' in delete dialog
  if frmEditSetGroup.ShowModal = mrYes then
  begin
    for i := i to length(workout.SetGroups) - 2 do
    begin
      workout.SetGroups[i] := workout.SetGroups[i + 1];
    end;

    SetLength(workout.SetGroups, length(workout.SetGroups) - 1);
  end;

  AddItems;
  Show;
end;

procedure TfrmEditWorkout.btnBackClick(Sender: TObject);
begin
  MessageDlg('Save changes to workout "' + workout.Title + '"?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo,
    TMsgDlgBtn.mbCancel], 0, TMsgDlgBtn.mbYes, HandleDialogClose);
end;

procedure TfrmEditWorkout.btnDeleteClick(Sender: TObject);
begin
  MessageDlg('Are you sure you want to delete workout "' + workout.Title + '"?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo,
    TMsgDlgBtn.mbCancel], 0, TMsgDlgBtn.mbNo, HandleDeleteDialogClose)
end;

procedure TfrmEditWorkout.cbnAddExerciseClick(Sender: TObject);
var
  setGroup: TSetGroup;
begin
  // Initialize set group
  setGroup.id := -1;
  setGroup.ExerciseName := 'New set';
  SetLength(setGroup.Sets, 0);

  // Add set group
  SetLength(workout.SetGroups, length(workout.SetGroups) + 1);
  workout.SetGroups[length(workout.SetGroups) - 1] := setGroup;
  AddItems;

end;

procedure TfrmEditWorkout.dedDateChange(Sender: TObject);
begin
  workout.Timestamp := dedDate.DateTime;
end;

procedure TfrmEditWorkout.edtDescriptionChange(Sender: TObject);
begin
  workout.Description := edtDescription.Text;
end;

procedure TfrmEditWorkout.edtTitleChange(Sender: TObject);
begin
  workout.Title := edtTitle.Text;
end;

procedure TfrmEditWorkout.AddItems;
var
  i: Integer;
  setGroup: TSetGroup;
  item: TListViewItem;
begin
  lstSetGroups.Items.Clear;

  for i := 0 to length(workout.SetGroups) - 1 do
  begin
    setGroup := workout.SetGroups[i];

    item := lstSetGroups.Items.Add;
    item.Text := setGroup.ExerciseName;
    item.data['Index'] := i;
  end;
end;

procedure TfrmEditWorkout.FormCreate(Sender: TObject);
begin
  LoadBackground(width, height, imgBG);
end;

procedure TfrmEditWorkout.FormShow(Sender: TObject);
var
  i: Integer;
begin
  edtTitle.Text := workout.Title;
  edtDescription.Text := workout.Description;
  dedDate.DateTime := workout.Timestamp;
  AddItems;
end;

end.
