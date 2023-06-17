unit UDateUtil;

interface

  type
    TDateUtil = class
      private
        class var _instance: TDateUtil;
        constructor Create;
      public

        destructor Destroy; override;

        class function getInstance: TDateUtil;
        class function NewInstance: TObject; override;

        function convertDateJSToDelphi(const value: int64): double;
        function convertDateDelphiToJS(const value: double): int64;
        function convertIntToDateTime(const value: Int64): double;
        function convertDateToInt(const value: double): Int64;
    end;

implementation

uses SysUtils;

{ TDateUtil }

function TDateUtil.convertDateDelphiToJS(const value: double): int64;
begin
  result := convertDateToInt(value);
  if(result >= 0) then begin
    result := result - UnixDateDelta;
  end else begin
    result := 0;
  end;
end;

function TDateUtil.convertDateJSToDelphi(const value: int64): double;
begin
  result := convertIntToDateTime(value);
  if(result >= 0) then begin
    result := result + UnixDateDelta;
  end else begin
    result := 0;
  end;
end;

function TDateUtil.convertDateToInt(const value: double): Int64;
begin
  if(value > 0) then begin
    result := Trunc(value * 24 *60 * 60 * 1000) ;
  end else begin
    result := 0;
  end;
end;

function TDateUtil.convertIntToDateTime(const value: Int64): double;
begin
  if(value > 0) then begin
    result := (value / 24 / 60 / 60 / 1000);
  end else begin
    result := 0;
  end;
end;

constructor TDateUtil.Create;
begin

end;

destructor TDateUtil.Destroy;
begin
  FreeAndNil(_instance);
end;

class function TDateUtil.getInstance: TDateUtil;
begin
    result := TDateUtil.Create;
end;

class function TDateUtil.NewInstance: TObject;
begin
    if not Assigned(_instance) then begin
        _instance := TDateUtil(inherited NewInstance);
    end;

    result := _instance;
end;

end.
