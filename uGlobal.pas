unit uGlobal;

interface

uses FMX.Objects;

type
  TSet = record
    Weight: Double;
    Reps: Integer;
  end;

  TSetArray = array of TSet;

  TSetGroup = record
    ID: Integer;
    ExerciseName: String;
    Sets: TSetArray;
  end;

  TSetGroupArray = array of TSetGroup;
  PSetGroupArray = ^TSetGroupArray;

  TUser = record
    Username: String;
    Role: String;
    Suspended: Boolean;
  end;

  TWorkout = record
    ID: Integer;
    OwnerUsername: String;
    Title: String;
    Description: String;
    Timestamp: TDateTime;
    SetGroups: TSetGroupArray;
  end;

  TWorkoutArray = array of TWorkout;

procedure LoadBackground(width, height: Integer; imgBG: TImage);

var
  activeUser: TUser;

implementation

procedure LoadBackground(width, height: Integer; imgBG: TImage);
var
  iLargest: Integer;
begin
  if width > height then
    iLargest := width
  else
    iLargest := height;

  imgBG.Bitmap.LoadFromFile('..\..\assets\Bodybuilder.jpg');
  imgBG.WrapMode := TImageWrapMode.Fit;
  imgBG.Opacity := 0.2;

  imgBG.width := iLargest;
  imgBG.height := iLargest;
  imgBG.Position.X := -(width div 2);
  imgBG.Position.Y := 0;
end;

end.
