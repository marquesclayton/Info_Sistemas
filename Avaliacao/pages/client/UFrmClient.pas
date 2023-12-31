unit UFrmClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UformOfBody, DB, Grids, DBGrids, ExtCtrls, Buttons, UDMCrud, Mask,
  StdCtrls, ComCtrls, UClientModel, UCrudClientModal, Menus;

type

  TFrmClient = class(TformOfBody)
    pnGridList: TPanel;
    dsClient: TDataSource;
    gridClient: TDBGrid;
    pnBtnNew: TPanel;
    pnChild: TPanel;
    btnNewClient: TSpeedButton;
    ppActionsGrid: TPopupMenu;
    ppItemView: TMenuItem;
    ppItemEdit: TMenuItem;
    ppItemDelete: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnNewClientClick(Sender: TObject);
    procedure gridClientDblClick(Sender: TObject);
    procedure ppItemViewClick(Sender: TObject);
    procedure ppItemEditClick(Sender: TObject);
    procedure ppItemDeleteClick(Sender: TObject);
  private
    procedure closeCadModal(const client: TClientModel; const statusCrud: TStatusCrud);
    function validationBusines(const client: TClientModel; const statusCrud: TStatusCrud): String;
    procedure openCrudClient(const client: TClientModel; const statusCrud: TStatusCrud);

    procedure sendEmail(const client: TClientModel);

    function getEntityclient(): TClientModel;
  public

  end;


implementation

uses UConnectionSmtpClient, XMLDoc, UException;

{$R *.dfm}

procedure TFrmClient.btnNewClientClick(Sender: TObject);

begin
  inherited;
  openCrudClient(nil, inNew);
end;

procedure TFrmClient.closeCadModal(const client: TClientModel; const statusCrud: TStatusCrud);
begin
    if(client <> nil) then begin
        if(Assigned(client)) then begin
            if(not dsClient.DataSet.Active) then begin
                dsClient.DataSet.Open;
            end;
            dsClient.DataSet.DisableControls;
            if(statusCrud = inNew) then begin
                dsClient.DataSet.Append;
            end else begin
                dsClient.DataSet.Edit;
            end;
            dsClient.DataSet.FieldByName('Name').AsString := client.name;
            dsClient.DataSet.FieldByName('email').AsString := client.email;
            dsClient.DataSet.FieldByName('telephone').AsString := client.telephone;
            dsClient.DataSet.FieldByName('idCard').AsString := client.idCard;
            dsClient.DataSet.FieldByName('socialSecurity').AsString := client.socialSecurity;
            dsClient.DataSet.FieldByName('street').AsString := client.socialSecurity;
            dsClient.DataSet.FieldByName('number').AsString := client.number;
            dsClient.DataSet.FieldByName('complement').AsString := client.complement;
            dsClient.DataSet.FieldByName('district').AsString := client.district;
            dsClient.DataSet.FieldByName('city').AsString := client.city;
            dsClient.DataSet.FieldByName('state').AsString := client.state;
            dsClient.DataSet.FieldByName('country').AsString := client.country;
            dsClient.DataSet.FieldByName('postalCode').AsString := client.postalCode;

            dsClient.DataSet.post;
            dsClient.DataSet.EnableControls;

            if(statusCrud = inNew)then begin
                sendEmail(client);
                showMessageOk('Novo cliente', 'Cliente inserido com sucesso');
            end else begin
                showMessageOk('Altera��o', 'Cliente alterado com sucesso');
            end;
        end;
    end;
end;

procedure TFrmClient.FormCreate(Sender: TObject);
begin
    setTitle('Cadastro de clientes');
    inherited;
    Self.Color := theme.primaryColor;
    pnChild.Parent := pnFull;
    pnBtnNew.Parent := pnActions;

end;

function TFrmClient.getEntityclient: TClientModel;
var
    client: TClientModel;
begin
  inherited;
    client := TClientModel.Create;

    if(dsClient.DataSet.Active and (dsClient.DataSet.RecordCount > 0) and (dsClient.DataSet.RecNo > -1)) then begin
        with dsClient.DataSet do begin
            with client do begin
                client.name := FieldByName('name').AsString;
                idCard := FieldByName('idCard').AsString;
                socialSecurity := FieldByName('socialSecurity').AsString;
                telephone := FieldByName('telephone').AsString;
                email := FieldByName('email').AsString;
                postalCode := FieldByName('postalCode').AsString;
                street := FieldByName('street').AsString;
                number := FieldByName('number').AsString;
                complement := FieldByName('complement').AsString;
                district := FieldByName('district').AsString;
                state := FieldByName('state').AsString;
                city := FieldByName('city').AsString;
                country := FieldByName('country').AsString;
                id := FieldByName('id').AsLargeInt;
            end;
      end;
    end else begin
        showMessageWarning('A��o inv�lida', 'N�o h� registro para a a��o');
    end;
   result := client;

end;

procedure TFrmClient.gridClientDblClick(Sender: TObject);
var
    client: TClientModel;
begin
  inherited;
    client := getEntityclient();
    try
        openCrudClient(client, inEdit);
    finally
        client.Free;
    end;
end;

procedure TFrmClient.openCrudClient(const client: TClientModel;
  const statusCrud: TStatusCrud);
var
    cad: TFrmCrudClientModal;
begin
  inherited;
  cad := TFrmCrudClientModal.Create(Self, statusCrud, client, closeCadModal, validationBusines);
  try
      cad.showMessageError := showMessageError;
      cad.ShowModal();
  finally
      cad.Free;
  end;

end;

procedure TFrmClient.ppItemDeleteClick(Sender: TObject);
var client: TClientModel;
begin
    inherited;
    client := getEntityclient();
    try
        if(MessageDlg('Confirma a exclus�o do cliente ' + client.name + '?', mtConfirmation, [mbyes,mbno],0) = mrYes) then begin
            dsClient.DataSet.DisableControls;
            dsClient.DataSet.Delete;
            dsClient.DataSet.EnableControls;
        end;
    finally
        client.Free;
    end;


end;

procedure TFrmClient.ppItemEditClick(Sender: TObject);
begin
    inherited;
    gridClientDblClick(Sender);
end;

procedure TFrmClient.ppItemViewClick(Sender: TObject);
var
    client: TClientModel;
begin
  inherited;
    client := getEntityclient();
    try
        openCrudClient(client, inPreview);
    finally
        client.Free;
    end;
end;

procedure TFrmClient.sendEmail(const client: TClientModel);
var
    email: TSmtpClient;
    xml: TXMLDocument;
    mail: TStringlist;
    pathDir, pathDirTemp, pathFile, command: String;
    emailSuccess: Boolean;
begin
    email := TSmtpClient.Create;
    try
        xml := client.getXML(Self);
        try
            mail := TStringList.Create;
            try
                mail.values['to'] := client.email;
                mail.values['body'] := 'Seja bem vindo a Info Sistemas!  Segue o XML com seus dados cadastrados.';

                if(Assigned(xml)) then begin
                    pathDir := ExtractFilePath(Application.ExeName);
                    pathDirTemp := pathDir + 'temp';
                    if (not DirectoryExists(pathDirTemp))then begin
                        if (not CreateDir(pathDirTemp)) then begin
                            ForceDirectories(pathDirTemp);
                        end;
                    end;
                    pathFile := pathDirTemp+'\arq_temp.xml';
                    xml.SaveToFile(pathFile);
                    if FileExists(pathFile) then begin
                        mail.values['attachment0'] := pathFile;
                    end;
                    command := '"' + client.email + '" "Confirmacao de cadastro" "Seja bem vindo a�Info Sistemas!  Segue o XML com seus dados cadastrados."';
                    command := command + ' "' + pathFile + '"';

                    emailSuccess := email.sendExternal(self.Handle, command) = 0;

                    if(not emailSuccess) then begin
                        showMessageError('Servi�o de e-mail', 'Falha ao enviar e-mail de cadastro ao cliente '+ client.name);
                    end;
                end;
            finally
                mail.Free;
            end;
        finally
            xml.Free;
        end;
    finally
        email.Destroy;
    end;
end;

function TFrmClient.validationBusines(const client: TClientModel;
  const statusCrud: TStatusCrud): String;
var position: Integer;
begin
    result := EmptyStr;
    if(not dsClient.DataSet.Active) then begin
        dsClient.DataSet.Open;
    end;

    dsClient.DataSet.DisableControls;
    if(dsClient.DataSet.RecordCount > 0) then begin
        position := dsClient.DataSet.RecNo;
        if(statusCrud = inNew) then begin
            if(dsClient.DataSet.Locate('socialsecurity', client.socialSecurity, [])) then begin
                result := 'O CPF ' + client.socialSecurity + '  j� est� cadastrado. Favor informar um CPF n�o cadastrado.';
            end else if(dsClient.DataSet.Locate('name', client.name, [])) then begin
                result := 'O nome ' + client.name + '  j� est� cadastrado. Favor informar um nome n�o cadastrado.';
            end else if(dsClient.DataSet.Locate('email', client.email, [])) then begin
                result := 'O e-mail ' + client.email + '  j� est� cadastrado. Favor informar um e-mail n�o cadastrado.';
            end;
        end else begin
            dsClient.DataSet.First;
            while (not dsClient.DataSet.Eof) do begin
                if(dsClient.DataSet.FieldByName('id').AsLargeInt <> client.id) then begin
                    if(dsClient.DataSet.FieldByName('socialsecurity').AsString = client.socialSecurity) then begin
                        result := 'O CPF ' + client.socialSecurity + '  j� est� cadastrado. Favor informar um CPF n�o cadastrado.';

                        break;
                    end;
                    if(dsClient.DataSet.FieldByName('name').AsString = client.name) then begin
                        result := 'O nome ' + client.name + '  j� est� cadastrado. Favor informar um nome n�o cadastrado.';
                        break;
                    end;
                    if(dsClient.DataSet.FieldByName('email').AsString = client.email) then begin
                        result := 'O e-mail ' + client.email + '  j� est� cadastrado. Favor informar um e-mail n�o cadastrado.';
                        break;
                    end;
                end;
                dsClient.DataSet.Next;
            end;
        end;
        dsClient.DataSet.RecNo := position;
    end;
    dsClient.DataSet.EnableControls;
end;

initialization
    RegisterClass(TFrmClient)
finalization
    UnRegisterClass(TFrmClient);
end.
