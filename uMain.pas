unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, uGlobal, dmDB,
  Data.Win.ADODB, Data.DB,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, uEditWorkout, uDataExport;

type
  TfrmMain = class(TForm)
    btnBack: TButton;
    layMessage: TLayout;
    lblSLC: TLabel;
    imgBG: TImage;
    lstFeed: TListView;
    lblWorkout: TLabel;
    btnNewWorkout: TButton;
    btnImport: TButton;
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstFeedItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormActivate(Sender: TObject);
    procedure btnNewWorkoutClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure LoadWorkouts;
  private
  var
    arrWorkouts: TWorkoutArray;
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

procedure TfrmMain.btnImportClick(Sender: TObject);
begin
  frmMain.Hide;
  frmDataExport.ShowModal;
  arrWorkouts := dmMain.GetAllWorkouts;
  frmMain.Show;
end;

procedure TfrmMain.btnNewWorkoutClick(Sender: TObject);
var
  workout: TWorkout;
begin
  workout.ID := -1;
  workout.Title := 'New workout';
  workout.Description := '';
  workout.OwnerUsername := activeuser.Username;
  workout.Timestamp := Now;
  SetLength(workout.SetGroups, 0);

  frmEditWorkout.workout := workout;

  frmMain.Hide;
  frmEditWorkout.ShowModal;
  frmMain.Show;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  i: Integer;
  item: TListViewItem;
begin
  arrWorkouts := dmMain.GetAllWorkouts;
  LoadWorkouts;
end;

procedure TfrmMain.LoadWorkouts;
var
  i: Integer;
  item: TListViewItem;
begin
  lstFeed.items.Clear;
  for i := 0 to length(arrWorkouts) - 1 do
  begin
    item := lstFeed.items.Add;

    item.Text := arrWorkouts[i].Title + ' - ' +
      DateToStr(arrWorkouts[i].Timestamp);

    item.Data['ID'] := arrWorkouts[i].ID;
    item.Data['OwnerUsername'] := arrWorkouts[i].OwnerUsername;
    item.Data['Title'] := arrWorkouts[i].Title;
    item.Data['Description'] := arrWorkouts[i].Description;
    item.Data['Timestamp'] := arrWorkouts[i].Timestamp;
    // Suck it compiler, safe code is for nerds
    item.Data['SetGroups'] := NativeInt(@arrWorkouts[i].SetGroups);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  LoadBackground(width, height, imgBG);
end;

procedure TfrmMain.lstFeedItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  frmEditWorkout.workout.ID := AItem.Data['ID'].AsInteger;
  frmEditWorkout.workout.Title := AItem.Data['Title'].AsString;
  frmEditWorkout.workout.Description := AItem.Data['Description'].AsString;
  frmEditWorkout.workout.OwnerUsername := AItem.Data['OwnerUsername'].AsString;
  frmEditWorkout.workout.Timestamp := AItem.Data['Timestamp'].AsType<TDateTime>;
  // I love unchecked int to pointer casting and dereferencing :)
  frmEditWorkout.workout.SetGroups :=
    PSetGroupArray(AItem.Data['SetGroups'].AsType<NativeInt>)^; // Chef's kiss

  frmMain.Hide;
  frmEditWorkout.ShowModal;
  frmMain.Show;
end;

end.
