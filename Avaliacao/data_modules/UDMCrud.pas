unit UDMCrud;

interface

uses
  SysUtils, DBClient, DB, Classes;

type
  TdmCrud = class(TDataModule)
    cdClient: TClientDataSet;
    cdClientName: TStringField;
    cdClientemail: TStringField;
    cdClienttelephone: TStringField;
    cdClientid: TLargeintField;
    cdClientidCArd: TStringField;
    cdClientsocialSecurity: TStringField;
    cdClientstreet: TStringField;
    cdClientnumber: TStringField;
    cdClientcomplement: TStringField;
    cdClientdistrict: TStringField;
    cdClientcity: TStringField;
    cdClientstate: TStringField;
    cdClientcountry: TStringField;
    cdClientpostalCode: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdClientNewRecord(DataSet: TDataSet);
  private
    _idClient: int64;
  public
    { Public declarations }
  end;

var
  dmCrud: TdmCrud;

implementation

{$R *.dfm}

procedure TdmCrud.cdClientNewRecord(DataSet: TDataSet);
begin
    Inc(_idClient);
    DataSet.FieldByName('id').AsLargeInt := _idClient;
end;

procedure TdmCrud.DataModuleCreate(Sender: TObject);
begin
    _idClient := 0;
end;

end.
