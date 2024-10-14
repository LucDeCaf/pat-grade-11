unit uEditSetGroup;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, uGlobal, FMX.Edit, FMX.EditBox,
  FMX.NumberBox, FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, uEditSet;

type
  TfrmEditSetGroup = class(TForm)
    imgBG: TImage;
    layExerciseName: TLayout;
    lblExerciseName: TLabel;
    edtExerciseName: TEdit;
    layBack: TLayout;
    btnBack: TButton;
    lstSets: TListView;
    cbnAddSet: TCornerButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lstSetsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure cbnAddSetClick(Sender: TObject);
    procedure AddItems;
    procedure FormShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure edtExerciseNameChange(Sender: TObject);
    procedure HandleDeleteDialogClose(const AResult: TModalResult);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
  var
    PSetGroup: ^TSetGroup;
  end;

var
  frmEditSetGroup: TfrmEditSetGroup;

implementation

{$R *.fmx}

procedure TfrmEditSetGroup.HandleDeleteDialogClose(const AResult: TModalResult);
begin
  if AResult = mrYes then
  begin
    ModalResult := mrYes;
    CloseModal;
  end;
end;

procedure TfrmEditSetGroup.btnBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditSetGroup.btnDeleteClick(Sender: TObject);
begin
  MessageDlg('Are you sure you want to delete this exercise?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo,
    TMsgDlgBtn.mbCancel], 0, TMsgDlgBtn.mbNo, HandleDeleteDialogClose);
end;

procedure TfrmEditSetGroup.cbnAddSetClick(Sender: TObject);
var
  newSet: TSet;
begin
  newSet.Reps := 0;
  newSet.Weight := 0;

  SetLength(PSetGroup.Sets, Length(PSetGroup.Sets) + 1);
  PSetGroup.Sets[Length(PSetGroup.Sets) - 1] := newSet;

  AddItems;
end;

procedure TfrmEditSetGroup.edtExerciseNameChange(Sender: TObject);
begin
  PSetGroup.ExerciseName := edtExerciseName.Text;
end;

procedure TfrmEditSetGroup.AddItems;
var
  i: Integer;
  setVar: TSet;
  item: TListViewItem;
begin
  lstSets.Items.Clear;

  for i := 0 to Length(PSetGroup.Sets) - 1 do
  begin
    item := lstSets.Items.Add;
    item.Text := 'Set ' + (i + 1).ToString;
    item.Data['Index'] := i;
  end;
end;

procedure TfrmEditSetGroup.FormCreate(Sender: TObject);
begin
  LoadBackground(width, height, imgBG);
end;

procedure TfrmEditSetGroup.FormShow(Sender: TObject);
begin
  edtExerciseName.Text := PSetGroup.ExerciseName;
  AddItems;
end;

procedure TfrmEditSetGroup.lstSetsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  i: Integer;
  iReps: Integer;
  dWeight: Double;
begin
  i := AItem.Data['Index'].AsInteger;
  frmEditSet.PSet := @(PSetGroup.Sets[i]);

  // Delete set if ModalResult == mrYes
  if frmEditSet.ShowModal = mrYes then
  begin
    for i := i to Length(PSetGroup.Sets) - 2 do
    begin
      PSetGroup.Sets[i] := PSetGroup.Sets[i + 1];
      SetLength(PSetGroup.Sets, Length(PSetGroup.Sets) - 1);
    end;

    AddItems;
  end;
end;

end.
