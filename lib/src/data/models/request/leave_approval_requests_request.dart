class LeaveApprovalRequestsRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? employeeLeaveApplicationId;
  String? adminRemark;
  List<LeaveApprovalRequestStatusDetails>? leavesArray;

  LeaveApprovalRequestsRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.employeeLeaveApplicationId,
    this.adminRemark,
    this.leavesArray,
  });

  LeaveApprovalRequestsRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    employeeLeaveApplicationId = json['employee_leave_application_id'];
    adminRemark = json['admin_remark'];
    if (json['leavesArray'] != null) {
      leavesArray = <LeaveApprovalRequestStatusDetails>[];
      json['leavesArray'].forEach((v) {
        leavesArray!.add(new LeaveApprovalRequestStatusDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['employee_leave_application_id'] = this.employeeLeaveApplicationId;
    data['admin_remark'] = this.adminRemark;
    if (this.leavesArray != null) {
      data['leavesArray'] = this.leavesArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  LeaveApprovalRequestsRequest copyWith({
    String? tenantCode,
    int? languageId,
    String? tenantCodeEncrypted,
    int? employeeId,
    String? ipAddress,
    int? employeeLeaveApplicationId,
    String? adminRemark,
    List<LeaveApprovalRequestStatusDetails>? leavesArray,
  }) {
    return LeaveApprovalRequestsRequest(
      tenantCode: tenantCode ?? this.tenantCode,
      languageId: languageId ?? this.languageId,
      tenantCodeEncrypted: tenantCodeEncrypted ?? this.tenantCodeEncrypted,
      employeeId: employeeId ?? this.employeeId,
      ipAddress: ipAddress ?? this.ipAddress,
      employeeLeaveApplicationId: employeeLeaveApplicationId ?? this.employeeLeaveApplicationId,
      adminRemark: adminRemark ?? this.adminRemark,
      leavesArray: leavesArray ?? this.leavesArray,
    );
  }
}

class LeaveApprovalRequestStatusDetails {
  int? employeeLeaveApplicationDetailId;
  int? leaveStatus;
  String? remark;

  LeaveApprovalRequestStatusDetails({
    this.employeeLeaveApplicationDetailId,
    this.leaveStatus,
    this.remark,
  });

  LeaveApprovalRequestStatusDetails.fromJson(Map<String, dynamic> json) {
    employeeLeaveApplicationDetailId = json['employeeLeaveApplicationDetailId'];
    leaveStatus = json['leaveStatus'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeLeaveApplicationDetailId'] = this.employeeLeaveApplicationDetailId;
    data['leaveStatus'] = this.leaveStatus;
    data['remark'] = this.remark;
    return data;
  }
}
