unit dmDB;

interface

uses
  System.SysUtils, System.Classes, System.Hash, Data.DB, Data.Win.ADODB;

type
  TdmMain = class(TDataModule)
    conDB: TADOConnection;
    tblUser: TADOTable;
    dsUser: TDataSource;
    function NewSalt: String;
    function HashPassword(password, salt: string): string;
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

function TdmMain.HashPassword(password, salt: string): string;
begin
  result := THashSHA2.GetHashString(password + salt,
    THashSHA2.TSHA2Version.SHA256);
end;

end.
