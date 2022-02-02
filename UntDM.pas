unit UntDM;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    memChannels: TFDMemTable;
    memRoles: TFDMemTable;
    memChannelsid: TStringField;
    memChannelsname: TStringField;
    memChannelstype: TIntegerField;
    memRolesid: TStringField;
    memRolesname: TStringField;
    memMembers: TFDMemTable;
    memMembersid: TStringField;
    memMembersnick: TStringField;
    memMembersusername: TStringField;
    memGoogle: TFDMemTable;
    memGooglenome: TStringField;
    memGooglecelular: TStringField;
    memGoogleemail_nutror: TStringField;
    memGoogleemail_eduzz: TStringField;
    memGoogleuser_discord: TStringField;
    memGoogleliberado: TStringField;
    memGoogleobs: TStringField;
    memMembersdiscrimitator: TStringField;
    memSalesList: TFDMemTable;
    memSalesListsale_id: TIntegerField;
    memSalesListcontract_id: TIntegerField;
    memSalesListdue_date: TDateTimeField;
    memSalesListdate_create: TDateTimeField;
    memSalesListdate_payment: TDateTimeField;
    memSalesListdate_update: TDateTimeField;
    memSalesListsale_status: TStringField;
    memSalesListsale_amount_win: TFloatField;
    memSalesListsale_net_gain: TFloatField;
    memSalesListsale_payment_method: TStringField;
    memSalesListclient_id: TIntegerField;
    memSalesListclient_name: TStringField;
    memSalesListclient_email: TStringField;
    memSalesListclient_document: TStringField;
    memSalesListclient_cel: TStringField;
    memSalesListutm_source: TStringField;
    memSalesListutm_campaign: TStringField;
    memSalesListutm_medium: TStringField;
    memSalesListcontent_id: TIntegerField;
    memSalesListcontent_title: TStringField;
    memSalesListsale_total: TFloatField;
    memSalesListsale_coop: TFloatField;
    memSalesListsale_partner: TFloatField;
    memSalesListsale_fee: TFloatField;
    memSalesListsale_recuperacao: TFloatField;
    memSalesListsale_item_discount: TFloatField;
    memSalesListsale_status_name: TStringField;
    memSalesListsale_others: TFloatField;
    memSalesListinstallments: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
