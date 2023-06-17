unit UMessage;

interface

  uses UBaseModelJson;

  type
    TMessage = class(TCustomBaseModelJson)
      private
        FMessage: String;
        FTitle: String;
        FIcon: String;
        FMotive: String;
        FSeverity: String;
        FStatusCode: Int16;

        procedure init();
      public
        property msg: String read FMessage;
        property title: String read FTitle;
        property icon: String read FIcon;
        property motive: String read FMotive;
        property severity: String read FSeverity;
        property codeStatus: Int16 read FStatusCode;

        constructor Create; overload;
        constructor Create(const lMsg: String; const lTitle: String;const lIcon: String;const lMotive: String;const lSeverity: String; const lStatusCode: Int8); overload;
        constructor Create(const jsoString: String; const lStatusCode: Int8); overload;
    end;

implementation

{ TMessage }

constructor TMessage.Create(const lMsg, lTitle, lIcon, lMotive,
  lSeverity: String; const lStatusCode: Int8);
begin
  inherited Create;
  Self.FMessage := lMsg;
  Self.FTitle := lTitle;
  Self.FIcon := lIcon;
  Self.FMotive := lMotive;
  Self.FSeverity := lSeverity;
  Self.FStatusCode := lStatusCode;
end;

constructor TMessage.Create(const jsoString: String; const lStatusCode: Int8);
begin
  inherited Create;
  init();
  Self.fromJsonStringCustom(jsoString);
  self.FStatusCode := lStatusCode;
end;

procedure TMessage.init;
begin
  addField('message', @Self.FMessage, tfString);
  addField('title', @Self.FTitle, tfString);
  addField('icon', @Self.FIcon, tfString);
  addField('motive', @Self.FMotive, tfString);
  addField('severity', @Self.FSeverity, tfString);
end;

constructor TMessage.Create;
begin
  inherited;
  init();
end;

end.
