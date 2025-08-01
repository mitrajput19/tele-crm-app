class EmployeeShiftsListRequest {
  int? languageId;
  String? tenantCode;
  String? tenantCodeEncrypted;
  int? employeeId;
  int? companyId;
  String? ipAddress;
  String? startDate;
  String? endDate;

  EmployeeShiftsListRequest({
    this.languageId,
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.companyId,
    this.ipAddress,
    this.startDate,
    this.endDate,
  });

  EmployeeShiftsListRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    companyId = json['company_id'];
    ipAddress = json['ip_address'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['company_id'] = this.companyId;
    data['ip_address'] = this.ipAddress;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
