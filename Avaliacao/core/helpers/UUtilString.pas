unit UUtilString;

interface

  type

    vString = array of String;

    TUtilString = class
      private
        class var _instance: TUtilString;
        constructor Create;

      public

        destructor Destroy; override;

        class function getInstance: TUtilString;
        class function NewInstance: TObject; override;

        function Split(text: String; Delimiter: Char): vString;
        function completeZero(const value: String; size: Integer; esquerda: boolean = true): String;
        function to_upper(const value: String; const semacento: boolean = false):String;
        function to_lower(const value: String; const semacento: boolean = false):String;
        function intCh ( int: ShortInt ): Char;
        function chInt ( ch: Char ): ShortInt;
        function ValorInt(Texto : string) : Integer;
        function replace(S : string; De,Para :Char):string;
        function completaString(texto : string; comp : char; size : Integer; esquerda:Boolean = True):String;
        function exataString(texto : string; comp : char; size : Integer; esquerda:Boolean = True):String;
        function cortaString(texto : string; size : Integer):String;
        function extrairParte(var texto : string; size : Integer):String;
        function isNumber(text : string):Boolean;
        function RemoveAcento(Str: string): string;
        function tiraponto(S: string): string;
        function converter_utf8_ansi(const Source: string):string;
        function StripNonJson(const value: String): String;
    end;

implementation

uses SysUtils, Character;

{ TUtilString }

function TUtilString.chInt(ch: Char): ShortInt;
begin
  Result := Ord ( ch ) - Ord ( '0' );
end;

function TUtilString.completaString(texto: string; comp: char; size: Integer;
  esquerda: Boolean): String;
var
  I : integer;
  tot : ShortInt;
begin
    result := '';
    tot := size - length(texto);
    for I := 1 to tot do begin
      result :=  result + comp;
    end;

    if(esquerda) then begin
      result := result + texto;
    end else begin
      result := texto + result;
    end;
end;

function TUtilString.completeZero(const value: String; size: Integer;
  esquerda: boolean): String;
var
   tam: integer;
  I: Integer;
begin
     tam := size - Length(value);

     result := EmptyStr;

     if(tam > 0) then begin
        for I := 1 to tam do begin
            result := '0' + result;
        end;
        if(esquerda) then  begin
            result := result + value;
        end else begin
            result := value + result;
        end;

     end else begin
         result := value;
     end;
end;

function TUtilString.converter_utf8_ansi(const Source: string): string;
var
   Iterator, SourceLength, FChar, NChar: Integer;
begin
   Result := '';
   Iterator := 0;
   SourceLength := Length(Source);
   while Iterator < SourceLength do
   begin
      Inc(Iterator);
      FChar := Ord(Source[Iterator]);
      if FChar >= $80 then
      begin
         Inc(Iterator);
         if Iterator > SourceLength then break;
         FChar := FChar and $3F;
         if (FChar and $20) <> 0 then
         begin
            FChar := FChar and $1F;
            NChar := Ord(Source[Iterator]);
            if (NChar and $C0) <> $80 then break;
            FChar := (FChar shl 6) or (NChar and $3F);
            Inc(Iterator);
            if Iterator > SourceLength then break;
         end;
         NChar := Ord(Source[Iterator]);
         if (NChar and $C0) <> $80 then break;
         Result := Result + WideChar((FChar shl 6) or (NChar and $3F));
      end
      else
         Result := Result + WideChar(FChar);
   end;
end;

function TUtilString.cortaString(texto: string; size: Integer): String;
begin
    if(Length(Trim(texto)) > size) then begin
      result := Copy(texto,1,size);
    end else begin
      result := texto;
    end;
end;

constructor TUtilString.Create;
begin

end;

destructor TUtilString.Destroy;
begin
  FreeAndNil(_instance);
  inherited;
end;

function TUtilString.exataString(texto: string; comp: char; size: Integer;
  esquerda: Boolean): String;
var
  I : integer;
begin
    result := '';
    I := 1;
    while(I <= size) do begin
      if(Length(texto) >= I) then begin
        result := result + texto[I];
      end else begin
        if(esquerda) then begin
          result := comp+result;
        end else begin
          result := result + comp;
        end;
      end;

      Inc(I);
    end;
end;

function TUtilString.extrairParte(var texto: string; size: Integer): String;
var
  I   : Integer;
  aux : string;
begin
    aux := EmptyStr;
    Result := EmptyStr;
    if(Length(texto) > size) then begin
      for I := 1 to Length(texto) do begin
        if(I <= size)then begin
            Result := Result + texto[I];
        end else begin
            aux := aux + texto[I];
        end;
      end;
      texto := aux;
    end else begin
      result := texto;
    end;
end;

class function TUtilString.getInstance: TUtilString;
begin
  result := TUtilString.Create;
end;

function TUtilString.intCh(int: ShortInt): Char;
begin
     Result := Chr ( int + Ord ( '0' ) );
end;

function TUtilString.StripNonJson(const value: String): String;
  var
    ch: char;
    inString: boolean;
begin
    Result := '';
    inString := false;
    for ch in value do begin
        if (ch = '"') then begin
            inString := not inString;
        end;
        if (TCharacter.IsWhiteSpace(ch) and not inString) then begin
            continue;
        end;

        Result := Result + ch;
    end;
end;

function TUtilString.isNumber(text: string): Boolean;
var
  I: Integer;
  s : string;
begin
  Result := False;
  s := replace(text, ',',#0);
  s := replace(text, '.',#0);
  if(Trim(s) = EmptyStr) then begin
    Exit;
  end else begin
    for I := 1 to Length(s) do begin
      if(not(CharInSet(s[I], ['0','1','2','3','4','5','6','7','8','9']))) then begin
        Exit;
      end;
    end;
  end;
  Result := True;
end;

class function TUtilString.NewInstance: TObject;
begin
    if not Assigned(_instance) then begin
        _instance := TUtilString(inherited NewInstance);
    end;

    result := _instance;
end;

function TUtilString.RemoveAcento(Str: string): string;
const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
   x: Integer;
begin;
  for x := 1 to Length(Str) do
    if Pos(Str[x],ComAcento) <> 0 then
      Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  Result := Str;
end;

function TUtilString.replace(S: string; De, Para: Char): string;
var
  aux : string;
  I : Integer;
begin
  aux := '';
  for I:=1 to Length(S) do begin
     if(S[I] = De)then begin
         if(Para <> #0) then
          aux := aux + Para;
     end else begin
        aux := aux + S[I];
     end;
  end;

  Result := aux;
end;

function TUtilString.Split(text: String; Delimiter: Char): vString;
var
  I: Integer;
  index: integer;

  procedure incrementaVetor();
  begin
      inc(index);
      SetLength(result, index);
  end;

  procedure incrementaRegistro(value: String);
  begin
       result[index-1] := result[index-1] + value;
  end;
begin
   finalize(result);
   if(text <> EmptyStr) then begin
        if(length(trim(text)) > 0) then begin
             if(Delimiter <> '') then begin
                 index := 0;
                 for I := 1 to Length(text) do begin
                     if(I = 1) then begin
                          incrementaVetor();
                          if(text[I] <> Delimiter) then begin
                              incrementaRegistro(text[I]);
                          end;
                     end else if(text[I] = Delimiter) then begin
                         incrementaVetor();
                     end else begin
                         incrementaRegistro(text[I]);
                     end;
                 end;
             end else begin
                 SetLength(result, 1);
                 result[0] := text;
             end;
        end;
   end;
end;

function TUtilString.tiraponto(S: string): string;
var
  I: Integer;
  Texto: string;
begin
  Texto := '';
  for I := 1 to length(S) Do
  begin
    if S[I] = '.' then
      Continue;
    if S[I] = '-' then
      Continue;
    if S[I] = '/' then
      Continue;
    Texto := Texto + S[I];
  end;
  result := Texto;
end;

function TUtilString.to_lower(const value: String;
  const semacento: boolean): String;
var
  i :  Integer;

  function to_char_lower(const ch: String): char;
  begin
  to_char_lower := ch[1];
    case ch[1] of
      'Â': to_char_lower := 'â';
      'Á': to_char_lower := 'á';
      'Ã': to_char_lower := 'ã';
      'À': to_char_lower := 'à';
      'É': to_char_lower := 'é';
      'Ê': to_char_lower := 'ê';
      'È': to_char_lower := 'è';
      'Ì': to_char_lower := 'í';
      'Î': to_char_lower := 'î';
      'Ô': to_char_lower := 'ô';
      'Ó': to_char_lower := 'ó';
      'Õ': to_char_lower := 'õ';
      'Ò': to_char_lower := 'ò';
      'Ü': to_char_lower := 'ü';
      'Ú': to_char_lower := 'ú';
      'Ç': to_char_lower := 'ç';
    end;
  end;
begin
    if(semacento) then begin
        result := LowerCase(RemoveAcento(value));
    end else begin
        result :=  LowerCase(value);
    end;
  if(length(trim(result)) > 0) then begin
    for i := 1 to Length(result) do begin
       result[i] := to_char_lower(result[i]);
    end;
  end;

end;

function TUtilString.to_upper(const value: String;
  const semacento: boolean): String;
var
  i :  Integer;

  function to_char_upper(const ch: char): char;
  begin
  to_char_upper := ch;
    case ch of
      'â': to_char_upper := 'Â';
      'á': to_char_upper := 'Á';
      'ã': to_char_upper := 'Ã';
      'à': to_char_upper := 'À';
      'é': to_char_upper := 'É';
      'ê': to_char_upper := 'Ê';
      'è': to_char_upper := 'È';
      'í': to_char_upper := 'Ì';
      'î': to_char_upper := 'Î';
      'ô': to_char_upper := 'Ô';
      'ó': to_char_upper := 'Ò';
      'õ': to_char_upper := 'Õ';
      'ò': to_char_upper := 'Ò';
      'ü': to_char_upper := 'Ü';
      'ú': to_char_upper := 'Ú';
      'ç': to_char_upper := 'Ç';
    end;
  end;
begin
  if(semacento) then begin
        result := UpperCase(RemoveAcento(value));
    end else begin
        result :=  UpperCase(value);
    end;
  if(length(trim(result)) > 0) then begin
    for i := 0 to Length(result) do begin
       result[i] := to_char_upper(result[i]);
    end;
  end;
end;

function TUtilString.ValorInt(Texto: string): Integer;
begin
   If Texto = '' Then
     Result := 0
   Else
     Result := StrToInt(texto);
end;

end.
