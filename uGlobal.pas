unit uGlobal;

interface

uses FMX.Objects;

type
  TUser = record
    Username: String;
    Role: String;
    Suspended: Boolean;
  end;

procedure LoadBackground(width, height: integer; imgBG: TImage);

var
  activeUser: TUser;

implementation

procedure LoadBackground(width, height: integer; imgBG: TImage);
var
  iLargest: integer;
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
