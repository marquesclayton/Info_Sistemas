unit UFormGeneric;

interface

uses
  Forms, SysUtils, Classes, UTheme, UUtilString;


type

    TTypeMessage = (ERROR, INFO, WARNING, OK);
    TCallBackShowMessage = procedure(const title: String; const msg: String) of object;

  TFormGeneric = class(TForm)
  private
    class var _theme: TThemedata;

    function getTheme: TThemedata;
  public
    stringUtil: TUtilString;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property theme: TThemedata read getTheme;
  protected

  end;
implementation

{$R *.dfm}

{ TformGeneric }

constructor TFormGeneric.Create(AOwner: TComponent);
begin
  inherited;
  stringUtil := TUtilString.Create;
end;

destructor TFormGeneric.Destroy;
begin
  //FreeAndNil(_theme);
  inherited;
end;

function TFormGeneric.getTheme: TThemedata;
begin
    if((_theme = nil) or (not Assigned(_theme))) then begin
        _theme := TThemeData.Create;
  end;
  result := _theme;
end;

end.
