class TaskMakeARequestListRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? taskTemplateAssignmentEmployeeMappingId;

  TaskMakeARequestListRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.taskTemplateAssignmentEmployeeMappingId,
  });

  TaskMakeARequestListRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    taskTemplateAssignmentEmployeeMappingId = json['task_template_assignment_employee_mapping_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['task_template_assignment_employee_mapping_id'] = this.taskTemplateAssignmentEmployeeMappingId;
    return data;
  }
}
