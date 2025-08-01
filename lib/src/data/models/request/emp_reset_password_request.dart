class EmpResetPasswordRequest {
  int? languageId;
  String? tenantCode;
  String? ipAddress;
  String? verifyEmailAddress;
  int? verifyEmployeeId;
  int? forgotPasswordId;
  String? fpOtp;
  String? fpPassword;
  String? fpcPassword;

  EmpResetPasswordRequest({
    this.languageId,
    this.tenantCode,
    this.ipAddress,
    this.verifyEmailAddress,
    this.verifyEmployeeId,
    this.forgotPasswordId,
    this.fpOtp,
    this.fpPassword,
    this.fpcPassword,
  });

  EmpResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    ipAddress = json['ip_address'];
    verifyEmailAddress = json['verify_email_address'];
    verifyEmployeeId = json['verify_employee_id'];
    forgotPasswordId = json['forgot_password_id'];
    fpOtp = json['fp_otp'];
    fpPassword = json['fp_password'];
    fpcPassword = json['fpc_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['ip_address'] = this.ipAddress;
    data['verify_email_address'] = this.verifyEmailAddress;
    data['verify_employee_id'] = this.verifyEmployeeId;
    data['forgot_password_id'] = this.forgotPasswordId;
    data['fp_otp'] = this.fpOtp;
    data['fp_password'] = this.fpPassword;
    data['fpc_password'] = this.fpcPassword;
    return data;
  }
}
