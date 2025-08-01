class CreateBugFollowUpRequest {
  String? token;
  int? companyId;
  int? accountId;
  int? createdByEmployeeId;
  int? bugTicketId;
  int? bugStatusId;
  String? bugResponse;

  CreateBugFollowUpRequest({
    this.token,
    this.companyId,
    this.accountId,
    this.createdByEmployeeId,
    this.bugTicketId,
    this.bugStatusId,
    this.bugResponse,
  });

  CreateBugFollowUpRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    companyId = json['company_id'];
    accountId = json['account_id'];
    createdByEmployeeId = json['created_by_employee_id'];
    bugTicketId = json['bug_ticket_id'];
    bugStatusId = json['bug_status_id'];
    bugResponse = json['bug_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['company_id'] = this.companyId;
    data['account_id'] = this.accountId;
    data['created_by_employee_id'] = this.createdByEmployeeId;
    data['bug_ticket_id'] = this.bugTicketId;
    data['bug_status_id'] = this.bugStatusId;
    data['bug_response'] = this.bugResponse;
    return data;
  }

  CreateBugFollowUpRequest copyWith({
    String? token,
    int? companyId,
    int? accountId,
    int? createdByEmployeeId,
    int? bugTicketId,
    int? bugStatusId,
    String? bugResponse,
  }) {
    return CreateBugFollowUpRequest(
      token: token ?? this.token,
      companyId: companyId ?? this.companyId,
      accountId: accountId ?? this.accountId,
      createdByEmployeeId: createdByEmployeeId ?? this.createdByEmployeeId,
      bugTicketId: bugTicketId ?? this.bugTicketId,
      bugStatusId: bugStatusId ?? this.bugStatusId,
      bugResponse: bugResponse ?? this.bugResponse,
    );
  }
}
