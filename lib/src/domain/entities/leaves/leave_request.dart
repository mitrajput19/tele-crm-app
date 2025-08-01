class LeaveRequest {
  String? leaveType;
  bool? isFullDay;
  String? viewDate;
  String? viewStartTime;
  String? viewEndTime;
  String? parsedDate;
  String? parsedStartTime;
  String? parsedEndTime;

  LeaveRequest({
    this.leaveType,
    this.isFullDay,
    this.viewDate,
    this.viewStartTime,
    this.viewEndTime,
    this.parsedDate,
    this.parsedStartTime,
    this.parsedEndTime,
  });

  LeaveRequest copyWith({
    String? leaveType,
    bool? isFullDay,
    String? viewDate,
    String? viewStartTime,
    String? viewEndTime,
    String? parsedDate,
    String? parsedStartTime,
    String? parsedEndTime,
  }) {
    return LeaveRequest(
      leaveType: leaveType ?? this.leaveType,
      isFullDay: isFullDay ?? this.isFullDay,
      viewDate: viewDate ?? this.viewDate,
      viewStartTime: viewStartTime ?? this.viewStartTime,
      viewEndTime: viewEndTime ?? this.viewEndTime,
      parsedDate: parsedDate ?? this.parsedDate,
      parsedStartTime: parsedStartTime ?? this.parsedStartTime,
      parsedEndTime: parsedEndTime ?? this.parsedEndTime,
    );
  }

  @override
  String toString() {
    return 'LeaveRequest(leaveType: $leaveType, isFullDay: $isFullDay, viewDate: $viewDate, viewStartTime: $viewStartTime, viewEndTime: $viewEndTime, parsedDate: $parsedDate, parsedStartTime: $parsedStartTime, parsedEndTime: $parsedEndTime)';
  }
}
