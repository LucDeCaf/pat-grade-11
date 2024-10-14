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
    function SaveWorkout(workout: TWorkout): TWorkout;
    function DeleteWorkout(workout: TWorkout): TWorkout;
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
    workout.ID := tblWorkout['ID'];
    workout.OwnerUsername := tblWorkout['UserUsername'];
    workout.Title := tblWorkout['Title'];
    workout.Description := tblWorkout['Description'];
    workout.Timestamp := tblWorkout['Timestamp'];

    tblSetGroup.filtered := false;
    tblSetGroup.filter := 'WorkoutID = ' + workout.ID.ToString;
    tblSetGroup.filtered := true;
    tblSetGroup.IndexFieldNames := 'Index';

    tblSetGroup.Open;

    setlength(workout.SetGroups, tblSetGroup.RecordCount);

    tblSetGroup.First;
    for j := 0 to tblSetGroup.RecordCount - 1 do
    begin
      setGroup.ID := tblSetGroup['ID'];
      setGroup.ExerciseName := tblSetGroup['ExerciseName'];

      tblSet.filtered := false;
      tblSet.filter := 'SetGroupID = ' + setGroup.ID.ToString;
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

function TdmMain.SaveWorkout(workout: TWorkout): TWorkout;
var
  bExists: Boolean;
  i, j: Integer;
  setGroup: TSetGroup;
begin
  i := 0;

  if tblWorkout.Locate('ID', workout.ID, []) then
  begin
    tblWorkout.Edit;
  end
  else
  begin
    tblWorkout.Append;
  end;

  tblWorkout['Title'] := workout.Title;
  tblWorkout['Description'] := workout.Description;
  tblWorkout['UserUsername'] := workout.OwnerUsername;
  tblWorkout['Timestamp'] := workout.Timestamp;
  tblWorkout.Post;
  workout.ID := tblWorkout['ID'];

  tblSetGroup.filter := 'WorkoutID = ' + workout.ID.ToString;
  tblSetGroup.IndexFieldNames := 'Index';
  tblSetGroup.filtered := true;
  tblSetGroup.First;

  while (not tblSetGroup.Eof) and (i < length(workout.SetGroups)) do
  begin
    tblSetGroup.Edit;
    tblSetGroup['Index'] := i;
    tblSetGroup['ExerciseName'] := workout.SetGroups[i].ExerciseName;
    tblSetGroup.Post;
    workout.SetGroups[i].ID := tblSetGroup['ID'];

    Inc(i);
    tblSetGroup.Next;
  end;

  while not tblSetGroup.Eof do
  begin
    tblSetGroup.Delete;
    tblSetGroup.Next;
  end;

  for i := i to length(workout.SetGroups) - 1 do
  begin
    tblSetGroup.Append;
    tblSetGroup['WorkoutID'] := workout.ID;
    tblSetGroup['Index'] := i;
    tblSetGroup['ExerciseName'] := workout.SetGroups[i].ExerciseName;
    tblSetGroup.Post;
    workout.SetGroups[i].ID := tblSetGroup['ID'];
  end;

  for i := 0 to length(workout.SetGroups) - 1 do
  begin
    j := 0;
    setGroup := workout.SetGroups[i];

    tblSet.filter := 'SetGroupID = ' + setGroup.ID.ToString;
    tblSet.filtered := true;
    tblSet.First;

    while (not tblSet.Eof) and (j < length(setGroup.Sets)) do
    begin
      tblSet.Edit;
      tblSet['Index'] := j;
      tblSet['Weight'] := setGroup.Sets[j].Weight;
      tblSet['Reps'] := setGroup.Sets[j].Reps;
      tblSet.Post;

      Inc(j);
      tblSet.Next;
    end;

    while not tblSet.Eof do
    begin
      tblSet.Delete;
      tblSet.Next;
    end;

    while j < length(setGroup.Sets) do
    begin
      tblSet.Append;
      tblSet['SetGroupID'] := setGroup.ID;
      tblSet['Index'] := j;
      tblSet['Weight'] := setGroup.Sets[j].Weight;
      tblSet['Reps'] := setGroup.Sets[j].Reps;
      tblSet.Post;

      Inc(j);
    end;
  end;

  result := workout;
end;

function TdmMain.DeleteWorkout(workout: TWorkout): TWorkout;
begin
  if not tblWorkout.Locate('ID', workout.ID, []) then
  begin
    raise Exception.Create('Cannot find workout with ID ' +
      inttostr(workout.ID));
    Exit;
  end;

  workout.OwnerUsername := tblWorkout['UserUsername'];
  workout.Title := tblWorkout['Title'];
  workout.Description := tblWorkout['Description'];
  workout.Timestamp := tblWorkout['Timestamp'];

  tblWorkout.Delete;

  result := workout;
end;

end.
