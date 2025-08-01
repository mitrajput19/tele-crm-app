class EmployeeMarkAttendanceRequest {
  String? employeeId;
  String? employeeLoginId;
  int? employeeShiftDetailId;
  String? eventType;
  String? comments;
  double? latitude;
  double? longitude;

  EmployeeMarkAttendanceRequest({
    this.employeeId,
    this.employeeLoginId,
    this.employeeShiftDetailId,
    this.eventType,
    this.comments,
    this.latitude,
    this.longitude,
  });

  EmployeeMarkAttendanceRequest.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeLoginId = json['employee_login_id'];
    employeeShiftDetailId = json['employee_shift_detail_id'];
    eventType = json['event_type'];
    comments = json['comments'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['employee_login_id'] = this.employeeLoginId;
    data['employee_shift_detail_id'] = this.employeeShiftDetailId;
    data['event_type'] = this.eventType;
    data['comments'] = this.comments;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  EmployeeMarkAttendanceRequest copyWith({
    String? employeeId,
    String? employeeLoginId,
    int? employeeShiftDetailId,
    String? eventType,
    String? comments,
    double? latitude,
    double? longitude,
  }) {
    return EmployeeMarkAttendanceRequest(
      employeeId: employeeId ?? this.employeeId,
      employeeLoginId: employeeLoginId ?? this.employeeLoginId,
      employeeShiftDetailId: employeeShiftDetailId ?? this.employeeShiftDetailId,
      eventType: eventType ?? this.eventType,
      comments: comments ?? this.comments,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
