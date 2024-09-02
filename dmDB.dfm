object dmMain: TdmMain
  OnCreate = DataModuleCreate
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
  object tblWorkout: TADOTable
    Active = True
    Connection = conDB
    CursorType = ctStatic
    TableDirect = True
    TableName = 'Workout'
    Left = 160
  end
  object dsWorkout: TDataSource
    DataSet = tblWorkout
    Left = 160
    Top = 80
  end
  object dbSet: TDataSource
    DataSet = tblSet
    Left = 320
    Top = 80
  end
  object tblSet: TADOTable
    Active = True
    Connection = conDB
    CursorType = ctStatic
    TableDirect = True
    TableName = 'Set'
    Left = 320
  end
  object tblSetGroup: TADOTable
    Active = True
    Connection = conDB
    CursorType = ctStatic
    TableDirect = True
    TableName = 'SetGroup'
    Left = 240
  end
  object dsSetGroup: TDataSource
    DataSet = tblSetGroup
    Left = 240
    Top = 80
  end
end
