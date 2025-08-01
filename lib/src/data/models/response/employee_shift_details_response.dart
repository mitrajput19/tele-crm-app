import '../../../app/app.dart';

class EmployeeShiftDetailsResponse {
  int? employeeId;
  int? employeeShiftDetailId;
  String? shiftDate;
  String? shiftDateDisplay;
  String? shiftStartDate;
  String? shiftEndDate;
  String? shiftStartDateTimeDisplay;
  String? shiftEndDateTimeDisplay;
  String? shiftTemplateName;
  String? startTime;
  String? endTime;
  String? startTimeDisplay;
  String? endTimeDisplay;
  String? shiftTemplateBgColorCode;
  String? shiftTemplateTextColorCode;
  int? swapCount;
  String? shiftStatus;
  String? shiftStatusBgColor;
  String? shiftStatusTextColor;
  bool? showClockInButton;
  bool? showClockOutButton;
  bool? showBreakStartButton;
  bool? showBreakEndButton;
  bool? showAvailableButton;
  bool? showUnavailableButton;
  int? isShiftCancelled;
  List<BreaksDetails>? breaks;
  List<AttendanceDetails>? attendanceHistory;

  EmployeeShiftDetailsResponse(
      {this.employeeId,
      this.employeeShiftDetailId,
      this.shiftDate,
      this.shiftDateDisplay,
      this.shiftStartDate,
      this.shiftEndDate,
      this.shiftStartDateTimeDisplay,
      this.shiftEndDateTimeDisplay,
      this.shiftTemplateName,
      this.startTime,
      this.endTime,
      this.startTimeDisplay,
      this.endTimeDisplay,
      this.shiftTemplateBgColorCode,
      this.shiftTemplateTextColorCode,
      this.swapCount,
      this.shiftStatus,
      this.shiftStatusBgColor,
      this.shiftStatusTextColor,
      this.showClockInButton,
      this.showClockOutButton,
      this.showBreakStartButton,
      this.showBreakEndButton,
      this.showAvailableButton,
      this.showUnavailableButton,
      this.isShiftCancelled,
      this.breaks,
      this.attendanceHistory});

  EmployeeShiftDetailsResponse.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeShiftDetailId = json['employee_shift_detail_id'];
    shiftDate = json['shift_date'];
    shiftDateDisplay = json['shift_date_display'];
    shiftStartDate = json['shift_start_date'];
    shiftEndDate = json['shift_end_date'];
    shiftStartDateTimeDisplay = json['shift_start_date_time_display'];
    shiftEndDateTimeDisplay = json['shift_end_date_time_display'];
    shiftTemplateName = json['shift_template_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    startTimeDisplay = json['start_time_display'];
    endTimeDisplay = json['end_time_display'];
    shiftTemplateBgColorCode = json['shift_template_bg_color_code'];
    shiftTemplateTextColorCode = json['shift_template_text_color_code'];
    swapCount = json['swap_count'];
    shiftStatus = json['shift_status'];
    shiftStatusBgColor = json['shift_status_bg_color'];
    shiftStatusTextColor = json['shift_status_text_color'];
    showClockInButton = json['show_clock_in_button'];
    showClockOutButton = json['show_clock_out_button'];
    showBreakStartButton = json['show_break_start_button'];
    showBreakEndButton = json['show_break_end_button'];
    showAvailableButton = json['show_available_button'];
    showUnavailableButton = json['show_unavailable_button'];
    isShiftCancelled = json['is_shift_cancelled'];
    if (json['breaks'] != null) {
      breaks = <BreaksDetails>[];
      json['breaks'].forEach((v) {
        breaks!.add(new BreaksDetails.fromJson(v));
      });
    }
    if (json['attendance_history'] != null) {
      attendanceHistory = <AttendanceDetails>[];
      json['attendance_history'].forEach((v) {
        attendanceHistory!.add(new AttendanceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['employee_shift_detail_id'] = this.employeeShiftDetailId;
    data['shift_date'] = this.shiftDate;
    data['shift_date_display'] = this.shiftDateDisplay;
    data['shift_start_date'] = this.shiftStartDate;
    data['shift_end_date'] = this.shiftEndDate;
    data['shift_start_date_time_display'] = this.shiftStartDateTimeDisplay;
    data['shift_end_date_time_display'] = this.shiftEndDateTimeDisplay;
    data['shift_template_name'] = this.shiftTemplateName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['start_time_display'] = this.startTimeDisplay;
    data['end_time_display'] = this.endTimeDisplay;
    data['shift_template_bg_color_code'] = this.shiftTemplateBgColorCode;
    data['shift_template_text_color_code'] = this.shiftTemplateTextColorCode;
    data['swap_count'] = this.swapCount;
    data['shift_status'] = this.shiftStatus;
    data['shift_status_bg_color'] = this.shiftStatusBgColor;
    data['shift_status_text_color'] = this.shiftStatusTextColor;
    data['show_clock_in_button'] = this.showClockInButton;
    data['show_clock_out_button'] = this.showClockOutButton;
    data['show_break_start_button'] = this.showBreakStartButton;
    data['show_break_end_button'] = this.showBreakEndButton;
    data['show_available_button'] = this.showAvailableButton;
    data['show_unavailable_button'] = this.showUnavailableButton;
    data['is_shift_cancelled'] = this.isShiftCancelled;
    if (this.breaks != null) {
      data['breaks'] = this.breaks!.map((v) => v.toJson()).toList();
    }
    if (this.attendanceHistory != null) {
      data['attendance_history'] = this.attendanceHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
