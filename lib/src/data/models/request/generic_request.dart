class GenericRequest {
  String? tenantCode;
  String? tenantCodeEncrypted;
  int? languageId;
  int? accountId;
  int? companyId;
  int? employeeId;
  String? ipAddress;
  String? fromDate;
  String? toDate;
  Map<String, dynamic>? additionalParams;

  GenericRequest({
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.languageId,
    this.accountId,
    this.companyId,
    this.employeeId,
    this.ipAddress,
    this.fromDate,
    this.toDate,
    this.additionalParams,
  });

  GenericRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    languageId = json['language_id'];
    accountId = json['account_id'];
    companyId = json['company_id'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    additionalParams = json['additional_params'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    if (this.languageId != null) data['language_id'] = this.languageId;
    if (this.accountId != null) data['account_id'] = this.accountId;
    if (this.companyId != null) data['company_id'] = this.companyId;
    if (this.employeeId != null) data['employee_id'] = this.employeeId;
    if (this.ipAddress != null) data['ip_address'] = this.ipAddress;
    if (this.fromDate != null) data['from_date'] = this.fromDate;
    if (this.toDate != null) data['to_date'] = this.toDate;
    if (this.additionalParams != null) data.addAll(additionalParams!);
    return data;
  }
}
