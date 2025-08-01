class HolidayApprovalRequestsRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? employeeHolidayId;
  int? holidayAction;
  String? adminRemark;

  HolidayApprovalRequestsRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.employeeHolidayId,
    this.holidayAction,
    this.adminRemark,
  });

  HolidayApprovalRequestsRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    employeeHolidayId = json['employee_holiday_id'];
    holidayAction = json['holiday_action'];
    adminRemark = json['admin_remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['employee_holiday_id'] = this.employeeHolidayId;
    data['holiday_action'] = this.holidayAction;
    data['admin_remark'] = this.adminRemark;
    return data;
  }

  HolidayApprovalRequestsRequest copyWith({
    String? tenantCode,
    int? languageId,
    String? tenantCodeEncrypted,
    int? employeeId,
    String? ipAddress,
    int? employeeHolidayId,
    int? holidayAction,
    String? adminRemark,
  }) {
    return HolidayApprovalRequestsRequest(
      tenantCode: tenantCode ?? this.tenantCode,
      languageId: languageId ?? this.languageId,
      tenantCodeEncrypted: tenantCodeEncrypted ?? this.tenantCodeEncrypted,
      employeeId: employeeId ?? this.employeeId,
      ipAddress: ipAddress ?? this.ipAddress,
      employeeHolidayId: employeeHolidayId ?? this.employeeHolidayId,
      holidayAction: holidayAction ?? this.holidayAction,
      adminRemark: adminRemark ?? this.adminRemark,
    );
  }
}
