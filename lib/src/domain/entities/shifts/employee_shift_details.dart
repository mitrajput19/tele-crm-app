class EmployeeShiftDetails {
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
  int? isShiftCancelled;
  bool? showClockInButton;
  bool? showClockOutButton;
  bool? showBreakStartButton;
  bool? showBreakEndButton;
  bool? showAvailableButton;
  bool? showUnavailableButton;
  String? employeeShiftDetailNotes;
  String? departmentName;
  String? roleName;
  List<BreaksDetails>? breaks;
  List<AttendanceDetails>? attendanceHistory;

  EmployeeShiftDetails({
    this.employeeId,
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
    this.isShiftCancelled,
    this.showClockInButton,
    this.showClockOutButton,
    this.showBreakStartButton,
    this.showBreakEndButton,
    this.showAvailableButton,
    this.showUnavailableButton,
    this.employeeShiftDetailNotes,
    this.departmentName,
    this.roleName,
    this.breaks,
    this.attendanceHistory,
  });

  EmployeeShiftDetails.fromJson(Map<String, dynamic> json) {
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
    isShiftCancelled = json['is_shift_cancelled'];
    showClockInButton = json['show_clock_in_button'];
    showClockOutButton = json['show_clock_out_button'];
    showBreakStartButton = json['show_break_start_button'];
    showBreakEndButton = json['show_break_end_button'];
    showAvailableButton = json['show_available_button'];
    showUnavailableButton = json['show_unavailable_button'];
    employeeShiftDetailNotes = json['employee_shift_detail_notes'];
    departmentName = json['department_name'];
    roleName = json['role_name'];
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
    data['is_shift_cancelled'] = this.isShiftCancelled;
    data['show_clock_in_button'] = this.showClockInButton;
    data['show_clock_out_button'] = this.showClockOutButton;
    data['show_break_start_button'] = this.showBreakStartButton;
    data['show_break_end_button'] = this.showBreakEndButton;
    data['show_available_button'] = this.showAvailableButton;
    data['show_unavailable_button'] = this.showUnavailableButton;
    data['employee_shift_detail_notes'] = this.employeeShiftDetailNotes;
    data['department_name'] = this.departmentName;
    data['role_name'] = this.roleName;
    if (this.breaks != null) {
      data['breaks'] = this.breaks!.map((v) => v.toJson()).toList();
    }
    if (this.attendanceHistory != null) {
      data['attendance_history'] = this.attendanceHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<EmployeeShiftDetails> listFromJson(dynamic json) {
    List<EmployeeShiftDetails> list = [];
    if (json['details']['shifts'] != null) {
      json['details']['shifts'].forEach((v) {
        list.add(new EmployeeShiftDetails.fromJson(v));
      });
    }
    return list;
  }
}

class BreaksDetails {
  int? employeeShiftBreakTimingId;
  int? shiftBreakTypeId;
  String? shiftBreakTypeName;
  String? breakStartTimeDisplay;
  String? breakEndTimeDisplay;
  String? timeDifferenceDisplay;

  BreaksDetails({
    this.employeeShiftBreakTimingId,
    this.shiftBreakTypeId,
    this.shiftBreakTypeName,
    this.breakStartTimeDisplay,
    this.breakEndTimeDisplay,
    this.timeDifferenceDisplay,
  });

  BreaksDetails.fromJson(Map<String, dynamic> json) {
    employeeShiftBreakTimingId = json['employee_shift_break_timing_id'];
    shiftBreakTypeId = json['shift_break_type_id'];
    shiftBreakTypeName = json['shift_break_type_name'];
    breakStartTimeDisplay = json['break_start_time_display'];
    breakEndTimeDisplay = json['break_end_time_display'];
    timeDifferenceDisplay = json['time_difference_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_shift_break_timing_id'] = this.employeeShiftBreakTimingId;
    data['shift_break_type_id'] = this.shiftBreakTypeId;
    data['shift_break_type_name'] = this.shiftBreakTypeName;
    data['break_start_time_display'] = this.breakStartTimeDisplay;
    data['break_end_time_display'] = this.breakEndTimeDisplay;
    data['time_difference_display'] = this.timeDifferenceDisplay;
    return data;
  }
}

class AttendanceDetails {
  int? employeeShiftAttendanceId;
  int? shiftAttendedByEmployeeId;
  String? eventType;
  String? eventTypeDisplay;
  String? eventDatetimeDisplay;
  String? comments;
  num? latitude;
  num? longitude;
  String? ipAddress;

  AttendanceDetails({
    this.employeeShiftAttendanceId,
    this.shiftAttendedByEmployeeId,
    this.eventType,
    this.eventTypeDisplay,
    this.eventDatetimeDisplay,
    this.comments,
    this.latitude,
    this.longitude,
    this.ipAddress,
  });

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    employeeShiftAttendanceId = json['employee_shift_attendance_id'];
    shiftAttendedByEmployeeId = json['shift_attended_by_employee_id'];
    eventType = json['event_type'];
    eventTypeDisplay = json['event_type_display'];
    eventDatetimeDisplay = json['event_datetime_display'];
    comments = json['comments'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    ipAddress = json['ip_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_shift_attendance_id'] = this.employeeShiftAttendanceId;
    data['shift_attended_by_employee_id'] = this.shiftAttendedByEmployeeId;
    data['event_type'] = this.eventType;
    data['event_type_display'] = this.eventTypeDisplay;
    data['event_datetime_display'] = this.eventDatetimeDisplay;
    data['comments'] = this.comments;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['ip_address'] = this.ipAddress;
    return data;
  }
}
