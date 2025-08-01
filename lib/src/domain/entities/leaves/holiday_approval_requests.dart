class HolidayApprovalRequests {
  int? employeeHolidayId;
  String? employeeCard;
  String? requestDate;
  String? holidayDate;
  String? employeeHolidayType;
  String? employeeHolidayTypeDisplay;
  String? employeeHolidayTypeBgColor;
  String? employeeHolidayTypeTextColor;
  String? employeeHolidayReason;
  String? employeeHolidayTypeHtml;
  int? status;
  String? statusDisplay;
  String? statusBgColor;
  String? statusTextColor;
  String? statusDisplayHtml;
  String? actionTakenByEmployeeCard;
  String? actionTakenAt;
  String? employeeFullname;
  String? actionTakenByEmployeeFullname;

  HolidayApprovalRequests({
    this.employeeHolidayId,
    this.employeeCard,
    this.requestDate,
    this.holidayDate,
    this.employeeHolidayType,
    this.employeeHolidayTypeDisplay,
    this.employeeHolidayTypeBgColor,
    this.employeeHolidayTypeTextColor,
    this.employeeHolidayReason,
    this.employeeHolidayTypeHtml,
    this.status,
    this.statusDisplay,
    this.statusBgColor,
    this.statusTextColor,
    this.statusDisplayHtml,
    this.actionTakenByEmployeeCard,
    this.actionTakenAt,
    this.employeeFullname,
    this.actionTakenByEmployeeFullname,
  });

  HolidayApprovalRequests.fromJson(Map<String, dynamic> json) {
    employeeHolidayId = json['employee_holiday_id'];
    employeeCard = json['employee_card'];
    requestDate = json['request_date'];
    holidayDate = json['holiday_date'];
    employeeHolidayType = json['employee_holiday_type'];
    employeeHolidayTypeDisplay = json['employee_holiday_type_display'];
    employeeHolidayTypeBgColor = json['employee_holiday_type_bg_color'];
    employeeHolidayTypeTextColor = json['employee_holiday_type_text_color'];
    employeeHolidayReason = json['employee_holiday_reason'];
    employeeHolidayTypeHtml = json['employee_holiday_type_html'];
    status = json['status'];
    statusDisplay = json['status_display'];
    statusBgColor = json['status_bg_color'];
    statusTextColor = json['status_text_color'];
    statusDisplayHtml = json['status_display_html'];
    actionTakenByEmployeeCard = json['action_taken_by_employee_card'];
    actionTakenAt = json['action_taken_at'];
    employeeFullname = json['employee_fullname'];
    actionTakenByEmployeeFullname = json['action_taken_by_employee_fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_holiday_id'] = this.employeeHolidayId;
    data['employee_card'] = this.employeeCard;
    data['request_date'] = this.requestDate;
    data['holiday_date'] = this.holidayDate;
    data['employee_holiday_type'] = this.employeeHolidayType;
    data['employee_holiday_type_display'] = this.employeeHolidayTypeDisplay;
    data['employee_holiday_type_bg_color'] = this.employeeHolidayTypeBgColor;
    data['employee_holiday_type_text_color'] = this.employeeHolidayTypeTextColor;
    data['employee_holiday_reason'] = this.employeeHolidayReason;
    data['employee_holiday_type_html'] = this.employeeHolidayTypeHtml;
    data['status'] = this.status;
    data['status_display'] = this.statusDisplay;
    data['status_bg_color'] = this.statusBgColor;
    data['status_text_color'] = this.statusTextColor;
    data['status_display_html'] = this.statusDisplayHtml;
    data['action_taken_by_employee_card'] = this.actionTakenByEmployeeCard;
    data['action_taken_at'] = this.actionTakenAt;
    data['employee_fullname'] = this.employeeFullname;
    data['action_taken_by_employee_fullname'] = this.actionTakenByEmployeeFullname;
    return data;
  }

  static List<HolidayApprovalRequests> listFromJson(dynamic json) {
    List<HolidayApprovalRequests> list = [];
    if (json['details']['holidays_approval_requests'] != null) {
      json['details']['holidays_approval_requests'].forEach((v) {
        list.add(new HolidayApprovalRequests.fromJson(v));
      });
    }
    return list;
  }
}
