class PropertyTransactionRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  String? fromDate;
  String? toDate;
  int? page;
  int? perPage;

  PropertyTransactionRequest(
      {this.tenantCode,
      this.languageId,
      this.tenantCodeEncrypted,
      this.employeeId,
      this.ipAddress,
      this.fromDate,
      this.toDate,
      this.page,
      this.perPage});

  PropertyTransactionRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    return data;
  }
}
