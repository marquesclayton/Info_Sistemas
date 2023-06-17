program Avaliacao;

uses
  Forms,
  UHome in 'pages\home\UHome.pas' {FHome},
  UFormGeneric in 'core\pages\generic\UFormGeneric.pas' {formGeneric},
  UFormOfBody in 'core\pages\generic\UFormOfBody.pas' {formOfBody},
  USplash in 'pages\splash\USplash.pas' {FrmSplash},
  UFrmClient in 'pages\client\UFrmClient.pas' {FrmClient},
  UTheme in 'core\ui\UTheme.pas',
  UDateUtil in 'core\helpers\UDateUtil.pas',
  UMessage in 'core\helpers\UMessage.pas',
  Util in 'core\helpers\Util.pas',
  UUtilString in 'core\helpers\UUtilString.pas',
  UBaseModel in 'core\domain\UBaseModel.pas',
  UBaseModelJson in 'core\domain\UBaseModelJson.pas',
  UBaseModelName in 'core\domain\UBaseModelName.pas',
  UException in 'core\exceptions\UException.pas',
  UClientModel in 'domain\UClientModel.pas',
  UDMCrud in 'data_modules\UDMCrud.pas' {dmCrud: TDataModule},
  UCrudClientModal in 'pages\client\UCrudClientModal.pas' {FrmCrudClientModal},
  UConnectionRestClient in 'core\services\UConnectionRestClient.pas',
  UAddresSearchCep in 'domain\UAddresSearchCep.pas',
  UConnectionSmtpClient in 'core\services\UConnectionSmtpClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFHome, FHome);
  Application.CreateForm(TdmCrud, dmCrud);
  Application.Run;
end.
