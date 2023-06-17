unit UConnectionSmtpClient;

interface

uses SysUtils, Forms, IniFiles, IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
IdExplicitTLSClientServerBase, XMLDoc, XMLIntf, Classes, Windows;

type
    TConfigSmtp = record
        host: String;
        port: Integer;
        user: String;
        password: String;
    end;

    TSmtpClient = class(TIdSMTP)
        private
            _configSmtp: TConfigSmtp;

            _lSSL: TIdSSLIOHandlerSocketOpenSSL;
            _lMessage: TIdMessage;
            _lText: TIdText;

            procedure chargeConfig(const iniFile: TIniFile);
            procedure initService();
        public
            constructor Create();
            destructor Destroy(); override;

            procedure receiver(const address, name: String);
            procedure body(const msg, subject: String);
            procedure attachament(xml: TXMLDocument);

            procedure sendEmail();

            function sendExternal(handler: HWND;const command: String):Cardinal;
    end;

implementation

uses UException, ShellAPI;

{ TSmtpClient }

procedure TSmtpClient.attachament(xml: TXMLDocument);
var
    pathDir, pathFile: String;
begin
    try
        if(Assigned(xml)) then begin
            pathDir := ExtractFilePath(Application.ExeName) + 'temp';
            if (not DirectoryExists(pathDir))then begin
                if (not CreateDir(pathDir)) then begin
                    ForceDirectories(pathDir);
                end;
            end;
            pathFile := pathDir+'\arq_temp.xml';
            //xml.Active := true;
            xml.SaveToFile(pathFile);

            if(FileExists(pathFile)) then begin
                TIdAttachmentFile.Create(_lMessage.MessageParts, pathFile);
            end;
        end;
    finally
        if(FileExists(pathFile))then begin
            DeleteFile(pchar(pathFile));
        end;
    end;
end;

procedure TSmtpClient.body(const msg, subject: String);
begin
    _lMessage.Subject := subject;
    _lMessage.Encoding := meMIME;
    if(Assigned(_lText)) then begin
        _lText.Free;
    end;
    _lText := TIdText.Create(_lMessage.MessageParts);
    _lText.Body.Add(msg);
    _lText.ContentType := 'text/plain; charset=iso-8859-1';
end;

procedure TSmtpClient.chargeConfig(const iniFile: TIniFile);
begin
    _configSmtp.host := iniFile.ReadString('Gmail', 'hostSmtp', 'Host n�o definido');
    _configSmtp.port := iniFile.ReadInteger('Gmail', 'port', 465);
    _configSmtp.user := iniFile.ReadString('Gmail', 'user', 'Usert n�o definido');
    _configSmtp.password := iniFile.ReadString('Gmail', 'password', 'Password n�o definido');
end;

constructor TSmtpClient.Create;
var
    fileINI: TIniFile;
    pathFile: String;
begin
    inherited Create(nil);
    _lMessage := TIdMessage.Create(nil);
    _lSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    pathFile := ExtractFilePath(Application.ExeName) + 'smtp_conf.ini';
    fileINI := TIniFile.Create(pathFile);
    try
        chargeConfig(fileINI);
        initService();
    finally
        fileINI.Free;
    end;

end;

destructor TSmtpClient.Destroy;
begin
    if(Assigned(_lSSL)) then begin
        FreeAndNil(_lSSL);
    end;
    if(Assigned(_lMessage)) then begin
        FreeAndNil(_lMessage);
    end;
    if(Assigned(_lText)) then begin
        FreeAndNil(_lText);
    end;
  inherited;
end;

procedure TSmtpClient.initService;
begin
    _lSSL.SSLOptions.Method := sslvTLSv1;
    _lSSL.SSLOptions.Mode := sslmClient;
    IOHandler := _lSSL;
    AuthType := satDefault;
    UseTLS := utUseRequireTLS;
    Host := _configSmtp.host;
    Port := _configSmtp.port;
    Username := _configSmtp.user;
    Password := _configSmtp.password;
end;
procedure TSmtpClient.receiver(const address, name: String);
begin
    _lMessage.From.Address := address;
    _lMessage.ReplyTo.EMailAddresses := _lMessage.From.Address;
    _lMessage.From.Name := name;
end;


procedure TSmtpClient.sendEmail();
begin
    try
        Connect;
        Authenticate;
    except
        on E:Exception do begin
            raise ExceptionCMP.Create(E.Message, 'Falha conex�o', e.BaseException.Message, '', '', 3);
            Exit;
        end;
    end;

    try
        Send(_lMessage);
    except
        On E:Exception do begin
            raise ExceptionCMP.Create(E.Message, 'Falha no envio', e.BaseException.Message, '', '', 3);
        end;
    end;
end;

function TSmtpClient.sendExternal(handler: HWND; const command: String): Cardinal;
var
    cmd: String;
begin
    try
        cmd := '-jar infoMail-1.0.0.jar ';
        cmd := cmd + '"' + _configSmtp.user + '" "' + _configSmtp.password + '" "' + _configSmtp.host + '" "' + IntToStr(_configSmtp.port) +'" ';
        cmd := cmd + command;

        ShellExecute( handler,'open', PChar('java'), PWideChar(cmd) ,PWideChar(ExtractFilePath(Application.ExeName) + 'bin\'),SW_HIDE);
        result := 0;
    except
        result := 1;
    end;

end;

end.
