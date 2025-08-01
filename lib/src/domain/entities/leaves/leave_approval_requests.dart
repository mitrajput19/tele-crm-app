class LeaveApprovalRequests {
  int? employeeLeaveApplicationId;
  String? employeeCard;
  String? requestDate;
  String? leaveDateFrom;
  String? leaveDateFromDisplay;
  String? leaveDateTo;
  String? leaveDateToDisplay;
  int? leaveReasonId;
  String? leaveReasonName;
  String? leaveReasonDetails;
  String? adminRemark;
  int? isCancellationRequested;
  String? isCancellationRequestedDisplay;
  String? isCancellationRequestedBgColor;
  String? isCancellationRequestedTextColor;
  int? leaveOuterStatusId;
  String? leaveOuterStatus;
  String? leaveOuterStatusBgColor;
  String? leaveOuterStatusTextColor;
  List<LeaveApprovalDetails>? leaveDetails;
  String? actionTakenByEmployeeCard;
  String? actionTakenAt;
  String? statusDisplayHtml;
  String? employeeFullname;
  String? actionTakenByEmployeeFullname;

  LeaveApprovalRequests({
    this.employeeLeaveApplicationId,
    this.employeeCard,
    this.requestDate,
    this.leaveDateFrom,
    this.leaveDateFromDisplay,
    this.leaveDateTo,
    this.leaveDateToDisplay,
    this.leaveReasonId,
    this.leaveReasonName,
    this.leaveReasonDetails,
    this.adminRemark,
    this.isCancellationRequested,
    this.isCancellationRequestedDisplay,
    this.isCancellationRequestedBgColor,
    this.isCancellationRequestedTextColor,
    this.leaveOuterStatusId,
    this.leaveOuterStatus,
    this.leaveOuterStatusBgColor,
    this.leaveOuterStatusTextColor,
    this.leaveDetails,
    this.actionTakenByEmployeeCard,
    this.actionTakenAt,
    this.statusDisplayHtml,
    this.employeeFullname,
    this.actionTakenByEmployeeFullname,
  });

  LeaveApprovalRequests.fromJson(Map<String, dynamic> json) {
    employeeLeaveApplicationId = json['employee_leave_application_id'];
    employeeCard = json['employee_card'];
    requestDate = json['request_date'];
    leaveDateFrom = json['leave_date_from'];
    leaveDateFromDisplay = json['leave_date_from_display'];
    leaveDateTo = json['leave_date_to'];
    leaveDateToDisplay = json['leave_date_to_display'];
    leaveReasonId = json['leave_reason_id'];
    leaveReasonName = json['leave_reason_name'];
    leaveReasonDetails = json['leave_reason_details'];
    adminRemark = json['admin_remark'];
    isCancellationRequested = json['is_cancellation_requested'];
    isCancellationRequestedDisplay = json['is_cancellation_requested_display'];
    isCancellationRequestedBgColor = json['is_cancellation_requested_bg_color'];
    isCancellationRequestedTextColor = json['is_cancellation_requested_text_color'];
    leaveOuterStatusId = json['leave_outer_status_id'];
    leaveOuterStatus = json['leave_outer_status'];
    leaveOuterStatusBgColor = json['leave_outer_status_bg_color'];
    leaveOuterStatusTextColor = json['leave_outer_status_text_color'];
    if (json['leave_details'] != null) {
      leaveDetails = <LeaveApprovalDetails>[];
      json['leave_details'].forEach((v) {
        leaveDetails!.add(new LeaveApprovalDetails.fromJson(v));
      });
    }
    actionTakenByEmployeeCard = json['action_taken_by_employee_card'];
    actionTakenAt = json['action_taken_at'];
    statusDisplayHtml = json['status_display_html'];
    employeeFullname = json['employee_fullname'];
    actionTakenByEmployeeFullname = json['action_taken_by_employee_fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_leave_application_id'] = this.employeeLeaveApplicationId;
    data['employee_card'] = this.employeeCard;
    data['request_date'] = this.requestDate;
    data['leave_date_from'] = this.leaveDateFrom;
    data['leave_date_from_display'] = this.leaveDateFromDisplay;
    data['leave_date_to'] = this.leaveDateTo;
    data['leave_date_to_display'] = this.leaveDateToDisplay;
    data['leave_reason_id'] = this.leaveReasonId;
    data['leave_reason_name'] = this.leaveReasonName;
    data['leave_reason_details'] = this.leaveReasonDetails;
    data['admin_remark'] = this.adminRemark;
    data['is_cancellation_requested'] = this.isCancellationRequested;
    data['is_cancellation_requested_display'] = this.isCancellationRequestedDisplay;
    data['is_cancellation_requested_bg_color'] = this.isCancellationRequestedBgColor;
    data['is_cancellation_requested_text_color'] = this.isCancellationRequestedTextColor;
    data['leave_outer_status_id'] = this.leaveOuterStatusId;
    data['leave_outer_status'] = this.leaveOuterStatus;
    data['leave_outer_status_bg_color'] = this.leaveOuterStatusBgColor;
    data['leave_outer_status_text_color'] = this.leaveOuterStatusTextColor;
    if (this.leaveDetails != null) {
      data['leave_details'] = this.leaveDetails!.map((v) => v.toJson()).toList();
    }
    data['action_taken_by_employee_card'] = this.actionTakenByEmployeeCard;
    data['action_taken_at'] = this.actionTakenAt;
    data['status_display_html'] = this.statusDisplayHtml;
    data['employee_fullname'] = this.employeeFullname;
    data['action_taken_by_employee_fullname'] = this.actionTakenByEmployeeFullname;
    return data;
  }

  static List<LeaveApprovalRequests> listFromJson(dynamic json) {
    List<LeaveApprovalRequests> list = [];
    if (json['details']['leave_approval_requests'] != null) {
      json['details']['leave_approval_requests'].forEach((v) {
        list.add(new LeaveApprovalRequests.fromJson(v));
      });
    }
    return list;
  }
}

class LeaveApprovalDetails {
  int? employeeLeaveApplicationDetailId;
  String? leaveDate;
  String? leaveDateDisplay;
  int? isHalfday;
  String? halfFullDayDisplay;
  String? startTime;
  String? startTimeDisplay;
  String? endTime;
  String? endTimeDisplay;
  String? typeOfLeave;
  String? typeOfLeaveDisplay;
  String? typeOfLeaveBgColor;
  String? typeOfLeaveTextColor;
  int? leaveStatusId;
  String? leaveStatusDisplay;
  String? leaveStatusBgColor;
  String? leaveStatusTextColor;
  String? typeOfLeaveStatusDisplayHtml;
  String? leaveStatusDisplayHtml;
  String? adminRemark;

  LeaveApprovalDetails({
    this.employeeLeaveApplicationDetailId,
    this.leaveDate,
    this.leaveDateDisplay,
    this.isHalfday,
    this.halfFullDayDisplay,
    this.startTime,
    this.startTimeDisplay,
    this.endTime,
    this.endTimeDisplay,
    this.typeOfLeave,
    this.typeOfLeaveDisplay,
    this.typeOfLeaveBgColor,
    this.typeOfLeaveTextColor,
    this.leaveStatusId,
    this.leaveStatusDisplay,
    this.leaveStatusBgColor,
    this.leaveStatusTextColor,
    this.typeOfLeaveStatusDisplayHtml,
    this.leaveStatusDisplayHtml,
    this.adminRemark,
  });

  LeaveApprovalDetails.fromJson(Map<String, dynamic> json) {
    employeeLeaveApplicationDetailId = json['employee_leave_application_detail_id'];
    leaveDate = json['leave_date'];
    leaveDateDisplay = json['leave_date_display'];
    isHalfday = json['is_halfday'];
    halfFullDayDisplay = json['half_full_day_display'];
    startTime = json['start_time'];
    startTimeDisplay = json['start_time_display'];
    endTime = json['end_time'];
    endTimeDisplay = json['end_time_display'];
    typeOfLeave = json['type_of_leave'];
    typeOfLeaveDisplay = json['type_of_leave_display'];
    typeOfLeaveBgColor = json['type_of_leave_bg_color'];
    typeOfLeaveTextColor = json['type_of_leave_text_color'];
    leaveStatusId = json['leave_status_id'];
    leaveStatusDisplay = json['leave_status_display'];
    leaveStatusBgColor = json['leave_status_bg_color'];
    leaveStatusTextColor = json['leave_status_text_color'];
    typeOfLeaveStatusDisplayHtml = json['type_of_leave_status_display_html'];
    leaveStatusDisplayHtml = json['leave_status_display_html'];
    adminRemark = json['admin_remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_leave_application_detail_id'] = this.employeeLeaveApplicationDetailId;
    data['leave_date'] = this.leaveDate;
    data['leave_date_display'] = this.leaveDateDisplay;
    data['is_halfday'] = this.isHalfday;
    data['half_full_day_display'] = this.halfFullDayDisplay;
    data['start_time'] = this.startTime;
    data['start_time_display'] = this.startTimeDisplay;
    data['end_time'] = this.endTime;
    data['end_time_display'] = this.endTimeDisplay;
    data['type_of_leave'] = this.typeOfLeave;
    data['type_of_leave_display'] = this.typeOfLeaveDisplay;
    data['type_of_leave_bg_color'] = this.typeOfLeaveBgColor;
    data['type_of_leave_text_color'] = this.typeOfLeaveTextColor;
    data['leave_status_id'] = this.leaveStatusId;
    data['leave_status_display'] = this.leaveStatusDisplay;
    data['leave_status_bg_color'] = this.leaveStatusBgColor;
    data['leave_status_text_color'] = this.leaveStatusTextColor;
    data['type_of_leave_status_display_html'] = this.typeOfLeaveStatusDisplayHtml;
    data['leave_status_display_html'] = this.leaveStatusDisplayHtml;
    data['admin_remark'] = this.adminRemark;
    return data;
  }
}
