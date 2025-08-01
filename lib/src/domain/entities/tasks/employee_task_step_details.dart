class EmployeeTaskStepDetails {
  int? taskTemplateAssignmentEmployeeMappingId;
  int? taskTemplateAssignmentEmployeeResponseId;
  int? taskApplicationStepCodeId;
  int? taskTemplateId;
  String? taskApplicationStepCode;
  int? taskApplicationTypeId;
  int? taskMainCategoryId;
  String? taskApplicationTypeName;
  String? taskMainCategoryName;
  String? stepStatus;
  int? sequenceNumber;
  int? isStepSkippable;
  String? stepEndDatetime;
  String? stepStartDatetime;
  int? taskTemplateStepId;
  String? taskTemplateStepTitle;
  String? taskTemplateStepDescription;
  int? estimatedDurationInMinutesToCompleteThisStep;
  String? stepDuration;

  EmployeeTaskStepDetails({
    this.taskTemplateAssignmentEmployeeMappingId,
    this.taskTemplateAssignmentEmployeeResponseId,
    this.taskApplicationStepCodeId,
    this.taskTemplateId,
    this.taskApplicationStepCode,
    this.taskApplicationTypeId,
    this.taskMainCategoryId,
    this.taskApplicationTypeName,
    this.taskMainCategoryName,
    this.stepStatus,
    this.sequenceNumber,
    this.isStepSkippable,
    this.stepEndDatetime,
    this.stepStartDatetime,
    this.taskTemplateStepId,
    this.taskTemplateStepTitle,
    this.taskTemplateStepDescription,
    this.estimatedDurationInMinutesToCompleteThisStep,
    this.stepDuration,
  });

  EmployeeTaskStepDetails.fromJson(Map<String, dynamic> json) {
    taskTemplateAssignmentEmployeeMappingId = json['task_template_assignment_employee_mapping_id'];
    taskTemplateAssignmentEmployeeResponseId = json['task_template_assignment_employee_response_id'];
    taskApplicationStepCodeId = json['task_application_step_code_id'];
    taskTemplateId = json['task_template_id'];
    taskApplicationStepCode = json['task_application_step_code'];
    taskApplicationTypeId = json['task_application_type_id'];
    taskMainCategoryId = json['task_main_category_id'];
    taskApplicationTypeName = json['task_application_type_name'];
    taskMainCategoryName = json['task_main_category_name'];
    stepStatus = json['step_status'];
    sequenceNumber = json['sequence_number'];
    isStepSkippable = json['is_step_skippable'];
    stepEndDatetime = json['step_end_datetime'];
    stepStartDatetime = json['step_start_datetime'];
    taskTemplateStepId = json['task_template_step_id'];
    taskTemplateStepTitle = json['task_template_step_title'];
    taskTemplateStepDescription = json['task_template_step_description'];
    estimatedDurationInMinutesToCompleteThisStep = json['estimated_duration_in_minutes_to_complete_this_step'];
    stepDuration = json['step_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_template_assignment_employee_mapping_id'] = this.taskTemplateAssignmentEmployeeMappingId;
    data['task_template_assignment_employee_response_id'] = this.taskTemplateAssignmentEmployeeResponseId;
    data['task_application_step_code_id'] = this.taskApplicationStepCodeId;
    data['task_template_id'] = this.taskTemplateId;
    data['task_application_step_code'] = this.taskApplicationStepCode;
    data['task_application_type_id'] = this.taskApplicationTypeId;
    data['task_main_category_id'] = this.taskMainCategoryId;
    data['task_application_type_name'] = this.taskApplicationTypeName;
    data['task_main_category_name'] = this.taskMainCategoryName;
    data['step_status'] = this.stepStatus;
    data['sequence_number'] = this.sequenceNumber;
    data['is_step_skippable'] = this.isStepSkippable;
    data['step_end_datetime'] = this.stepEndDatetime;
    data['step_start_datetime'] = this.stepStartDatetime;
    data['task_template_step_id'] = this.taskTemplateStepId;
    data['task_template_step_title'] = this.taskTemplateStepTitle;
    data['task_template_step_description'] = this.taskTemplateStepDescription;
    data['estimated_duration_in_minutes_to_complete_this_step'] = this.estimatedDurationInMinutesToCompleteThisStep;
    data['step_duration'] = this.stepDuration;
    return data;
  }
}
