class CurrencyExchangeDetails {
  int? currencyExchangeRatesId;
  String? currencyCode;
  num? rate;
  String? lastUpdatedAt;

  CurrencyExchangeDetails({
    this.currencyExchangeRatesId,
    this.currencyCode,
    this.rate,
    this.lastUpdatedAt,
  });

  CurrencyExchangeDetails.fromJson(Map<String, dynamic> json) {
    currencyExchangeRatesId = json['currency_exchange_rates_id'];
    currencyCode = json['currency_code'];
    rate = json['rate'];
    lastUpdatedAt = json['last_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_exchange_rates_id'] = this.currencyExchangeRatesId;
    data['currency_code'] = this.currencyCode;
    data['rate'] = this.rate;
    data['last_updated_at'] = this.lastUpdatedAt;
    return data;
  }

  static List<CurrencyExchangeDetails> listFromJson(dynamic json) {
    List<CurrencyExchangeDetails> list = [];
    if (json['details']['exchange_list'] != null) {
      json['details']['exchange_list'].forEach((v) {
        list.add(new CurrencyExchangeDetails.fromJson(v));
      });
    }
    return list;
  }
}
