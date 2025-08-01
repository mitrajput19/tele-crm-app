class LeaveDetails {
  int? employeeLeaveId;
  int? employeeShiftLeaveDetailId;
  String? leaveDate;
  int? isHalfday;
  String? startTime;
  String? endTime;
  String? leaveReasonType;
  String? leaveReasonDetails;
  String? adminRemark;
  int? leaveStatusId;
  String? leaveStatusType;

  LeaveDetails({
    this.employeeLeaveId,
    this.employeeShiftLeaveDetailId,
    this.leaveDate,
    this.isHalfday,
    this.startTime,
    this.endTime,
    this.leaveReasonType,
    this.leaveReasonDetails,
    this.adminRemark,
    this.leaveStatusId,
    this.leaveStatusType,
  });

  LeaveDetails.fromJson(Map<String, dynamic> json) {
    employeeLeaveId = json['employee_leave_id'];
    employeeShiftLeaveDetailId = json['employee_shift_leave_detail_id'];
    leaveDate = json['leave_date'];
    isHalfday = json['is_halfday'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    leaveReasonType = json['leave_reason_type'];
    leaveReasonDetails = json['leave_reason_details'];
    adminRemark = json['admin_remark'];
    leaveStatusId = json['leave_status_id'];
    leaveStatusType = json['leave_status_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_leave_id'] = this.employeeLeaveId;
    data['employee_shift_leave_detail_id'] = this.employeeShiftLeaveDetailId;
    data['leave_date'] = this.leaveDate;
    data['is_halfday'] = this.isHalfday;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['leave_reason_type'] = this.leaveReasonType;
    data['leave_reason_details'] = this.leaveReasonDetails;
    data['admin_remark'] = this.adminRemark;
    data['leave_status_id'] = this.leaveStatusId;
    data['leave_status_type'] = this.leaveStatusType;
    return data;
  }

  static List<LeaveDetails> listFromJson(dynamic json) {
    List<LeaveDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new LeaveDetails.fromJson(v));
      });
    }
    return list;
  }
}
