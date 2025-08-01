class RemoteConfigApiVersionsData {
  List<ApiVersionPlatformConfig>? android;
  List<ApiVersionPlatformConfig>? ios;

  RemoteConfigApiVersionsData({
    this.android,
    this.ios,
  });

  RemoteConfigApiVersionsData.fromJson(Map<String, dynamic> json) {
    if (json['android'] != null) {
      android = <ApiVersionPlatformConfig>[];
      json['android'].forEach((v) {
        android?.add(new ApiVersionPlatformConfig.fromJson(v));
      });
    }
    if (json['ios'] != null) {
      ios = <ApiVersionPlatformConfig>[];
      json['ios'].forEach((v) {
        ios?.add(new ApiVersionPlatformConfig.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['android'] = this.android?.map((v) => v.toJson()).toList();
    data['ios'] = this.ios?.map((v) => v.toJson()).toList();
    return data;
  }
}

class ApiVersionPlatformConfig {
  String? minVersion;
  String? maxVersion;
  String? baseUrl;
  String? baseUrlPhaseTwo;

  ApiVersionPlatformConfig({
    this.minVersion,
    this.maxVersion,
    this.baseUrl,
    this.baseUrlPhaseTwo,
  });

  ApiVersionPlatformConfig.fromJson(Map<String, dynamic> json) {
    minVersion = json['min_version'];
    maxVersion = json['max_version'];
    baseUrl = json['base_url'];
    baseUrlPhaseTwo = json['base_url_phase_two'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_version'] = this.minVersion;
    data['max_version'] = this.maxVersion;
    data['base_url'] = this.baseUrl;
    data['base_url_phase_two'] = this.baseUrlPhaseTwo;
    return data;
  }
}
