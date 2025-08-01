class TaskMakeRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? companyId;
  int? taskTemplateAssignmentEmployeeMappingId;
  String? title;
  String? description;
  int? makeARequestTypeId;
  int? generalPriorityId;
  String? manuallyEnteredLocation;

  TaskMakeRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.companyId,
    this.taskTemplateAssignmentEmployeeMappingId,
    this.title,
    this.description,
    this.makeARequestTypeId,
    this.generalPriorityId,
    this.manuallyEnteredLocation,
  });

  TaskMakeRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    companyId = json['company_id'];
    taskTemplateAssignmentEmployeeMappingId = json['task_template_assignment_employee_mapping_id'];
    title = json['title'];
    description = json['description'];
    makeARequestTypeId = json['make_a_request_type_id'];
    generalPriorityId = json['general_priority_id'];
    manuallyEnteredLocation = json['manually_entered_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['company_id'] = this.companyId;
    data['task_template_assignment_employee_mapping_id'] = this.taskTemplateAssignmentEmployeeMappingId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['make_a_request_type_id'] = this.makeARequestTypeId;
    data['general_priority_id'] = this.generalPriorityId;
    data['manually_entered_location'] = this.manuallyEnteredLocation;
    return data;
  }

  TaskMakeRequest copyWith({
    String? tenantCode,
    int? languageId,
    String? tenantCodeEncrypted,
    int? employeeId,
    String? ipAddress,
    int? companyId,
    int? taskTemplateAssignmentEmployeeMappingId,
    String? title,
    String? description,
    int? makeARequestTypeId,
    int? generalPriorityId,
    String? manuallyEnteredLocation,
  }) {
    return TaskMakeRequest(
      tenantCode: tenantCode ?? this.tenantCode,
      languageId: languageId ?? this.languageId,
      tenantCodeEncrypted: tenantCodeEncrypted ?? this.tenantCodeEncrypted,
      employeeId: employeeId ?? this.employeeId,
      ipAddress: ipAddress ?? this.ipAddress,
      companyId: companyId ?? this.companyId,
      taskTemplateAssignmentEmployeeMappingId:
          taskTemplateAssignmentEmployeeMappingId ?? this.taskTemplateAssignmentEmployeeMappingId,
      title: title ?? this.title,
      description: description ?? this.description,
      makeARequestTypeId: makeARequestTypeId ?? this.makeARequestTypeId,
      generalPriorityId: generalPriorityId ?? this.generalPriorityId,
      manuallyEnteredLocation: manuallyEnteredLocation ?? this.manuallyEnteredLocation,
    );
  }
}
