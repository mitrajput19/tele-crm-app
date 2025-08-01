class EmployeeShiftDetailsRequest {
  int? languageId;
  String? tenantCode;
  String? tenantCodeEncrypted;
  int? employeeShiftDetailId;
  String? ipAddress;

  EmployeeShiftDetailsRequest({
    this.languageId,
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.employeeShiftDetailId,
    this.ipAddress,
  });

  EmployeeShiftDetailsRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeShiftDetailId = json['employee_shift_detail_id'];
    ipAddress = json['ip_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_shift_detail_id'] = this.employeeShiftDetailId;
    data['ip_address'] = this.ipAddress;
    return data;
  }
}
