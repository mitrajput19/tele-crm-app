class AttendanceReportDetails {
  int? employeeShiftDetailId;
  int? employeeId;
  String? shiftTemplateName;
  String? shiftDate;
  String? shiftDateDisplay;
  String? startTime;
  String? endTime;
  String? shiftStartTimeDisplay;
  String? shiftEndTimeDisplay;
  String? departmentName;
  String? roleName;
  String? clockInTime;
  String? clockOutTime;
  String? clockInDateDisplay;
  String? clockInTimeDisplay;
  String? clockOutDateDisplay;
  String? clockOutTimeDisplay;
  String? shiftStatus;
  String? shiftStatusBgColor;
  String? shiftStatusTextColor;
  bool? showClockInLabel;
  bool? showClockOutLabel;
  String? clockInDateTimeDisplay;
  String? clockOutDateTimeDisplay;

  AttendanceReportDetails(
      {this.employeeShiftDetailId,
      this.employeeId,
      this.shiftTemplateName,
      this.shiftDate,
      this.shiftDateDisplay,
      this.startTime,
      this.endTime,
      this.shiftStartTimeDisplay,
      this.shiftEndTimeDisplay,
      this.departmentName,
      this.roleName,
      this.clockInTime,
      this.clockOutTime,
      this.clockInDateDisplay,
      this.clockInTimeDisplay,
      this.clockOutDateDisplay,
      this.clockOutTimeDisplay,
      this.shiftStatus,
      this.shiftStatusBgColor,
      this.shiftStatusTextColor,
      this.showClockInLabel,
      this.showClockOutLabel,
      this.clockInDateTimeDisplay,
      this.clockOutDateTimeDisplay});

  AttendanceReportDetails.fromJson(Map<String, dynamic> json) {
    employeeShiftDetailId = json['employee_shift_detail_id'];
    employeeId = json['employee_id'];
    shiftTemplateName = json['shift_template_name'];
    shiftDate = json['shift_date'];
    shiftDateDisplay = json['shift_date_display'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    shiftStartTimeDisplay = json['shift_start_time_display'];
    shiftEndTimeDisplay = json['shift_end_time_display'];
    departmentName = json['department_name'];
    roleName = json['role_name'];
    clockInTime = json['clock_in_time'];
    clockOutTime = json['clock_out_time'];
    clockInDateDisplay = json['clock_in_date_display'];
    clockInTimeDisplay = json['clock_in_time_display'];
    clockOutDateDisplay = json['clock_out_date_display'];
    clockOutTimeDisplay = json['clock_out_time_display'];
    shiftStatus = json['shift_status'];
    shiftStatusBgColor = json['shift_status_bg_color'];
    shiftStatusTextColor = json['shift_status_text_color'];
    showClockInLabel = json['show_clock_in_label'];
    showClockOutLabel = json['show_clock_out_label'];
    clockInDateTimeDisplay = json['clock_in_date_time_display'];
    clockOutDateTimeDisplay = json['clock_out_date_time_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_shift_detail_id'] = this.employeeShiftDetailId;
    data['employee_id'] = this.employeeId;
    data['shift_template_name'] = this.shiftTemplateName;
    data['shift_date'] = this.shiftDate;
    data['shift_date_display'] = this.shiftDateDisplay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['shift_start_time_display'] = this.shiftStartTimeDisplay;
    data['shift_end_time_display'] = this.shiftEndTimeDisplay;
    data['department_name'] = this.departmentName;
    data['role_name'] = this.roleName;
    data['clock_in_time'] = this.clockInTime;
    data['clock_out_time'] = this.clockOutTime;
    data['clock_in_date_display'] = this.clockInDateDisplay;
    data['clock_in_time_display'] = this.clockInTimeDisplay;
    data['clock_out_date_display'] = this.clockOutDateDisplay;
    data['clock_out_time_display'] = this.clockOutTimeDisplay;
    data['shift_status'] = this.shiftStatus;
    data['shift_status_bg_color'] = this.shiftStatusBgColor;
    data['shift_status_text_color'] = this.shiftStatusTextColor;
    data['show_clock_in_label'] = this.showClockInLabel;
    data['show_clock_out_label'] = this.showClockOutLabel;
    data['clock_in_date_time_display'] = this.clockInDateTimeDisplay;
    data['clock_out_date_time_display'] = this.clockOutDateTimeDisplay;
    return data;
  }

  static List<AttendanceReportDetails> listFromJson(dynamic json) {
    List<AttendanceReportDetails> list = [];
    if (json['details']['attendance'] != null) {
      json['details']['attendance'].forEach((v) {
        list.add(new AttendanceReportDetails.fromJson(v));
      });
    }
    return list;
  }
}
