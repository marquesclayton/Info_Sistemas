unit UAddresSearchCep;

interface

uses UBaseModelJson;

type
    TAddressCEP = class(TBaseModelJson)
        private
            FLogradouro: String;
            FIbge: String;
            FBairro: String;
            FDdd: String;
            FUf: String;
            FCep: String;
            FSiafi: String;
            FLocalidade: String;
            FComplemento: String;
            FGia: String;
    function getUf: String;
        public
            constructor Create;

            property cep: String read FCep write FCep;
            property logradouro: String read FLogradouro write FLogradouro;
            property complemento: String read FComplemento write FComplemento;
            property bairro: String read FBairro write FBairro;
            property localidade: String read FLocalidade write FLocalidade;
            property uf: String read getUf write FUf;
            property ibge: String read FIbge write FIbge;
            property gia: String read FGia write FGia;
            property ddd: String read FDdd write FDdd;
            property siafi: String read FSiafi write FSiafi;

    end;

implementation

constructor TAddressCEP.Create;
begin
    inherited;
    addField('cep', @FCep, tfString);
    addField('ibge', @FIbge, tfString);
    addField('bairro', @FBairro, tfString);
    addField('localidade', @FLocalidade, tfString);
    addField('logradouro', @FLogradouro, tfString);
    addField('complemento', @FComplemento, tfString);
    addField('uf', @FUf, tfString);
    addField('gia', @FGia, tfString);
    addField('ddd', @FDdd, tfString);
    addField('siafi', @FSiafi, tfString);
end;

function TAddressCEP.getUf: String;
begin
    Result := Self.FUf;
    if( Self.FUf = 'AC') then begin
        result := 'Acre';
    end else if( Self.FUf = 'AL') then begin
        result := 'Alagoas';
    end else if( Self.FUf = 'AP') then begin
        result := 'Amap�';
    end else if( Self.FUf = 'AM') then begin
        result := 'Amazonas';
    end else if( Self.FUf = 'BA') then begin
        result := 'Bahia';
    end else if( Self.FUf = 'CE') then begin
         result := 'Cear�';
    end else if( Self.FUf = 'DF') then begin
         result := 'Distrito Federal';
    end else if( Self.FUf = 'ES') then begin
         result := 'Esp�rito Santo';
    end else if( Self.FUf = 'GO') then begin
         result := 'Goi�s';
    end else if( Self.FUf = 'MA') then begin
         result := 'Maranh�o';
    end else if( Self.FUf = 'MT') then begin
         result := 'Mato Grosso';
    end else if( Self.FUf = 'MS') then begin
         result := 'Mato Grosso do Sul';
    end else if( Self.FUf = 'MG') then begin
         result := 'Minas Gerais';
    end else if( Self.FUf = 'PA') then begin
         result := 'Par�';
    end else if( Self.FUf = 'PB') then begin
         result := 'Para�ba';
    end else if( Self.FUf = 'PR') then begin
         result := 'Paran�';
    end else if( Self.FUf = 'PE') then begin
         result := 'Pernambuco';
    end else if( Self.FUf = 'PI') then begin
         result := 'Piau�';
    end else if( Self.FUf = 'RJ') then begin
         result := 'Rio de Janeiro';
    end else if( Self.FUf = 'RN') then begin
         result := 'Rio Grande do Norte';
    end else if( Self.FUf = 'RS') then begin
         result := 'Rio Grande do Sul';
    end else if( Self.FUf = 'RO') then begin
         result := 'Rond�nia';
    end else if( Self.FUf = 'RR') then begin
         result := 'Roraima';
    end else if( Self.FUf = 'SC') then begin
         result := 'Santa Catarina';
    end else if( Self.FUf = 'SP') then begin
         result := 'S�o Paulo';
    end else if( Self.FUf = 'SE') then begin
         result := 'Sergipe';
    end else if( Self.FUf = 'TO') then begin
         result := 'Tocantins';
    end;
end;

end.
