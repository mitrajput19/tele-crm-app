class PickupOpenShiftsRequest {
  int? languageId;
  String? tenantCode;
  String? tenantCodeEncrypted;
  String? ipAddress;
  int? employeeId;
  int? employeeShiftDetailId;

  PickupOpenShiftsRequest({
    this.languageId,
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.ipAddress,
    this.employeeId,
    this.employeeShiftDetailId,
  });

  PickupOpenShiftsRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    ipAddress = json['ip_address'];
    employeeId = json['employee_id'];
    employeeShiftDetailId = json['employee_shift_detail_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['ip_address'] = this.ipAddress;
    data['employee_id'] = this.employeeId;
    data['employee_shift_detail_id'] = this.employeeShiftDetailId;
    return data;
  }
}
