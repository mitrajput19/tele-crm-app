class ShiftDisplayEmployeeStatus {
  String? minutesUntilShiftStart;
  String? shiftStatus;
  String? shiftStatusBackgroundColor;
  String? shiftStatusTextColor;
  bool? showClockInButton;
  bool? showClockOutButton;
  bool? showBreakStartButton;
  bool? showBreakEndButton;

  ShiftDisplayEmployeeStatus({
    this.minutesUntilShiftStart,
    this.shiftStatus,
    this.shiftStatusBackgroundColor,
    this.shiftStatusTextColor,
    this.showClockInButton,
    this.showClockOutButton,
    this.showBreakStartButton,
    this.showBreakEndButton,
  });

  ShiftDisplayEmployeeStatus.fromJson(Map<String, dynamic> json) {
    minutesUntilShiftStart = json['minutes_until_shift_start'];
    shiftStatus = json['shift_status'];
    shiftStatusBackgroundColor = json['shift_status_background_color'];
    shiftStatusTextColor = json['shift_status_text_color'];
    showClockInButton = json['show_clock_in_button'];
    showClockOutButton = json['show_clock_out_button'];
    showBreakStartButton = json['show_break_start_button'];
    showBreakEndButton = json['show_break_end_button'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minutes_until_shift_start'] = this.minutesUntilShiftStart;
    data['shift_status'] = this.shiftStatus;
    data['shift_status_background_color'] = this.shiftStatusBackgroundColor;
    data['shift_status_text_color'] = this.shiftStatusTextColor;
    data['show_clock_in_button'] = this.showClockInButton;
    data['show_clock_out_button'] = this.showClockOutButton;
    data['show_break_start_button'] = this.showBreakStartButton;
    data['show_break_end_button'] = this.showBreakEndButton;
    return data;
  }
}
