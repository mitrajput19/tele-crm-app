class CreateBugReportRequest {
  String? token;
  int? accountId;
  int? companyId;
  int? createdByEmployeeId;
  String? bugTitle;
  String? bugDescription;
  int? bugSeverityId;
  int? bugPriorityId;
  int? bugStatusId;
  List<int>? bugLabelId;
  List<int>? deviceId;

  CreateBugReportRequest({
    this.token,
    this.accountId,
    this.companyId,
    this.createdByEmployeeId,
    this.bugTitle,
    this.bugDescription,
    this.bugSeverityId,
    this.bugPriorityId,
    this.bugStatusId,
    this.bugLabelId,
    this.deviceId,
  });

  CreateBugReportRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    accountId = json['account_id'];
    companyId = json['company_id'];
    createdByEmployeeId = json['created_by_employee_id'];
    bugTitle = json['bug_title'];
    bugDescription = json['bug_description'];
    bugSeverityId = json['bug_severity_id'];
    bugPriorityId = json['bug_priority_id'];
    bugStatusId = json['bug_status_id'];
    bugLabelId = json['bug_label_id'].cast<int>();
    deviceId = json['device_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['account_id'] = this.accountId;
    data['company_id'] = this.companyId;
    data['created_by_employee_id'] = this.createdByEmployeeId;
    data['bug_title'] = this.bugTitle;
    data['bug_description'] = this.bugDescription;
    data['bug_severity_id'] = this.bugSeverityId;
    data['bug_priority_id'] = this.bugPriorityId;
    data['bug_status_id'] = this.bugStatusId;
    data['bug_label_id[]'] = this.bugLabelId;
    data['device_id[]'] = this.deviceId;
    return data;
  }

  CreateBugReportRequest copyWith({
    String? token,
    int? accountId,
    int? companyId,
    int? createdByEmployeeId,
    String? bugTitle,
    String? bugDescription,
    int? bugSeverityId,
    int? bugPriorityId,
    int? bugStatusId,
    List<int>? bugLabelId,
    List<int>? deviceId,
  }) {
    return CreateBugReportRequest(
      token: token ?? this.token,
      accountId: accountId ?? this.accountId,
      companyId: companyId ?? this.companyId,
      createdByEmployeeId: createdByEmployeeId ?? this.createdByEmployeeId,
      bugTitle: bugTitle ?? this.bugTitle,
      bugDescription: bugDescription ?? this.bugDescription,
      bugSeverityId: bugSeverityId ?? this.bugSeverityId,
      bugPriorityId: bugPriorityId ?? this.bugPriorityId,
      bugStatusId: bugStatusId ?? this.bugStatusId,
      bugLabelId: bugLabelId ?? this.bugLabelId,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}
