unit dmDB;

interface

uses
  System.SysUtils, System.Classes, System.Hash, FMX.Dialogs, Data.DB,
  Data.Win.ADODB, uGlobal;

type
  TdmMain = class(TDataModule)
    conDB: TADOConnection;
    tblUser: TADOTable;
    dsUser: TDataSource;
    tblWorkout: TADOTable;
    dsWorkout: TDataSource;
    dbSet: TDataSource;
    tblSet: TADOTable;
    tblSetGroup: TADOTable;
    dsSetGroup: TDataSource;
    function NewSalt: String;
    function HashPassword(password, salt: string): string;
    procedure DataModuleCreate(Sender: TObject);
    function GetAllWorkouts: TWorkoutArray;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

function TdmMain.NewSalt: String;
const
  validChars: String = '0123456789abcdef';
var
  i, index: Integer;
begin
  for i := 0 to 63 do
  begin
    index := Random(16);
    result := result + validChars[index + 1];
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  // Connect to DB
  if not conDB.Connected then
    conDB.Open('Admin', '');

  // Open tables
  if not tblUser.Active then
    tblUser.Open;
  if not tblWorkout.Active then
    tblWorkout.Open;
  if not tblSetGroup.Active then
    tblSetGroup.Open;
  if not tblSet.Active then
    tblSet.Open;
end;

function TdmMain.HashPassword(password, salt: string): string;
begin
  result := THashSHA2.GetHashString(password + salt,
    THashSHA2.TSHA2Version.SHA256);
end;

function TdmMain.GetAllWorkouts: TWorkoutArray;
var
  i: Integer;
  workout: TWorkout;
  setGroup: TSetGroup;
  setVar: TSet;
  j: Integer;
  k: Integer;
begin
  setlength(result, tblWorkout.RecordCount);

  tblWorkout.IndexFieldNames := 'Timestamp DESC';

  tblWorkout.First;
  for i := 0 to tblWorkout.RecordCount - 1 do
  begin
    workout.Id := tblWorkout['ID'];
    workout.OwnerUsername := tblWorkout['UserUsername'];
    workout.Title := tblWorkout['Title'];
    workout.Description := tblWorkout['Description'];
    workout.Timestamp := tblWorkout['Timestamp'];

    tblSetGroup.filtered := false;
    tblSetGroup.filter := 'WorkoutID = ' + workout.Id.ToString;
    tblSetGroup.filtered := true;
    tblSetGroup.IndexFieldNames := 'Index';

    tblSetGroup.Open;

    setlength(workout.SetGroups, tblSetGroup.RecordCount);

    tblSetGroup.First;
    for j := 0 to tblSetGroup.RecordCount - 1 do
    begin
      setGroup.Id := tblSetGroup['ID'];
      setGroup.ExerciseName := tblSetGroup['ExerciseName'];

      tblSet.filtered := false;
      tblSet.filter := 'SetGroupID = ' + setGroup.Id.ToString;
      tblSet.filtered := true;
      tblSet.IndexFieldNames := 'Index';

      tblSet.Open;

      setlength(setGroup.Sets, tblSet.RecordCount);

      tblSet.First;
      for k := 0 to tblSet.RecordCount - 1 do
      begin
        setVar.Weight := tblSet['Weight'];
        setVar.Reps := tblSet['Reps'];

        setGroup.Sets[k] := setVar;

        tblSet.Next;
      end;

      workout.SetGroups[j] := setGroup;

      tblSetGroup.Next;
    end;

    result[i] := workout;

    tblWorkout.Next;
  end;
end;

end.
