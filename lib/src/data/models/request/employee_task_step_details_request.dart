class EmployeeTaskStepDetailsRequest {
  int? languageId;
  String? tenantCode;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? taskTemplateAssignmentEmployeeResponseId;

  EmployeeTaskStepDetailsRequest({
    this.languageId,
    this.tenantCode,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.taskTemplateAssignmentEmployeeResponseId,
  });

  EmployeeTaskStepDetailsRequest.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    tenantCode = json['tenant_code'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    taskTemplateAssignmentEmployeeResponseId = json['task_template_assignment_employee_response_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['tenant_code'] = this.tenantCode;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['task_template_assignment_employee_response_id'] = this.taskTemplateAssignmentEmployeeResponseId;
    return data;
  }
}
