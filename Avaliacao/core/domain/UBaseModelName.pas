unit UBaseModelName;

interface

uses UBaseModel, DBXJSON;

type

    TBaseModelName = class(TBaseModel)
      private
        FName: String;

      protected
      public
        property name: String read FName write FName;

        constructor Create; override;

    end;

implementation

uses UBaseModelJson;

{ TBaseModelName }

constructor TBaseModelName.Create;
begin
  inherited;
  addField('name', @FName, tfString);
end;

end.
