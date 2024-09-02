unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, uGlobal, dmDB,
  Data.Win.ADODB, Data.DB,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TfrmMain = class(TForm)
    btnBack: TButton;
    layMessage: TLayout;
    lblSLC: TLabel;
    imgBG: TImage;
    lstFeed: TListView;
    lblWorkout: TLabel;
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
    item.Data['PSetGroups'] := @arrWorkouts[i].SetGroups;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  LoadBackground(frmMain.width, frmMain.height, frmMain.imgBG);
end;

procedure TfrmMain.lstFeedItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  ShowMessage('you clicked ' + AItem.Text);
end;

end.
