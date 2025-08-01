class BugReportDetailsRequest {
  String? token;
  int? accountId;
  int? companyId;
  int? createdByEmployeeId;
  int? bugTicketId;

  BugReportDetailsRequest({
    this.token,
    this.accountId,
    this.companyId,
    this.createdByEmployeeId,
    this.bugTicketId,
  });

  BugReportDetailsRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    accountId = json['account_id'];
    companyId = json['company_id'];
    createdByEmployeeId = json['created_by_employee_id'];
    bugTicketId = json['bug_ticket_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['account_id'] = this.accountId;
    data['company_id'] = this.companyId;
    data['created_by_employee_id'] = this.createdByEmployeeId;
    data['bug_ticket_id'] = this.bugTicketId;
    return data;
  }
}
