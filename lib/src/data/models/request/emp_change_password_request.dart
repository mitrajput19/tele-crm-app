class EmpChangePasswordRequest {
  int? languageId;
  String? tenantCode;
  String? tenantCodeEncrypted;
  int? employeeId;
  int? employeeLoginId;
  String? ipAddress;
  int? userDevice;
  double? latitude;
  double? longitude;
  int? type;
  String? currentPassword;

  EmpChangePasswordRequest({
    this.languageId,
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.employeeLoginId,
    this.ipAddress,
    this.userDevice,
    this.latitude,
    this.longitude,
    this.type,
    this.currentPassword,
  });

  EmpChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    employeeLoginId = json['employee_login_id'];
    ipAddress = json['ip_address'];
    userDevice = json['user_device'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    currentPassword = json['current_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['employee_login_id'] = this.employeeLoginId;
    data['ip_address'] = this.ipAddress;
    data['user_device'] = this.userDevice;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['type'] = this.type;
    data['current_password'] = this.currentPassword;
    return data;
  }
}
