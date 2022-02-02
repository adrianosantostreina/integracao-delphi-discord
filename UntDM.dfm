object DM: TDM
  Height = 466
  Width = 724
  PixelsPerInch = 96
  object memChannels: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 24
    object memChannelsid: TStringField
      FieldName = 'id'
      Size = 50
    end
    object memChannelsname: TStringField
      FieldName = 'name'
      Size = 255
    end
    object memChannelstype: TIntegerField
      FieldName = 'type'
    end
  end
  object memRoles: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 24
    object memRolesid: TStringField
      FieldName = 'id'
      Size = 50
    end
    object memRolesname: TStringField
      FieldName = 'name'
      Size = 200
    end
  end
  object memMembers: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 272
    Top = 24
    object memMembersid: TStringField
      FieldName = 'id'
      Size = 50
    end
    object memMembersnick: TStringField
      FieldName = 'nick'
      Size = 200
    end
    object memMembersusername: TStringField
      FieldName = 'username'
      Size = 200
    end
    object memMembersdiscrimitator: TStringField
      FieldName = 'discrimitator'
      Size = 10
    end
  end
  object memGoogle: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 384
    Top = 24
    object memGooglenome: TStringField
      FieldName = 'nome'
      Size = 200
    end
    object memGooglecelular: TStringField
      FieldName = 'celular'
      Size = 200
    end
    object memGoogleemail_nutror: TStringField
      FieldName = 'email_nutror'
      Size = 200
    end
    object memGoogleemail_eduzz: TStringField
      FieldName = 'email_eduzz'
      Size = 200
    end
    object memGoogleuser_discord: TStringField
      FieldName = 'user_discord'
      Size = 200
    end
    object memGoogleliberado: TStringField
      FieldName = 'liberado'
      Size = 10
    end
    object memGoogleobs: TStringField
      FieldName = 'obs'
      Size = 200
    end
  end
  object memSalesList: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 112
    object memSalesListsale_id: TIntegerField
      FieldName = 'sale_id'
    end
    object memSalesListcontract_id: TIntegerField
      FieldName = 'contract_id'
    end
    object memSalesListdue_date: TDateTimeField
      FieldName = 'due_date'
    end
    object memSalesListdate_create: TDateTimeField
      FieldName = 'date_create'
    end
    object memSalesListdate_payment: TDateTimeField
      FieldName = 'date_payment'
    end
    object memSalesListdate_update: TDateTimeField
      FieldName = 'date_update'
    end
    object memSalesListsale_status: TStringField
      FieldName = 'sale_status'
      Size = 4
    end
    object memSalesListsale_status_name: TStringField
      FieldName = 'sale_status_name'
      Size = 40
    end
    object memSalesListsale_item_discount: TFloatField
      FieldName = 'sale_item_discount'
    end
    object memSalesListsale_recuperacao: TFloatField
      FieldName = 'sale_recuperacao'
    end
    object memSalesListsale_amount_win: TFloatField
      FieldName = 'sale_amount_win'
    end
    object memSalesListsale_net_gain: TFloatField
      FieldName = 'sale_net_gain'
    end
    object memSalesListsale_coop: TFloatField
      FieldName = 'sale_coop'
    end
    object memSalesListsale_partner: TFloatField
      FieldName = 'sale_partner'
    end
    object memSalesListsale_fee: TFloatField
      FieldName = 'sale_fee'
    end
    object memSalesListsale_others: TFloatField
      FieldName = 'sale_others'
    end
    object memSalesListsale_total: TFloatField
      FieldName = 'sale_total'
    end
    object memSalesListsale_payment_method: TStringField
      FieldName = 'sale_payment_method'
    end
    object memSalesListclient_id: TIntegerField
      FieldName = 'client_id'
    end
    object memSalesListclient_name: TStringField
      FieldName = 'client_name'
      Size = 200
    end
    object memSalesListclient_email: TStringField
      FieldName = 'client_email'
      Size = 200
    end
    object memSalesListclient_document: TStringField
      FieldName = 'client_document'
      Size = 50
    end
    object memSalesListclient_cel: TStringField
      FieldName = 'client_cel'
    end
    object memSalesListutm_source: TStringField
      FieldName = 'utm_source'
      Size = 40
    end
    object memSalesListutm_campaign: TStringField
      FieldName = 'utm_campaign'
      Size = 40
    end
    object memSalesListutm_medium: TStringField
      FieldName = 'utm_medium'
      Size = 40
    end
    object memSalesListcontent_id: TIntegerField
      FieldName = 'content_id'
    end
    object memSalesListcontent_title: TStringField
      FieldName = 'content_title'
      Size = 100
    end
    object memSalesListinstallments: TIntegerField
      FieldName = 'installments'
    end
  end
end
