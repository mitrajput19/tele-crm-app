class BackgroundLocationRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  int? employeeLoginId;
  String? ipAddress;
  int? userDevice;
  List<BackgroundLocationLogs>? locationLogs;

  BackgroundLocationRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.employeeLoginId,
    this.ipAddress,
    this.userDevice,
    this.locationLogs,
  });

  BackgroundLocationRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    employeeLoginId = json['employee_login_id'];
    ipAddress = json['ip_address'];
    userDevice = json['user_device'];
    if (json['location_logs'] != null) {
      locationLogs = <BackgroundLocationLogs>[];
      json['location_logs'].forEach((v) {
        locationLogs!.add(new BackgroundLocationLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['employee_login_id'] = this.employeeLoginId;
    data['ip_address'] = this.ipAddress;
    data['user_device'] = this.userDevice;
    if (this.locationLogs != null) {
      data['location_logs'] = this.locationLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BackgroundLocationLogs {
  double? latitude;
  double? longitude;
  String? date;
  String? time;

  BackgroundLocationLogs({
    this.latitude,
    this.longitude,
    this.date,
    this.time,
  });

  BackgroundLocationLogs.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }

  static List<BackgroundLocationLogs> listFromJson(dynamic json) {
    List<BackgroundLocationLogs> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new BackgroundLocationLogs.fromJson(v));
      });
    }
    return list;
  }
}
