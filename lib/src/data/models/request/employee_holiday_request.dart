class EmployeeHolidayRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? companyId;
  String? employeeHolidayDate;
  String? employeeHolidayReason;

  EmployeeHolidayRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.companyId,
    this.employeeHolidayDate,
    this.employeeHolidayReason,
  });

  EmployeeHolidayRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    companyId = json['company_id'];
    employeeHolidayDate = json['employee_holiday_date'];
    employeeHolidayReason = json['employee_holiday_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['company_id'] = this.companyId;
    data['employee_holiday_date'] = this.employeeHolidayDate;
    data['employee_holiday_reason'] = this.employeeHolidayReason;
    return data;
  }

  EmployeeHolidayRequest copyWith({
    String? tenantCode,
    int? languageId,
    String? tenantCodeEncrypted,
    int? employeeId,
    String? ipAddress,
    int? companyId,
    String? employeeHolidayDate,
    String? employeeHolidayReason,
  }) {
    return EmployeeHolidayRequest(
      tenantCode: tenantCode ?? this.tenantCode,
      languageId: languageId ?? this.languageId,
      tenantCodeEncrypted: tenantCodeEncrypted ?? this.tenantCodeEncrypted,
      employeeId: employeeId ?? this.employeeId,
      ipAddress: ipAddress ?? this.ipAddress,
      companyId: companyId ?? this.companyId,
      employeeHolidayDate: employeeHolidayDate ?? this.employeeHolidayDate,
      employeeHolidayReason: employeeHolidayReason ?? this.employeeHolidayReason,
    );
  }
}
