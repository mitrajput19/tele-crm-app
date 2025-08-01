class TwoFactorAuthRequest {
  int? languageId;
  String? tenantCode;
  String? verifyEmailAddress;
  int? verifyEmployeeId;
  int? employee2faLogId;
  String? fpOtp;
  String? ipAddress;
  int? userDevice;
  double? latitude;
  double? longitude;
  String? deviceInfo;

  TwoFactorAuthRequest({
    this.languageId,
    this.tenantCode,
    this.verifyEmailAddress,
    this.verifyEmployeeId,
    this.employee2faLogId,
    this.fpOtp,
    this.ipAddress,
    this.userDevice,
    this.latitude,
    this.longitude,
    this.deviceInfo,
  });

  TwoFactorAuthRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    verifyEmailAddress = json['verify_email_address'];
    verifyEmployeeId = json['verify_employee_id'];
    employee2faLogId = json['employee_2fa_log_id'];
    fpOtp = json['fp_otp'];
    ipAddress = json['ip_address'];
    userDevice = json['user_device'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deviceInfo = json['device_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['verify_email_address'] = this.verifyEmailAddress;
    data['verify_employee_id'] = this.verifyEmployeeId;
    data['employee_2fa_log_id'] = this.employee2faLogId;
    data['fp_otp'] = this.fpOtp;
    data['ip_address'] = this.ipAddress;
    data['user_device'] = this.userDevice;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['device_info'] = this.deviceInfo;
    return data;
  }
}
