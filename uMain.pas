unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, uGlobal, dmDB,
  Data.Win.ADODB, Data.DB,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, uEditWorkout;

type
  TfrmMain = class(TForm)
    btnBack: TButton;
    layMessage: TLayout;
    lblSLC: TLabel;
    imgBG: TImage;
    lstFeed: TListView;
    lblWorkout: TLabel;
    btnNewWorkout: TButton;
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstFeedItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormActivate(Sender: TObject);
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

procedure TfrmMain.FormActivate(Sender: TObject);
var
  i: Integer;
  item: TListViewItem;
  PSetGroups: PSetGroupArray;
begin
  arrWorkouts := dmMain.GetAllWorkouts;

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
