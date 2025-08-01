class CurrencyMasterDetails {
  int? countryCurrencyId;
  String? countryName;
  String? iso;
  String? iso3;
  String? dialExtension;
  String? currencyCode;
  String? currencySymbol;
  String? currencyName;

  CurrencyMasterDetails({
    this.countryCurrencyId,
    this.countryName,
    this.iso,
    this.iso3,
    this.dialExtension,
    this.currencyCode,
    this.currencySymbol,
    this.currencyName,
  });

  CurrencyMasterDetails.fromJson(Map<String, dynamic> json) {
    countryCurrencyId = json['country_currency_id'];
    countryName = json['country_name'];
    iso = json['iso'];
    iso3 = json['iso3'];
    dialExtension = json['dial_extension'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyName = json['currency_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_currency_id'] = this.countryCurrencyId;
    data['country_name'] = this.countryName;
    data['iso'] = this.iso;
    data['iso3'] = this.iso3;
    data['dial_extension'] = this.dialExtension;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_name'] = this.currencyName;
    return data;
  }

  static List<CurrencyMasterDetails> listFromJson(dynamic json) {
    List<CurrencyMasterDetails> list = [];
    if (json['country_currency_master'] != null) {
      json['country_currency_master'].forEach((v) {
        list.add(new CurrencyMasterDetails.fromJson(v));
      });
    }
    return list;
  }
}
