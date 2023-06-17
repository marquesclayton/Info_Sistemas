object dmCrud: TdmCrud
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 110
  Width = 191
  object cdClient: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    OnNewRecord = cdClientNewRecord
    Left = 16
    Top = 16
    Data = {
      940100009619E0BD01000000180000000E0000000000030000009401044E616D
      65010049000000010005574944544802000200500005656D61696C0100490000
      0001000557494454480200020078000974656C6570686F6E6501004900000001
      00055749445448020002000F0002696408000100000000000669644341726401
      00490000000100055749445448020002000A000E736F6369616C536563757269
      74790100490000000100055749445448020002000F0006737472656574010049
      0000000100055749445448020002004B00066E756D6265720100490000000100
      0557494454480200020005000A636F6D706C656D656E74010049000000010005
      5749445448020002008C00086469737472696374010049000000010005574944
      5448020002003200046369747901004900000001000557494454480200020032
      00057374617465010049000000010005574944544802000200140007636F756E
      7472790100490000000100055749445448020002002D000A706F7374616C436F
      64650100490000000100055749445448020002000A000000}
    object cdClientName: TStringField
      FieldName = 'Name'
      Size = 80
    end
    object cdClientemail: TStringField
      FieldName = 'email'
      Size = 120
    end
    object cdClienttelephone: TStringField
      FieldName = 'telephone'
      Size = 15
    end
    object cdClientid: TLargeintField
      FieldName = 'id'
    end
    object cdClientidCArd: TStringField
      FieldName = 'idCArd'
      Size = 10
    end
    object cdClientsocialSecurity: TStringField
      FieldName = 'socialSecurity'
      Size = 15
    end
    object cdClientstreet: TStringField
      FieldName = 'street'
      Size = 75
    end
    object cdClientnumber: TStringField
      FieldName = 'number'
      Size = 5
    end
    object cdClientcomplement: TStringField
      FieldName = 'complement'
      Size = 140
    end
    object cdClientdistrict: TStringField
      FieldName = 'district'
      Size = 50
    end
    object cdClientcity: TStringField
      FieldName = 'city'
      Size = 50
    end
    object cdClientstate: TStringField
      FieldName = 'state'
    end
    object cdClientcountry: TStringField
      FieldName = 'country'
      Size = 45
    end
    object cdClientpostalCode: TStringField
      FieldName = 'postalCode'
      Size = 10
    end
  end
end
