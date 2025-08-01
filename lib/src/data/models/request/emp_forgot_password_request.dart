class EmpForgotPasswordRequest {
  int? languageId;
  String? tenantCode;
  String? tvUsername;
  String? ipAddress;
  int? userDevice;
  double? latitude;
  double? longitude;
  int? type;

  EmpForgotPasswordRequest({
    this.languageId,
    this.tenantCode,
    this.tvUsername,
    this.ipAddress,
    this.userDevice,
    this.latitude,
    this.longitude,
    this.type,
  });

  EmpForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tvUsername = json['tv_username'];
    ipAddress = json['ip_address'];
    userDevice = json['user_device'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tv_username'] = this.tvUsername;
    data['ip_address'] = this.ipAddress;
    data['user_device'] = this.userDevice;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['type'] = this.type;
    return data;
  }
}
