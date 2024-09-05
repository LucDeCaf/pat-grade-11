unit uEditSet;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, uGlobal, FMX.Edit, FMX.EditBox,
  FMX.NumberBox, FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView;

type
  TfrmEditSet = class(TForm)
    imgBG: TImage;
    layExerciseName: TLayout;
    lblExerciseName: TLabel;
    edtExerciseName: TEdit;
    layBack: TLayout;
    btnBack: TButton;
    lstSets: TListView;
    cbnAddSet: TCornerButton;
    procedure FormCreate(Sender: TObject);
    procedure lstSetsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure cbnAddSetClick(Sender: TObject);
    procedure AddItems;
    procedure FormShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure edtExerciseNameChange(Sender: TObject);
  private
    { Private declarations }
  public
  var
    PSetGroup: ^TSetGroup;
  end;

var
  frmEditSet: TfrmEditSet;

implementation

{$R *.fmx}

procedure TfrmEditSet.btnBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditSet.cbnAddSetClick(Sender: TObject);
var
  newSet: TSet;
begin
  newSet.Reps := 0;
  newSet.Weight := 0;

  SetLength(PSetGroup.Sets, Length(PSetGroup.Sets) + 1);
  PSetGroup.Sets[Length(PSetGroup.Sets) - 1] := newSet;

  AddItems;
end;

procedure TfrmEditSet.edtExerciseNameChange(Sender: TObject);
begin
  PSetGroup.ExerciseName := edtExerciseName.Text;
end;

procedure TfrmEditSet.AddItems;
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

procedure TfrmEditSet.FormCreate(Sender: TObject);
begin
  LoadBackground(width, height, imgBG);
end;

procedure TfrmEditSet.FormShow(Sender: TObject);
begin
  edtExerciseName.Text := PSetGroup.ExerciseName;
  AddItems;
end;

procedure TfrmEditSet.lstSetsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  iIndex: Integer;
  iReps: Integer;
  dWeight: Double;
begin
  iIndex := AItem.Data['Index'].AsInteger;

  try
    iReps := StrToInt(InputBox('Edit set', 'Enter the number of sets:',
      PSetGroup.Sets[iIndex].Reps.ToString));
    if iReps < 0 then
    begin
      ShowMessage('Please enter a positive number.');
      Exit;
    end;
  except
    ShowMessage('Please enter a positive integer.');
    Exit;
  end;

  try
    dWeight := StrToFloat(InputBox('Edit set', 'Enter the weight:',
      PSetGroup.Sets[iIndex].Weight.ToString));

    if dWeight < 0 then
    begin
      ShowMessage('Please enter a positive number.');
      Exit;
    end;
  except
    ShowMessage('Please enter a positive integer or decimal number.');
    Exit;
  end;

  (PSetGroup^).Sets[iIndex].Reps := iReps;
  (PSetGroup^).Sets[iIndex].Weight := dWeight;
end;

end.
