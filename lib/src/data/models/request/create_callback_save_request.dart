class CreateRequestCallbackRequest {
  int? accountId;
  int? companyId;
  int? employeeId;
  int? fourroomsStaffId;
  String? callbackDate;
  String? timeRange;
  String? token;
  String? hotelNotes;

  CreateRequestCallbackRequest({
    this.accountId,
    this.companyId,
    this.employeeId,
    this.fourroomsStaffId,
    this.callbackDate,
    this.timeRange,
    this.token,
    this.hotelNotes,
  });

  CreateRequestCallbackRequest.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    companyId = json['company_id'];
    employeeId = json['employee_id'];
    fourroomsStaffId = json['fourrooms_staff_id'];
    callbackDate = json['callback_date'];
    timeRange = json['time_range'];
    token = json['token'];
    hotelNotes = json['hotel_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['company_id'] = this.companyId;
    data['employee_id'] = this.employeeId;
    data['fourrooms_staff_id'] = this.fourroomsStaffId;
    data['callback_date'] = this.callbackDate;
    data['time_range'] = this.timeRange;
    data['token'] = this.token;
    data['hotel_notes'] = this.hotelNotes;
    return data;
  }

  CreateRequestCallbackRequest copyWith({
    int? accountId,
    int? companyId,
    int? employeeId,
    int? fourroomsStaffId,
    String? callbackDate,
    String? timeRange,
    String? token,
  }) {
    return CreateRequestCallbackRequest(
      accountId: accountId ?? this.accountId,
      companyId: companyId ?? this.companyId,
      employeeId: employeeId ?? this.employeeId,
      fourroomsStaffId: fourroomsStaffId ?? this.fourroomsStaffId,
      callbackDate: callbackDate ?? this.callbackDate,
      timeRange: timeRange ?? this.timeRange,
      token: token ?? this.token,
      hotelNotes: hotelNotes ?? this.hotelNotes,
    );
  }
}
