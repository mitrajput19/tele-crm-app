class CurrencyExchangeRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  String? exchangeCurrencyCode;

  CurrencyExchangeRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.exchangeCurrencyCode,
  });

  CurrencyExchangeRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    exchangeCurrencyCode = json['exchangeCurrencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['exchangeCurrencyCode'] = this.exchangeCurrencyCode;
    return data;
  }
}
