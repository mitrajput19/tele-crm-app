class EmployeeApplyForLeavesRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? companyId;
  String? leaveFromDate;
  String? leaveToDate;
  List<LeavesArray>? leavesArray;
  int? leaveReasonId;
  String? leaveReasonDetails;

  EmployeeApplyForLeavesRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.companyId,
    this.leaveFromDate,
    this.leaveToDate,
    this.leavesArray,
    this.leaveReasonId,
    this.leaveReasonDetails,
  });

  EmployeeApplyForLeavesRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    companyId = json['company_id'];
    leaveFromDate = json['leave_from_date'];
    leaveToDate = json['leave_to_date'];
    if (json['leavesArray'] != null) {
      leavesArray = <LeavesArray>[];
      json['leavesArray'].forEach((v) {
        leavesArray!.add(new LeavesArray.fromJson(v));
      });
    }
    leaveReasonId = json['leave_reason_id'];
    leaveReasonDetails = json['leave_reason_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['company_id'] = this.companyId;
    data['leave_from_date'] = this.leaveFromDate;
    data['leave_to_date'] = this.leaveToDate;
    if (this.leavesArray != null) {
      data['leavesArray'] = this.leavesArray!.map((v) => v.toJson()).toList();
    }
    data['leave_reason_id'] = this.leaveReasonId;
    data['leave_reason_details'] = this.leaveReasonDetails;
    return data;
  }
}

class LeavesArray {
  String? leaveDate;
  String? leaveType;
  String? startTime;
  String? endTime;

  LeavesArray({
    this.leaveDate,
    this.leaveType,
    this.startTime,
    this.endTime,
  });

  LeavesArray.fromJson(Map<String, dynamic> json) {
    leaveDate = json['leaveDate'];
    leaveType = json['leaveType'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveDate'] = this.leaveDate;
    data['leaveType'] = this.leaveType;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}
