unit UntMaster;

interface

uses
  RESTRequest4D,
  DataSet.Serialize,

  System.StrUtils,
  System.DateUtils,

  FMX.DialogService,

  Loading,

  System.Json,
  REST.Json,
  REST.Types,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Edit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Rtti, FMX.Grid.Style, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListBox, FMX.DateTimeCtrls,
  FMX.Layouts, FMX.TabControl;

type
  TServerFormats = class
    private
      class var FFormatSettings : TFormatSettings;
    public
      class procedure SetFormats;
      class property FormatSettings : TFormatSettings read FFormatSettings write FFormatSettings;
  end;


type
  TFrmMaster = class(TForm)
    Button1: TButton;
    Button2: TButton;
    memTemp: TFDMemTable;
    DataSource1: TDataSource;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    BindSourceDB3: TBindSourceDB;
    BindSourceDB4: TBindSourceDB;
    BindSourceDB5: TBindSourceDB;
    BindSourceDB6: TBindSourceDB;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    edtRoleName: TEdit;
    edtRoleID: TEdit;
    Button6: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    edtMemberID: TEdit;
    Button8: TButton;
    Button9: TButton;
    Button7: TButton;
    Label10: TLabel;
    edtPesqChannel: TEdit;
    gridChannels: TStringGrid;
    Label11: TLabel;
    edtPesqRole: TEdit;
    gridRoles: TStringGrid;
    TabItem3: TTabItem;
    edtChannelID: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtMemberName: TEdit;
    Button5: TButton;
    Button4: TButton;
    Label4: TLabel;
    edtReason: TEdit;
    gridMembers: TStringGrid;
    TabItem4: TTabItem;
    memJSON: TMemo;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    lstRolesExcludes: TListBox;
    Label7: TLabel;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    LinkGridToDataSourceBindSourceDB4: TLinkGridToDataSource;
    Button3: TButton;
    TabItem5: TTabItem;
    memoDescription: TMemo;
    Button10: TButton;
    edtContent: TEdit;
    edtTitle: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Button11: TButton;
    memJSONParaDirect: TMemo;
    edtMemberIDToSendMessage: TEdit;
    Label13: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridRolesCellClick(const Column: TColumn; const Row: Integer);
    procedure gridMembersCellClick(const Column: TColumn; const Row: Integer);
    procedure edtPesqRoleChangeTracking(Sender: TObject);
    procedure edtPesqChannelChangeTracking(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridChannelsCellClick(const Column: TColumn; const Row: Integer);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }

    //Tratamento campos Eduzz
    function TryReadIntegerValue(AValue: TJSONValue; AFieldName: string) : Integer;
    function TryReadDateTimeValue(AValue: TJSONValue; AFieldName: string): TDateTime;
    function TryReadFloatValue(AValue: TJSONValue; AFieldName: string): TDateTime;

//    function ConvertFloatSelf(const AValue: string): Double;

    procedure AddParam(var AURL: string; AParam: string); overload;
    procedure AddParam(var AURL: string; AParam: string; AValue: string); overload;
    function RemoveParam(var AURL: string; AParam: string): string; overload;

    procedure LoadChannels;
    procedure LoadRoles;
    function FormatDateTimeSelf(AValue: TJSONValue;
      AFieldName: string): TDateTime;
  public
    { Public declarations }
  end;

const
  //Configs
  C_DateSeparator       = '-';
  C_ShortDateFormat     = 'DD/MM/YYYY';
  C_TimeSeparator       = ':';
  C_ShortTimeFormat     = 'hh:mm';
  C_LongTimeFormat      = 'hh:mm:ss';
  C_ThousandSeparator   = '.';
  C_DecimalSeparator    = ',';
  C_LongDateFormat      = 'DD/MM/YYYY hh:mm:ss.mmm';

  //Discord
  Url_Base              = 'https://discord.com/api/v8/';
  Client_ID             = ''; //Bot
  Client_Secret         = ''; //Bot
  Authorization         = ''; //Bot
  Guild_ID              = ''; //O ID do seu servidor Discord


var
  FrmMaster: TFrmMaster;

implementation

uses
  UntDM;

{$R *.fmx}

procedure TFrmMaster.AddParam(var AURL: string; AParam: string);
begin
  AURL.Insert(AURL.Length + 1, '&' + AParam + '=%s');
end;

procedure TFrmMaster.AddParam(var AURL: string; AParam, AValue: string);
begin
  AURL.Insert(AURL.Length + 1, '&' + AParam + '=' + LowerCase(AValue));
end;

procedure TFrmMaster.Button10Click(Sender: TObject);
const
  LMessage =
  '{' +
  '  "content": "%s",' +
  '  "tts": false,' +
  '  "embeds": [{' +
  '    "title": "%s",' +
  '    "description": "%s"' +
  '  }]' +
  '}';

var
  LJson     : TJSONValue;
  LResponse : IResponse;
begin
  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('channels/%s/messages', [edtChannelID.Text]))
      .AddBody(Format(LMessage, [edtContent.Text, edtTitle.Text, memoDescription.Lines.Text]))
      .ContentType('application/json')
      .Post;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
end;

procedure TFrmMaster.Button11Click(Sender: TObject);
const
  LBody = '{"recipient_id": "%s"}';
var
  LJson      : TJSONValue;
  LResponse  : IResponse;
  LIDChannel : string;
begin
  //Primeiro criamos um Canal Direct com o Membro.
  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('users/@me/channels', [edtChannelID.Text]))
      .AddBody(Format(LBody, [edtMemberIDToSendMessage.Text]))
      .ContentType('application/json')
      .Post;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);
  LJson.TryGetValue<string>('id', LIDChannel);

  if LIDChannel.Equals(EmptyStr) then
    raise Exception.Create('Não foi possível criar o canal.');

  //https://discord.com/api/v8/channels/920783449533612082/messages?allowed_mentions=false

  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('channels/%s/messages?allowed_mentions=false', [LIDChannel]))
      .AddBody(memJSONParaDirect.Lines.Text)
      .ContentType('application/json')
      .Post;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
end;

procedure TFrmMaster.Button1Click(Sender: TObject);
var
  LJson     : TJSONValue;
  LResponse : IResponse;
begin
  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('guilds/%s?with_counts=true', [Guild_ID]))
      .Get;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
  TabControl1.GotoVisibleTab(3);
end;

procedure TFrmMaster.Button2Click(Sender: TObject);
var
  LJson     : TJSONValue;
  LResponse : IResponse;
begin
  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('guilds/%s/preview', [Guild_ID]))
      .Get;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
  TabControl1.GotoVisibleTab(3);
end;

procedure TFrmMaster.Button3Click(Sender: TObject);
var
  LJson      : TJSONValue;
  LResponse  : IResponse;
  LJsonArray : TJSONArray;
  LValues    : TJSONValue;

  LID        : string;
  LName      : string;
  LType      : Integer;
begin
  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('guilds/%s/channels', [Guild_ID]))
      .Get;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);
  LJsonArray := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;

  if not DM.memChannels.Active then
    DM.memChannels.Active := True;

  for LValues in LJsonArray do
  begin
    LID   := LValues.GetValue<string>('id');
    LName := LValues.GetValue<string>('name');
    LType := LValues.GetValue<integer>('type');

    if LType = 0 then
    begin
      DM.memChannels.Append;
      DM.memChannelsid.AsString    := LID;
      DM.memChannelsname.AsString  := LName;
      DM.memChannelstype.AsInteger := LType;
      DM.memChannels.Post;
    end
    else
      continue;
  end;

  for var I : Integer := 0 to Pred(gridChannels.ColumnCount) do
    gridChannels.Columns[I].Width := 150;

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
end;

procedure TFrmMaster.Button4Click(Sender: TObject);
var
  LJson     : TJSONValue;
  LResponse : IResponse;
  LJsonArray : TJSONArray;
  LValues    : TJSONValue;

  LID        : string;
  LNick      : string;
  LUsername  : string;
begin
  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('guilds/%s/members', [Guild_ID]))
      .AddParam('limit', '1000')
      .Get;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);
  LJsonArray := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;

  if not DM.memMembers.Active then
    DM.memMembers.Active := True;
  if not DM.memMembers.IsEmpty then
    DM.memMembers.EmptyDataSet;

  for LValues in LJsonArray do
  begin
    LID       := LValues.GetValue<string>('user.id');
    LNick     := LValues.GetValue<string>('nick');
    LUsername := LValues.GetValue<string>('user.username');

    DM.memMembers.Append;
    DM.memMembersid.AsString       := LID;
    DM.memMembersnick.AsString     := LNick;
    DM.memMembersusername.AsString := LUsername;
    DM.memMembers.Post;
  end;

  for var I : Integer := 0 to Pred(gridMembers.ColumnCount) do
    gridMembers.Columns[I].Width := 150;

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
end;

procedure TFrmMaster.Button5Click(Sender: TObject);
var
  LJson          : TJSONValue;
  LResponse      : IResponse;
  LJsonArray     : TJSONArray;
  LValues        : TJSONValue;

  LID            : string;
  LNick          : string;
  LUsername      : string;
  LPesquisa      : string;
  LDiscriminator : string;
begin
  if Pos('#', edtMemberName.Text) > 0 then
    LPesquisa := Copy(edtMemberName.Text, 1, Pos('#', edtMemberName.Text)-1)
  else
    LPesquisa := edtMemberName.Text;

  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('guilds/%s/members/search', [Guild_ID]))
      .AddParam('limit', '1000')
      .AddParam('query', LPesquisa)
      .Get;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);
  LJsonArray := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;

  if not DM.memMembers.Active then
    DM.memMembers.Active := True;
  if not DM.memMembers.IsEmpty then
    DM.memMembers.EmptyDataSet;


  for LValues in LJsonArray do
  begin
    LValues.TryGetValue<string>('user.id', LID);
    LValues.TryGetValue<string>('nick', LNick);
    LValues.TryGetValue<string>('user.username', LUsername);
    LValues.TryGetValue<string>('user.discriminator', LDiscriminator);

    DM.memMembers.Append;
    DM.memMembersid.AsString            := LID;
    DM.memMembersnick.AsString          := LNick;
    DM.memMembersusername.AsString      := LUsername;
    DM.memMembersdiscrimitator.AsString := LDiscriminator;

    DM.memMembers.Post;
  end;

  for var I : Integer := 0 to Pred(gridMembers.ColumnCount) do
    gridMembers.Columns[I].Width := 150;

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
end;

procedure TFrmMaster.Button6Click(Sender: TObject);
begin
  LoadRoles;
end;

procedure TFrmMaster.Button7Click(Sender: TObject);
var
  LJson     : TJSONValue;
  LResponse : IResponse;
begin
  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('guilds/%s/roles/%s', [Guild_ID, edtRoleID.Text]))
      .AddBody(Format('{"name":"%s"}', [edtRoleName.Text]))
      .ContentType('application/json')
      .Patch;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
end;

procedure TFrmMaster.Button8Click(Sender: TObject);
var
  LJson     : TJSONValue;
  LResponse : IResponse;
  LMessage  : String;
begin
  LMessage := Format('Confirma inclusão de aluno %s no cargo %s ?', [DM.memMembersusername.AsString, DM.memRolesname.AsString]);
  TDialogService.MessageDialog(
    LMessage,
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbNo,
    0,
    procedure (const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        LResponse :=
          TRequest.New.BaseURL(Url_Base)
            .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
            .AddHeader('X-Audit-Log-Reason', edtReason.Text, [poDoNotEncode])
            .Resource(Format('guilds/%s/members/%s/roles/%s', [Guild_ID, edtMemberID.text, edtRoleID.Text]))
            .Put;

        if LResponse.StatusCode = 204 then
          memJSON.Lines.Add('Adicionado com sucesso')
        else
          memJSON.Lines.Add('Erro. Verifique!')
      end;
    end
  );
end;

procedure TFrmMaster.Button9Click(Sender: TObject);
var
  LJson     : TJSONValue;
  LResponse : IResponse;
  LMessage  : string;
begin
  LMessage := Format('Confirma remoção de aluno %s no cargo %s?', [DM.memMembersusername.AsString, DM.memRolesname.AsString]);
  TDialogService.MessageDialog(
    LMessage,
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbNo,
    0,
    procedure (const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        LResponse :=
          TRequest.New.BaseURL(Url_Base)
            .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
            .AddHeader('X-Audit-Log-Reason', edtReason.Text, [poDoNotEncode])
            .Resource(Format('guilds/%s/members/%s/roles/%s', [Guild_ID, edtMemberID.text, edtRoleID.Text]))
            .Delete;

        if LResponse.StatusCode = 204 then
          memJSON.Lines.Add('Removido com sucesso')
        else
          memJSON.Lines.Add('Erro. Verifique!')
      end;
    end
  );
end;

procedure TFrmMaster.edtPesqChannelChangeTracking(Sender: TObject);
begin
  DM.memChannels.Locate('name', edtPesqChannel.text, [loPartialKey, loCaseInsensitive])
end;

procedure TFrmMaster.edtPesqRoleChangeTracking(Sender: TObject);
begin
  DM.memRoles.Locate('name', edtPesqRole.text, [loPartialKey, loCaseInsensitive])
end;

function TFrmMaster.FormatDateTimeSelf(AValue: TJSONValue; AFieldName: string): TDateTime;
var
  LDateString : string;
  LAno        : Word;
  LMes        : Word;
  LDia        : Word;
  LHor        : Word;
  LMin        : Word;
  LSec        : Word;
  LValid      : TDateTime;
begin
  if not (AValue.FindValue(AFieldName) is TJSONNull) then
    Result := null
  else
  begin
    LDateString := AValue.GetValue<string>(AFieldName);
    if LDateString.Equals(EmptyStr) then
      Result := null
    else
    begin
      LAno   := StrToInt(Copy(LDateString, 1, 4));
      LMes   := StrToInt(Copy(LDateString, 6, 2));
      LDia   := StrToInt(Copy(LDateString, 9, 2));
      LHor   := StrToInt(Copy(LDateString, 12, 2));
      LMin   := StrToInt(Copy(LDateString, 15, 2));
      LSec   := StrToInt(Copy(LDateString, 18, 2));

      Result := EncodeDateTime(LAno, LMes, LDia, LHor, LMin, LSec, 0);
    end;
  end;
end;

procedure TFrmMaster.FormCreate(Sender: TObject);
begin
  TServerFormats.SetFormats;
end;

procedure TFrmMaster.FormShow(Sender: TObject);
begin
  LoadRoles;
end;

procedure TFrmMaster.gridChannelsCellClick(const Column: TColumn;
  const Row: Integer);
begin
  edtChannelID.Text := DM.memChannelsid.AsString;
end;

procedure TFrmMaster.gridMembersCellClick(const Column: TColumn;
  const Row: Integer);
begin
  edtMemberID.Text := DM.memMembersid.AsString;
end;

procedure TFrmMaster.gridRolesCellClick(const Column: TColumn;
  const Row: Integer);
begin
  edtRoleName.Text := DM.memRolesname.AsString;
  edtRoleID.Text := DM.memRolesid.AsString;
end;

procedure TFrmMaster.LoadChannels;
begin

end;

procedure TFrmMaster.LoadRoles;
var
  LJson     : TJSONValue;
  LResponse : IResponse;
  LJsonArray : TJSONArray;
  LValues    : TJSONValue;

  LID        : string;
  LName      : string;
begin
  LResponse :=
    TRequest.New.BaseURL(Url_Base)
      .AddHeader('Authorization', Format('Bot %s', [Authorization]), [poDoNotEncode])
      .Resource(Format('guilds/%s/roles', [Guild_ID]))
      .Get;

  LJson := TJSONObject.ParseJSONValue(LResponse.Content);
  LJsonArray := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;

  if not DM.memRoles.Active then
    DM.memRoles.Active := True;

  DM.memRoles.DisableControls;
  for LValues in LJsonArray do
  begin
    LID   := LValues.GetValue<string>('id');
    LName := LValues.GetValue<string>('name');

    if not (lstRolesExcludes.Items.IndexOf(LName) > -1) then
    begin
      DM.memRoles.Append;
      DM.memRolesid.AsString    := LID;
      DM.memRolesname.AsString  := LName;
      DM.memRoles.Post;
    end
    else
      continue;
  end;
  DM.memRoles.First;
  DM.memRoles.EnableControls;

  for var I : Integer := 0 to Pred(gridRoles.ColumnCount) do
    gridRoles.Columns[I].Width := 150;

  memJSON.Lines.Clear;
  memJSON.Lines.Add(TJson.Format(LJson));
end;

function TFrmMaster.RemoveParam(var AURL: string; AParam: string): string;
begin
  var LTemp : string := AURL.Remove(Pos(AParam, AURL)-2, Length('&'+AParam+'=%s'));
  Result := AURL;
end;


function TFrmMaster.TryReadDateTimeValue(AValue: TJSONValue; AFieldName: string): TDateTime;
var
  LDateString : string;
  LAno        : Word;
  LMes        : Word;
  LDia        : Word;
  LHor        : Word;
  LMin        : Word;
  LSec        : Word;
  LValid      : TDateTime;
begin
  Result := 0;
  if not (AValue.FindValue(AFieldName) is TJSONNull) then
  begin
    LDateString := AValue.GetValue<string>(AFieldName);
    if LDateString.Equals(EmptyStr) then
      Result := 0
    else
    begin
      LAno   := StrToInt(Copy(LDateString, 1, 4));
      LMes   := StrToInt(Copy(LDateString, 6, 2));
      LDia   := StrToInt(Copy(LDateString, 9, 2));
      LHor   := StrToInt(Copy(LDateString, 12, 2));
      LMin   := StrToInt(Copy(LDateString, 15, 2));
      LSec   := StrToInt(Copy(LDateString, 18, 2));

      Result := EncodeDateTime(LAno, LMes, LDia, LHor, LMin, LSec, 0);
    end;
  end;
end;

function TFrmMaster.TryReadFloatValue(AValue: TJSONValue; AFieldName: string): TDateTime;
var
  LTemp : string;
begin
  Result := 0;
  if not (AValue.FindValue(AFieldName) is TJSONNull) then
  begin
    LTemp := AValue.GetValue<string>(AFieldName);
    if LTemp.Equals(EmptyStr) then
      Result := 0
    else
    begin
      LTemp := StringReplace(LTemp, '.', ',', [rfReplaceAll]);
      try
        Result := StrToFloat(LTemp);
      except
        Result := 0;
      end;
    end;
  end;
end;

function TFrmMaster.TryReadIntegerValue(AValue: TJSONValue; AFieldName: string): Integer;
begin
  Result := 0;
  if not (AValue.FindValue(AFieldName) is TJSONNull) then
    Result := AValue.GetValue<integer>(AFieldName);
end;

{ TServerFormats }

class procedure TServerFormats.SetFormats;
begin
  FFormatSettings                       := TFormatSettings.Create;
  FFormatSettings.DateSeparator         := C_DateSeparator;
  FFormatSettings.ShortDateFormat       := C_ShortDateFormat;
  FFormatSettings.TimeSeparator         := C_TimeSeparator;
  FFormatSettings.ShortTimeFormat       := C_ShortTimeFormat;
  FFormatSettings.LongTimeFormat        := C_LongTimeFormat;
  FFormatSettings.ThousandSeparator     := C_ThousandSeparator;
  FFormatSettings.DecimalSeparator      := C_DecimalSeparator;
  FFormatSettings.LongDateFormat        := C_LongDateFormat;
end;

end.

