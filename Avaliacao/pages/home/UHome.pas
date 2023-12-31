unit UHome;

interface

uses UFormGeneric, ImgList, Controls, StdCtrls, Buttons, pngimage, ExtCtrls,
    Classes, Forms, Graphics, Dialogs, SysUtils, ComCtrls, UUtilString;

type

    TFHome = class(TformGeneric)
        imgHomeLogo: TImage;
        pnHeader: TPanel;
        pnMenuLeft: TPanel;
        pnBody: TPanel;
        pnHeaderActions: TPanel;
        btnCloseApplication: TSpeedButton;
        pnMessage: TPanel;
        timeMessage: TTimer;
        lblMessageTitle: TLabel;
        imageMessage: TImage;
        mmMessage: TMemo;
        Panel1: TPanel;
        pnHeaderTitle: TPanel;
    pnMain: TPanel;
    btnCadClients: TSpeedButton;

        procedure btnCloseApplicationClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure timeMessageTimer(Sender: TObject);
    private

        utilString: TUtilString;
        timeOfMessage: TDateTime;

        procedure openFormFromButton(Sender: TObject);
        procedure openForm(const formName: String;
            const isDefault: Boolean = true);
        procedure closeChildForm(form: TForm);

        procedure showMessageError(const title: String; const msg: String);
        procedure showMessageInfo(const title: String; const msg: String);
        procedure showMessageWarning(const title: String; const msg: String);
        procedure showMessageOk(const title: String; const msg: String);
        procedure showMsg(const msgType: TTypeMessage; const title: String;
            const msg: String);

        procedure closeSplash();
    public

    end;

var
    FHome: TFHome;

implementation

uses UFormOfBody, USplash, SWSystem;

{$R *.dfm}

{ **

  M�todos de inicializa��o de tela

  ** }
procedure TFHome.FormCreate(Sender: TObject);
begin

    utilString := TUtilString.Create;

    pnHeader.Color := theme.primaryColor;
    pnmain.Color := theme.primaryColor;
    pnMenuLeft.Color := theme.menuColor;
    pnBody.Color := theme.primaryColor;
    btnCloseApplication.Width := btnCloseApplication.Height;
    Self.Height := Screen.Height - 80;
    Self.Width := Screen.Width - 50;
    Self.Left := 0;
    Self.Top := 0;
    theme.makeRounded(Self);
    theme.makeRounded(pnHeader, 10);
    theme.makeRounded(pnMenuLeft, 10);
    theme.makeRounded(pnMain, 10);
    theme.makeRounded(pnBody, 10);

    pnMenuLeft.Visible := false;
    pnBody.Visible := false;

    btnCadClients.OnClick := openFormFromButton;

    Self.Repaint;
    openForm('Splash', false);
end;

{ **
  M�todos de controle de cria��o e abertura de telas
  ** }

procedure TFHome.openForm(const formName: String; const isDefault: Boolean);
var
    formOpenName: string;
    formOpen: TForm;
    formClass: TFormClass;
begin
    formOpenName := 'TFrm' + formName;

    try
        formClass := TFormClass(FindClass(formOpenName));
        formOpen := formClass.Create(Application);

        if(LowerCase(formName) = 'splash') then begin
            formOpen.Parent := pnMain;
            (formOpen as TFrmSplash).closeSplash := closeSplash;
        end else begin
            formOpen.Parent := pnBody;
            //formOpen.Align := alClient;
        end;

        formOpen.Visible := true;
        if (isDefault) then begin
            (formOpen as TFormOfBody).showMessageError := Self.showMessageError;
            (formOpen as TFormOfBody).showMessageInfo := Self.showMessageInfo;
            (formOpen as TFormOfBody).showMessageWarning := Self.showMessageWarning;
            (formOpen as TFormOfBody).showMessageOk := Self.showMessageOk;
            (formOpen as TFormOfBody).setCallBackCloseForm(Self.closeChildForm);
            formOpen.BorderStyle := bsNone;
        end else begin
            formOpen.BorderStyle := bsNone;
            formOpen.Color := theme.panelColorField;
        end;

        theme.makeRounded(formOpen);

        formOpen.Show;

        if (pnMessage.Visible) then begin
            pnMessage.BringToFront;
        end;
    except
        on E: EClassNotFound do begin
            showMessageError('Abrir Formul�rio', 'N�o foi possivel encontrar a Tela solicitada!  >> ' + formOpenName);
        end;
    end;

end;

procedure TFHome.openFormFromButton(Sender: TObject);
begin
    openForm('Client', true);
end;

procedure TFHome.closeChildForm(form: TForm);
begin
    form.close;
    freeandnil(form);
end;

procedure TFHome.closeSplash;
begin
    pnMenuLeft.Visible := true;
    pnBody.Visible := true;
end;

procedure TFHome.btnCloseApplicationClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TFHome.showMsg(const msgType: TTypeMessage; const title, msg: String);
var
    path: String;
begin

    theme.makeRounded(pnMessage);
    path := gsAppPath + '\assets\images\message\';
    with pnMessage do begin
        Visible := false;
        // Top := - Height - 10;
        if (not pnBody.Visible) then begin
            Parent := Self;
        end else begin
            Parent := pnBody;
        end;
        Top := pnBody.Height + 2;
         Left := pnBody.Width - (Width + 5);
        //Left := 3; // pnBody.Width - (Width + 5);

        lblMessageTitle.Caption := title;
        mmMessage.Lines.Clear;
        mmMessage.Lines.Add(msg);

        try
            case (msgType) of
                ERROR:
                    begin
                        imageMessage.Picture.LoadFromFile(path + 'error_p.png');
                        Color := theme.messageErrorColor;
                        lblMessageTitle.Caption :=
                          'Erro: ' + lblMessageTitle.Caption;
                    end;
                info:
                    begin
                        imageMessage.Picture.LoadFromFile(path + 'info_p.png');
                        Color := theme.messageInfoColor;
                        lblMessageTitle.Caption :=
                          'Info: ' + lblMessageTitle.Caption;
                    end;
                WARNING:
                    begin
                        imageMessage.Picture.LoadFromFile(path + 'warning_p.png');
                        Color := theme.messageWarningColor;
                        lblMessageTitle.Caption :=
                          'Aten��o: ' + lblMessageTitle.Caption;
                    end;
                OK:
                    begin
                        imageMessage.Picture.LoadFromFile(path + 'ok_p.png');
                        Color := theme.messageOkColor;
                        lblMessageTitle.Caption :=
                          'OK: ' + lblMessageTitle.Caption;
                    end;
            end;
        except
            on ERROR: EInvalidGraphic do
            begin
                ShowMessage('Erro ao buscar imagem. -> ' + ERROR.ToString);
            end;

        end;
        imageMessage.Transparent := true;
        lblMessageTitle.Font.Color := Color;
        pnMessage.BringToFront;
        Visible := true;
    end;
    timeOfMessage := 0;
    timeMessage.Enabled := true;
end;

procedure TFHome.showMessageError(const title, msg: String);
begin
    showMsg(ERROR, title, msg);
end;

procedure TFHome.showMessageInfo(const title, msg: String);
begin
    showMsg(info, title, msg);
end;

procedure TFHome.showMessageOk(const title, msg: String);
begin
    showMsg(OK, title, msg);
end;

procedure TFHome.showMessageWarning(const title, msg: String);
begin
    showMsg(WARNING, title, msg);
end;

procedure TFHome.timeMessageTimer(Sender: TObject);
var
    tt: double;
    showHeight: Integer;
    hideHeight: Integer;
begin

    with pnMessage do
    begin
        showHeight := pnBody.Height - (Height + 3);
        hideHeight := pnBody.Height + 3;

        if ((Top > showHeight) and (timeOfMessage = 0)) then
        begin
            Top := Top - 4;
            timeOfMessage := 0;
        end
        else if ((Top <= showHeight) and (timeOfMessage = 0)) then
        begin
            timeOfMessage := now();
        end
        else
        begin
            tt := now() - timeOfMessage;
            tt := tt * 24 * 60 * 60;
            if (tt > 5) then
            begin
                Top := Top + 4;
            end;
            if (Top > hideHeight) then
            begin
                Visible := false;
                timeMessage.Enabled := false;
                timeOfMessage := 0;
            end;

        end;
    end;
end;

end.
