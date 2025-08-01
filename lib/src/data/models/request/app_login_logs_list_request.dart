class AppLoginLogsListRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? start;
  int? length;

  AppLoginLogsListRequest(
      {this.tenantCode,
      this.languageId,
      this.tenantCodeEncrypted,
      this.employeeId,
      this.ipAddress,
      this.start,
      this.length});

  AppLoginLogsListRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    start = json['start'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['start'] = this.start;
    data['length'] = this.length;
    return data;
  }
}
