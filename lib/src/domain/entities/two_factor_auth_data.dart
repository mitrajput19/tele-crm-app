class TwoFactorAuthData {
  String? employeeEmail;
  String? employeeTenantCode;
  int? employeeId;
  int? employee2faLogId;

  TwoFactorAuthData({
    this.employeeEmail,
    this.employeeTenantCode,
    this.employeeId,
    this.employee2faLogId,
  });

  TwoFactorAuthData.fromJson(Map<String, dynamic> json) {
    employeeEmail = json['employee_email'];
    employeeTenantCode = json['employee_tenant_code'];
    employeeId = json['employee_id'];
    employee2faLogId = json['employee_2fa_log_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_email'] = this.employeeEmail;
    data['employee_tenant_code'] = this.employeeTenantCode;
    data['employee_id'] = this.employeeId;
    data['employee_2fa_log_id'] = this.employee2faLogId;
    return data;
  }

  TwoFactorAuthData copyWith({
    String? employeeEmail,
    String? employeeTenantCode,
    int? employeeId,
    int? employee2faLogId,
  }) {
    return TwoFactorAuthData(
      employeeEmail: employeeEmail ?? this.employeeEmail,
      employeeTenantCode: employeeTenantCode ?? this.employeeTenantCode,
      employeeId: employeeId ?? this.employeeId,
      employee2faLogId: employee2faLogId ?? this.employee2faLogId,
    );
  }
}
