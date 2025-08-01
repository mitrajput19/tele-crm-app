class LoginLogDetails {
  int? employeeLoginLogId;
  String? browserDeviceDetails;
  String? ipAddress;
  dynamic latitude;
  dynamic longitude;
  String? location;
  String? locationUrl;
  String? createdAt;

  LoginLogDetails({
    this.employeeLoginLogId,
    this.browserDeviceDetails,
    this.ipAddress,
    this.latitude,
    this.longitude,
    this.location,
    this.locationUrl,
    this.createdAt,
  });

  LoginLogDetails.fromJson(Map<String, dynamic> json) {
    employeeLoginLogId = json['employee_login_log_id'];
    browserDeviceDetails = json['browser_device_details'];
    ipAddress = json['ip_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    locationUrl = json['location_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_login_log_id'] = this.employeeLoginLogId;
    data['browser_device_details'] = this.browserDeviceDetails;
    data['ip_address'] = this.ipAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['location_url'] = this.locationUrl;
    data['created_at'] = this.createdAt;
    return data;
  }

  static List<LoginLogDetails> listFromJson(dynamic json) {
    List<LoginLogDetails> list = [];
    if (json['details']['account_logs']['data'] != null) {
      json['details']['account_logs']['data'].forEach((v) {
        list.add(new LoginLogDetails.fromJson(v));
      });
    }
    return list;
  }
}
