class BugReportedListRequest {
  String? token;
  int? accountId;
  int? companyId;
  int? createdByEmployeeId;
  int? perPage;
  int? page;
  String? searchValue;

  BugReportedListRequest({
    this.token,
    this.accountId,
    this.companyId,
    this.createdByEmployeeId,
    this.perPage = 10,
    this.page,
    this.searchValue,
  });

  BugReportedListRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    accountId = json['account_id'];
    companyId = json['company_id'];
    createdByEmployeeId = json['created_by_employee_id'];
    perPage = json['per_page'];
    page = json['page'];
    searchValue = json['search_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['account_id'] = this.accountId;
    data['company_id'] = this.companyId;
    data['created_by_employee_id'] = this.createdByEmployeeId;
    data['per_page'] = this.perPage;
    data['page'] = this.page;
    data['search_value'] = this.searchValue;
    return data;
  }
}
