class EmployeeOpenShiftDetails {
  int? employeeShiftDetailId;
  int? employeeShiftId;
  String? shiftDate;
  String? shiftStartDate;
  String? shiftEndDate;
  String? startTime;
  String? endTime;
  String? employeeShiftDetailNotes;
  String? shiftStartDateTime;
  String? shiftEndDateTime;
  String? shiftTemplateName;
  String? shiftTemplateBgColorCode;
  String? shiftTemplateTextColorCode;
  int? swapCount;
  int? isShiftCancelled;
  String? departmentName;
  String? roleName;
  String? shiftDateDisplay;
  String? shiftTimeDisplay;
  String? status;
  String? statusBadge;
  String? shiftDetailsCardHtml;

  EmployeeOpenShiftDetails({
    this.employeeShiftDetailId,
    this.employeeShiftId,
    this.shiftDate,
    this.shiftStartDate,
    this.shiftEndDate,
    this.startTime,
    this.endTime,
    this.employeeShiftDetailNotes,
    this.shiftStartDateTime,
    this.shiftEndDateTime,
    this.shiftTemplateName,
    this.shiftTemplateBgColorCode,
    this.shiftTemplateTextColorCode,
    this.swapCount,
    this.isShiftCancelled,
    this.departmentName,
    this.roleName,
    this.shiftDateDisplay,
    this.shiftTimeDisplay,
    this.status,
    this.statusBadge,
    this.shiftDetailsCardHtml,
  });

  EmployeeOpenShiftDetails.fromJson(Map<String, dynamic> json) {
    employeeShiftDetailId = json['employee_shift_detail_id'];
    employeeShiftId = json['employee_shift_id'];
    shiftDate = json['shift_date'];
    shiftStartDate = json['shift_start_date'];
    shiftEndDate = json['shift_end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    employeeShiftDetailNotes = json['employee_shift_detail_notes'];
    shiftStartDateTime = json['shift_start_date_time'];
    shiftEndDateTime = json['shift_end_date_time'];
    shiftTemplateName = json['shift_template_name'];
    shiftTemplateBgColorCode = json['shift_template_bg_color_code'];
    shiftTemplateTextColorCode = json['shift_template_text_color_code'];
    swapCount = json['swap_count'];
    isShiftCancelled = json['is_shift_cancelled'];
    departmentName = json['department_name'];
    roleName = json['role_name'];
    shiftDateDisplay = json['shift_date_display'];
    shiftTimeDisplay = json['shift_time_display'];
    status = json['status'];
    statusBadge = json['status_badge'];
    shiftDetailsCardHtml = json['shift_details_card_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_shift_detail_id'] = this.employeeShiftDetailId;
    data['employee_shift_id'] = this.employeeShiftId;
    data['shift_date'] = this.shiftDate;
    data['shift_start_date'] = this.shiftStartDate;
    data['shift_end_date'] = this.shiftEndDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['employee_shift_detail_notes'] = this.employeeShiftDetailNotes;
    data['shift_start_date_time'] = this.shiftStartDateTime;
    data['shift_end_date_time'] = this.shiftEndDateTime;
    data['shift_template_name'] = this.shiftTemplateName;
    data['shift_template_bg_color_code'] = this.shiftTemplateBgColorCode;
    data['shift_template_text_color_code'] = this.shiftTemplateTextColorCode;
    data['swap_count'] = this.swapCount;
    data['is_shift_cancelled'] = this.isShiftCancelled;
    data['department_name'] = this.departmentName;
    data['role_name'] = this.roleName;
    data['shift_date_display'] = this.shiftDateDisplay;
    data['shift_time_display'] = this.shiftTimeDisplay;
    data['status'] = this.status;
    data['status_badge'] = this.statusBadge;
    data['shift_details_card_html'] = this.shiftDetailsCardHtml;
    return data;
  }

  static List<EmployeeOpenShiftDetails> listFromJson(dynamic json) {
    List<EmployeeOpenShiftDetails> list = [];
    if (json['details']['pickup_open_shifts_list'] != null) {
      json['details']['pickup_open_shifts_list'].forEach((v) {
        list.add(new EmployeeOpenShiftDetails.fromJson(v));
      });
    }
    return list;
  }
}
