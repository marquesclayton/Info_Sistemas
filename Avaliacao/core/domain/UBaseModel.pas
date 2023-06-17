unit UBaseModel;

interface

uses  DBXJSON, UBaseModelJson, XMLDoc, XMLIntf, Classes;

type
    TBaseModel = class(TBaseModelJson)
        private
            FVersionDate: TDateTime;
            FId: Int64;
            FInsertDate: TDateTime;
            FChangeDate: TDateTime;
            FInsertUserId: Int64;
            FChangeUserId: Int64;
        protected

        public
            property id:Int64 read FId write FId;
            property versionDate: TDateTime read FVersionDate write FversionDate;
            property insertDate: TDateTime read FInsertDate write FInsertDate;
            property changeDate: TDateTime read FChangeDate write FChangeDate;
            property insertUserId: Int64 read FInsertUserId write FInsertUserId;
            property changeUserId: Int64 read FChangeUserId write FChangeUserId;

          constructor Create; virtual;
          function getFieldJson(const fieldName: string): TJSONPair; overload;
          function getXML(Aowner: TComponent): TXMLDocument; virtual; abstract;
    end;

implementation

uses SysUtils;

{ TBaseModel }

constructor TBaseModel.Create;
begin
  inherited Create;
  addField('id',@FId, tfInt64);
  addField('version', @FVersionDate, tfDateTime);
  addField('insertDate', @FInsertDate, tfDateTime);
  addField('changeDate', @FChangeDate, tfDateTime);
  //addField(charge('changeUserId', 'changeUser', setChangeUserId, getChangeUserId));
  //addField(charge('insertUserId', 'insertUser', setInsertUserId, getInsertUserId));
end;

function TBaseModel.getFieldJson(const fieldName: string): TJSONPair;
  var
    jo: TJSONObject;
begin
  try
    jo := Self.toJson();
    result := getFieldJsonCustom(fieldName, jo);
  finally
    FreeAndNil(jo);
  end;
end;

end.
