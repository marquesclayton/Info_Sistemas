unit UTheme;

interface

uses Controls, Windows, Messages, Graphics;

type
    TThemeData = class(TObject)

        private
            _primaryColor: Tcolor;
            _menuColor: TColor;
            _menuButtonColor: TColor;
            _primaryButtonColor: TColor;
            _messageErrorColor: TColor; //$001B16BE
            _messageInfoColor: TColor; //$00BE9516
            _messageWarningColor:TColor ; //$0016BEBE
            _messageOkColor: TColor; //$0041BE16
            _panelColorField:TColor;

            _colorFormInList: TColor;
            _colorFormInNew: TColor;
            _colorFormInEdit: Tcolor;
            _colorFormInView: Tcolor;

            _colorBtnCrudNew: TColor;
            _colorBtnCrudSave: TColor;
            _colorBtnCrudCancel: TColor;
            _colorBtnCrudDelete: TColor;

            _colorBtnFormReturn: TColor;

            function getMenuButtonColor: TColor;
            function getMenuColor: Tcolor;
            function getPrimaryColor: Tcolor;
            function getMessageErrorColor: TColor;
            function getMessageInfoColor: TColor;
            function getMessageOkColor: TColor;
            function getMessageWarningColor: TColor;
            function getPrimaryButtonColor: TColor;
            function getPanelColorField: TColor;
            function getColorFormInEdit: TColor;
            function getColorFormInList: TColor;
            function getColorFormInNew: TColor;
            function getColorFormInView: TColor;
            function getColorBtnCrudCancel: TColor;
            function getColorBtnCrudDelete: TColor;
            function getColorBtnCrudNew: TColor;
            function getColorBtnCrudSave: TColor;
            function getColorBtnFormReturn: TColor;
        public
            procedure makeRounded(Control: TWinControl; radius: Integer = 5);

            property primaryColor: Tcolor read getPrimaryColor;
            property menuColor: Tcolor read getMenuColor;
            property menuButtonColor: TColor read getMenuButtonColor;
            property messageErrorColor: TColor read getMessageErrorColor; //$001B16BE
            property messageInfoColor: TColor read getMessageInfoColor; //$00BE9516
            property messageWarningColor: TColor read getMessageWarningColor; //$0016BEBE
            property messageOkColor: TColor read getMessageOkColor; //$0041BE16
            property primaryButtonColor: TColor read getPrimaryButtonColor;
            property panelColorField: TColor read getPanelColorField;

            property colorFormInList: TColor read getColorFormInList;
            property colorFormInNew: TColor read  getColorFormInNew;
            property colorFormInEdit: TColor read getColorFormInEdit;
            property colorFormInView: TColor read getColorFormInView;

            property colorBtnCrudNew: TColor read getColorBtnCrudNew;
            property colorBtnCrudSave: TColor read getColorBtnCrudSave;
            property colorBtnCrudCancel: TColor read getColorBtnCrudCancel;
            property colorBtnCrudDelete: TColor read getColorBtnCrudDelete;

            property colorBtnFormReturn: TColor read getColorBtnFormReturn;

            constructor Create;

    end;

implementation

{ TThemeData }

constructor TThemeData.Create;
begin
    inherited Create;
    _primaryColor:= $00FFFFFF;
    _menuColor:= $00BFBDB7;
    _menuButtonColor:= _menuColor + $00070E17;
    _primaryButtonColor:= $00FF8D48;
    _messageErrorColor:= $001B16BE;
    _messageInfoColor:= $00BE9516;
    _messageWarningColor:= $0016BEBE;
    _messageOkColor:= $0041BE16;
    _panelColorField:= $00E2E2E2;

    _colorFormInNew := $00F7F7DF;
    _colorFormInList:= $00DFDFDF;
    _colorFormInEdit := $00D6E2CF;
    _colorFormInView := $00C0F7F8;


    _colorBtnCrudNew:= $00DEA89A;
    _colorBtnCrudSave:= $007BE458;
    _colorBtnCrudCancel:= $003333FF;
    _colorBtnCrudDelete:= $00CBBCC1;

    _colorBtnFormReturn:= $005B5BFD;

end;

function TThemeData.getColorBtnCrudCancel: TColor;
begin
    result := Self._colorBtnCrudCancel;
end;

function TThemeData.getColorBtnCrudDelete: TColor;
begin
    result := Self._colorBtnCrudDelete;
end;

function TThemeData.getColorBtnCrudNew: TColor;
begin
    result := Self._colorBtnCrudNew;
end;

function TThemeData.getColorBtnCrudSave: TColor;
begin
    result := Self._colorBtnCrudSave;
end;

function TThemeData.getColorBtnFormReturn: TColor;
begin
    result := Self._colorBtnFormReturn;
end;

function TThemeData.getColorFormInEdit: TColor;
begin
    result := Self._colorFormInEdit;
end;

function TThemeData.getColorFormInList: TColor;
begin
  result := Self._colorFormInList;
end;

function TThemeData.getColorFormInNew: TColor;
begin
  result := Self._colorFormInNew;
end;

function TThemeData.getColorFormInView: TColor;
begin
  result := Self._colorFormInView;
end;

function TThemeData.getMenuButtonColor: TColor;
begin
    result := getMenuColor + $00070E17;
end;

function TThemeData.getMenuColor: Tcolor;
begin
    result := Self._menuColor;
end;

function TThemeData.getMessageErrorColor: TColor;
begin
    result := Self._messageErrorColor;
end;

function TThemeData.getMessageInfoColor: TColor;
begin
    result := self._messageInfoColor;
end;

function TThemeData.getMessageOkColor: TColor;
begin
    result := Self._messageOkColor;
end;

function TThemeData.getMessageWarningColor: TColor;
begin
    result := Self._messageWarningColor;
end;

function TThemeData.getPanelColorField: TColor;
begin
    result := Self._panelColorField;
end;

function TThemeData.getPrimaryButtonColor: TColor;
begin
    result:= Self._primaryButtonColor;
end;

function TThemeData.getPrimaryColor: Tcolor;
begin
    result := Self._primaryColor;
end;

procedure TThemeData.makeRounded(Control: TWinControl; radius: Integer = 5);
var
    R: TRect;
    Rgn: HRGN;
begin
    with Control do begin
        R := ClientRect;
        rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, radius, radius);
        //rgn := CreateRoundRectRgn(Left, Top, Width, Height, radius, radius);
        Perform(EM_GETRECT, 0, lParam(@r));
        InflateRect(r, - 5, - 5);
        Perform(EM_SETRECTNP, 0, lParam(@r));
        SetWindowRgn(Handle, rgn, True);
        Invalidate;
    end;
end;

end.
