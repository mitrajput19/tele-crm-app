class EmployeeShiftTimeKeepingRequest {
  int? languageId;
  String? tenantCode;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  double? latitude;
  double? longitude;
  int? employeeShiftDetailId;
  String? eventType;
  String? comments;

  EmployeeShiftTimeKeepingRequest({
    this.languageId,
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.latitude,
    this.longitude,
    this.employeeShiftDetailId,
    this.eventType,
    this.comments,
  });

  EmployeeShiftTimeKeepingRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    employeeShiftDetailId = json['employee_shift_detail_id'];
    eventType = json['event_type'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['employee_shift_detail_id'] = this.employeeShiftDetailId;
    data['event_type'] = this.eventType;
    data['comments'] = this.comments;
    return data;
  }

  EmployeeShiftTimeKeepingRequest copyWith({
    int? languageId,
    String? tenantCode,
    String? tenantCodeEncrypted,
    int? employeeId,
    String? ipAddress,
    double? latitude,
    double? longitude,
    int? employeeShiftDetailId,
    String? eventType,
    String? comments,
  }) {
    return EmployeeShiftTimeKeepingRequest(
      languageId: languageId ?? this.languageId,
      tenantCode: tenantCode ?? this.tenantCode,
      tenantCodeEncrypted: tenantCodeEncrypted ?? this.tenantCodeEncrypted,
      employeeId: employeeId ?? this.employeeId,
      ipAddress: ipAddress ?? this.ipAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      employeeShiftDetailId: employeeShiftDetailId ?? this.employeeShiftDetailId,
      eventType: eventType ?? this.eventType,
      comments: comments ?? this.comments,
    );
  }
}
