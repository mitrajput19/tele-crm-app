class EmployeeTaskDetailsRequest {
  int? languageId;
  String? tenantCode;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? taskTemplateAssignmentEmployeeMappingId;

  EmployeeTaskDetailsRequest({
    this.languageId,
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.taskTemplateAssignmentEmployeeMappingId,
  });

  EmployeeTaskDetailsRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    taskTemplateAssignmentEmployeeMappingId = json['task_template_assignment_employee_mapping_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['task_template_assignment_employee_mapping_id'] = this.taskTemplateAssignmentEmployeeMappingId;
    return data;
  }
}
