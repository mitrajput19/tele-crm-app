class RemoteConfigData {
  String? baseUrlAdmin;
  String? baseUrlMaster;
  String? apiKeyMaster;

  RemoteConfigData({
    this.baseUrlAdmin,
    this.baseUrlMaster,
    this.apiKeyMaster,
  });

  RemoteConfigData.fromJson(Map<String, dynamic> json) {
    baseUrlAdmin = json['base_url_admin'];
    baseUrlMaster = json['base_url_master'];
    apiKeyMaster = json['api_key_master'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_url_admin'] = this.baseUrlAdmin;
    data['base_url_master'] = this.baseUrlMaster;
    data['api_key_master'] = this.apiKeyMaster;
    return data;
  }
}
