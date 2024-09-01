object dmMain: TdmMain
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object conDB: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\ldeca\OneD' +
      'rive\Desktop\pat-grade-11\db.mdb;Persist Security Info=False;'
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
  end
  object tblUser: TADOTable
    Active = True
    Connection = conDB
    CursorType = ctStatic
    TableDirect = True
    TableName = 'User'
    Left = 80
  end
  object dsUser: TDataSource
    DataSet = tblUser
    Left = 80
    Top = 80
  end
end
