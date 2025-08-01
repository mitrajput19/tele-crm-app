class RequestCallbackListRequest {
  String? token;
  int? accountId;
  int? companyId;
  int? employeeId;
  String? searchValue;
  int? perPage;
  int? page;

  RequestCallbackListRequest({
    this.token,
    this.accountId,
    this.companyId,
    this.employeeId,
    this.searchValue,
    this.perPage = 10,
    this.page,
  });

  RequestCallbackListRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    accountId = json['account_id'];
    companyId = json['company_id'];
    employeeId = json['employee_id'];
    searchValue = json['search_value'];
    perPage = json['per_page'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['account_id'] = this.accountId;
    data['company_id'] = this.companyId;
    data['employee_id'] = this.employeeId;
    data['search_value'] = this.searchValue;
    data['per_page'] = this.perPage;
    data['page'] = this.page;
    return data;
  }
}
