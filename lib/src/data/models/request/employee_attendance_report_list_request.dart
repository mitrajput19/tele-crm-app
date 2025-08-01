class EmployeeAttendanceReportListRequest {
  int? languageId;
  String? tenantCode;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? startDate;
  String? endDate;
  String? ipAddress;

  EmployeeAttendanceReportListRequest({
    this.languageId,
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.startDate,
    this.endDate,
    this.ipAddress,
  });

  EmployeeAttendanceReportListRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    ipAddress = json['ip_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['ip_address'] = this.ipAddress;
    return data;
  }

  EmployeeAttendanceReportListRequest copyWith({
    int? languageId,
    String? tenantCode,
    String? tenantCodeEncrypted,
    int? employeeId,
    String? startDate,
    String? endDate,
    String? ipAddress,
  }) {
    return EmployeeAttendanceReportListRequest(
      languageId: languageId ?? this.languageId,
      tenantCode: tenantCode ?? this.tenantCode,
      tenantCodeEncrypted: tenantCodeEncrypted ?? this.tenantCodeEncrypted,
      employeeId: employeeId ?? this.employeeId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      ipAddress: ipAddress ?? this.ipAddress,
    );
  }
}
