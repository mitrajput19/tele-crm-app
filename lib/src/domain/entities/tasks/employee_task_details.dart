class EmployeeTaskDetails {
  int? taskTemplateAssignmentEmployeeMappingId;
  int? taskTemplateAssignmentId;
  String? taskUniqueCode;
  int? taskTemplateId;
  String? taskTemplateTitle;
  int? taskApplicationTypeId;
  String? taskApplicationTypeName;
  String? taskMainCategoryName;
  int? taskPriorityId;
  String? taskPriorityName;
  String? taskPriorityHtml;
  String? taskPriorityBgcolor;
  String? taskPriorityTextcolor;
  int? taskIsFlexible;
  String? taskStartDatetime;
  String? taskEndDatetime;
  String? taskDuration;
  String? taskPeriod;
  String? entityOrLocationType;
  String? entityOrLocationDetails;
  String? productName;
  String? productAssignment;
  int? dependentOnOtherTask;
  int? workingEmployeeCount;
  int? employeeId;
  String? employeeCode;
  String? employeeName;
  String? employeePicture;
  String? taskEmployeeStartDatetime;
  String? taskEmployeeEndDatetime;
  String? taskEmployeeStatus;
  String? taskEmployeeSpecificNotes;
  String? taskEmployeeDuration;
  List<TaskRequiredEquipments>? requiredEquipments;
  List<TaskStep>? taskSteps;
  List<DependentTasks>? dependentTasks;
  List<TaskCoWorkers>? coWorkers;

  EmployeeTaskDetails({
    this.taskTemplateAssignmentEmployeeMappingId,
    this.taskTemplateAssignmentId,
    this.taskUniqueCode,
    this.taskTemplateId,
    this.taskTemplateTitle,
    this.taskApplicationTypeId,
    this.taskApplicationTypeName,
    this.taskMainCategoryName,
    this.taskPriorityId,
    this.taskPriorityName,
    this.taskPriorityHtml,
    this.taskPriorityBgcolor,
    this.taskPriorityTextcolor,
    this.taskIsFlexible,
    this.taskStartDatetime,
    this.taskEndDatetime,
    this.taskDuration,
    this.taskPeriod,
    this.entityOrLocationType,
    this.entityOrLocationDetails,
    this.productName,
    this.productAssignment,
    this.dependentOnOtherTask,
    this.workingEmployeeCount,
    this.employeeId,
    this.employeeCode,
    this.employeeName,
    this.employeePicture,
    this.taskEmployeeStartDatetime,
    this.taskEmployeeEndDatetime,
    this.taskEmployeeStatus,
    this.taskEmployeeSpecificNotes,
    this.taskEmployeeDuration,
    this.requiredEquipments,
    this.taskSteps,
    this.dependentTasks,
    this.coWorkers,
  });

  EmployeeTaskDetails.fromJson(Map<String, dynamic> json) {
    taskTemplateAssignmentEmployeeMappingId = json['task_template_assignment_employee_mapping_id'];
    taskTemplateAssignmentId = json['task_template_assignment_id'];
    taskUniqueCode = json['task_unique_code'];
    taskTemplateId = json['task_template_id'];
    taskTemplateTitle = json['task_template_title'];
    taskApplicationTypeId = json['task_application_type_id'];
    taskApplicationTypeName = json['task_application_type_name'];
    taskMainCategoryName = json['task_main_category_name'];
    taskPriorityId = json['task_priority_id'];
    taskPriorityName = json['task_priority_name'];
    taskPriorityHtml = json['task_priority_html'];
    taskPriorityBgcolor = json['task_priority_bgcolor'];
    taskPriorityTextcolor = json['task_priority_textcolor'];
    taskIsFlexible = json['task_is_flexible'];
    taskStartDatetime = json['task_start_datetime'];
    taskEndDatetime = json['task_end_datetime'];
    taskDuration = json['task_duration'];
    taskPeriod = json['task_period'];
    entityOrLocationType = json['entity_or_location_type'];
    entityOrLocationDetails = json['entity_or_location_details'];
    productName = json['product_name'];
    productAssignment = json['product_assignment'];
    dependentOnOtherTask = json['dependent_on_other_task'];
    workingEmployeeCount = json['working_employee_count'];
    employeeId = json['employee_id'];
    employeeCode = json['employee_code'];
    employeeName = json['employee_name'];
    employeePicture = json['employee_picture'];
    taskEmployeeStartDatetime = json['task_employee_start_datetime'];
    taskEmployeeEndDatetime = json['task_employee_end_datetime'];
    taskEmployeeStatus = json['task_employee_status'];
    taskEmployeeSpecificNotes = json['task_employee_specific_notes'];
    taskEmployeeDuration = json['task_employee_duration'];
    if (json['required_equipments'] != null) {
      requiredEquipments = <TaskRequiredEquipments>[];
      json['required_equipments'].forEach((v) {
        requiredEquipments!.add(new TaskRequiredEquipments.fromJson(v));
      });
    }
    if (json['task_steps'] != null) {
      taskSteps = <TaskStep>[];
      json['task_steps'].forEach((v) {
        taskSteps!.add(new TaskStep.fromJson(v));
      });
    }
    if (json['dependent_tasks'] != null) {
      dependentTasks = <DependentTasks>[];
      json['dependent_tasks'].forEach((v) {
        dependentTasks!.add(new DependentTasks.fromJson(v));
      });
    }
    if (json['co_workers'] != null) {
      coWorkers = <TaskCoWorkers>[];
      json['co_workers'].forEach((v) {
        coWorkers!.add(new TaskCoWorkers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_template_assignment_employee_mapping_id'] = this.taskTemplateAssignmentEmployeeMappingId;
    data['task_template_assignment_id'] = this.taskTemplateAssignmentId;
    data['task_unique_code'] = this.taskUniqueCode;
    data['task_template_id'] = this.taskTemplateId;
    data['task_template_title'] = this.taskTemplateTitle;
    data['task_application_type_id'] = this.taskApplicationTypeId;
    data['task_application_type_name'] = this.taskApplicationTypeName;
    data['task_main_category_name'] = this.taskMainCategoryName;
    data['task_priority_id'] = this.taskPriorityId;
    data['task_priority_name'] = this.taskPriorityName;
    data['task_priority_html'] = this.taskPriorityHtml;
    data['task_priority_bgcolor'] = this.taskPriorityBgcolor;
    data['task_priority_textcolor'] = this.taskPriorityTextcolor;
    data['task_is_flexible'] = this.taskIsFlexible;
    data['task_start_datetime'] = this.taskStartDatetime;
    data['task_end_datetime'] = this.taskEndDatetime;
    data['task_duration'] = this.taskDuration;
    data['task_period'] = this.taskPeriod;
    data['entity_or_location_type'] = this.entityOrLocationType;
    data['entity_or_location_details'] = this.entityOrLocationDetails;
    data['product_name'] = this.productName;
    data['product_assignment'] = this.productAssignment;
    data['dependent_on_other_task'] = this.dependentOnOtherTask;
    data['working_employee_count'] = this.workingEmployeeCount;
    data['employee_id'] = this.employeeId;
    data['employee_code'] = this.employeeCode;
    data['employee_name'] = this.employeeName;
    data['employee_picture'] = this.employeePicture;
    data['task_employee_start_datetime'] = this.taskEmployeeStartDatetime;
    data['task_employee_end_datetime'] = this.taskEmployeeEndDatetime;
    data['task_employee_status'] = this.taskEmployeeStatus;
    data['task_employee_specific_notes'] = this.taskEmployeeSpecificNotes;
    data['task_employee_duration'] = this.taskEmployeeDuration;
    if (this.requiredEquipments != null) {
      data['required_equipments'] = this.requiredEquipments!.map((v) => v.toJson()).toList();
    }
    if (this.taskSteps != null) {
      data['task_steps'] = this.taskSteps!.map((v) => v.toJson()).toList();
    }
    if (this.dependentTasks != null) {
      data['dependent_tasks'] = this.dependentTasks!.map((v) => v.toJson()).toList();
    }
    if (this.coWorkers != null) {
      data['co_workers'] = this.coWorkers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<EmployeeTaskDetails> listFromJson(dynamic json) {
    List<EmployeeTaskDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new EmployeeTaskDetails.fromJson(v));
      });
    }
    return list;
  }
}

class TaskRequiredEquipments {
  int? quantity;
  int? productId;
  String? productName;
  String? quantityHtml;
  int? taskTemplateId;
  int? taskTemplateRequiredEquipmentsMappingId;

  TaskRequiredEquipments({
    this.quantity,
    this.productId,
    this.productName,
    this.quantityHtml,
    this.taskTemplateId,
    this.taskTemplateRequiredEquipmentsMappingId,
  });

  TaskRequiredEquipments.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productId = json['product_id'];
    productName = json['product_name'];
    quantityHtml = json['quantity_html'];
    taskTemplateId = json['task_template_id'];
    taskTemplateRequiredEquipmentsMappingId = json['task_template_required_equipments_mapping_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['quantity_html'] = this.quantityHtml;
    data['task_template_id'] = this.taskTemplateId;
    data['task_template_required_equipments_mapping_id'] = this.taskTemplateRequiredEquipmentsMappingId;
    return data;
  }
}

class TaskStep {
  String? stepStatus;
  int? sequenceNumber;
  int? isStepSkippable;
  String? stepEndDatetime;
  String? stepStartDatetime;
  int? taskTemplateStepId;
  String? taskTemplateStepTitle;
  int? taskApplicationStepCodeId;
  String? taskTemplateStepDescription;
  int? taskTemplateAssignmentEmployeeMappingId;
  int? taskTemplateAssignmentEmployeeResponseId;
  int? estimatedDurationInMinutesToCompleteThisStep;
  String? stepDuration;
  String? taskApplicationStepCode;
  int? taskApplicationTypeId;
  int? taskMainCategoryId;
  String? taskApplicationTypeName;
  String? taskMainCategoryName;

  TaskStep({
    this.stepStatus,
    this.sequenceNumber,
    this.isStepSkippable,
    this.stepEndDatetime,
    this.stepStartDatetime,
    this.taskTemplateStepId,
    this.taskTemplateStepTitle,
    this.taskApplicationStepCodeId,
    this.taskTemplateStepDescription,
    this.taskTemplateAssignmentEmployeeMappingId,
    this.taskTemplateAssignmentEmployeeResponseId,
    this.estimatedDurationInMinutesToCompleteThisStep,
    this.stepDuration,
    this.taskApplicationStepCode,
    this.taskApplicationTypeId,
    this.taskMainCategoryId,
    this.taskApplicationTypeName,
    this.taskMainCategoryName,
  });

  TaskStep.fromJson(Map<String, dynamic> json) {
    stepStatus = json['step_status'];
    sequenceNumber = json['sequence_number'];
    isStepSkippable = json['is_step_skippable'];
    stepEndDatetime = json['step_end_datetime'];
    stepStartDatetime = json['step_start_datetime'];
    taskTemplateStepId = json['task_template_step_id'];
    taskTemplateStepTitle = json['task_template_step_title'];
    taskApplicationStepCodeId = json['task_application_step_code_id'];
    taskTemplateStepDescription = json['task_template_step_description'];
    taskTemplateAssignmentEmployeeMappingId = json['task_template_assignment_employee_mapping_id'];
    taskTemplateAssignmentEmployeeResponseId = json['task_template_assignment_employee_response_id'];
    estimatedDurationInMinutesToCompleteThisStep = json['estimated_duration_in_minutes_to_complete_this_step'];
    stepDuration = json['step_duration'];
    taskApplicationStepCode = json['task_application_step_code'];
    taskApplicationTypeId = json['task_application_type_id'];
    taskMainCategoryId = json['task_main_category_id'];
    taskApplicationTypeName = json['task_application_type_name'];
    taskMainCategoryName = json['task_main_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step_status'] = this.stepStatus;
    data['sequence_number'] = this.sequenceNumber;
    data['is_step_skippable'] = this.isStepSkippable;
    data['step_end_datetime'] = this.stepEndDatetime;
    data['step_start_datetime'] = this.stepStartDatetime;
    data['task_template_step_id'] = this.taskTemplateStepId;
    data['task_template_step_title'] = this.taskTemplateStepTitle;
    data['task_application_step_code_id'] = this.taskApplicationStepCodeId;
    data['task_template_step_description'] = this.taskTemplateStepDescription;
    data['task_template_assignment_employee_mapping_id'] = this.taskTemplateAssignmentEmployeeMappingId;
    data['task_template_assignment_employee_response_id'] = this.taskTemplateAssignmentEmployeeResponseId;
    data['estimated_duration_in_minutes_to_complete_this_step'] = this.estimatedDurationInMinutesToCompleteThisStep;
    data['step_duration'] = this.stepDuration;
    data['task_application_step_code'] = this.taskApplicationStepCode;
    data['task_application_type_id'] = this.taskApplicationTypeId;
    data['task_main_category_id'] = this.taskMainCategoryId;
    data['task_application_type_name'] = this.taskApplicationTypeName;
    data['task_main_category_name'] = this.taskMainCategoryName;
    return data;
  }
}

class DependentTasks {
  int? dependentTaskTemplateId;
  String? dependentTaskUniqueCode;
  String? dependentTaskTemplateTitle;
  int? dependentEntityOrLocationId;
  String? dependentEntityOrLocationType;
  int? dependentTaskApplicationTypeId;
  String? dependentEntityOrLocationDetails;
  int? dependentTaskTemplateAssignmentId;

  DependentTasks({
    this.dependentTaskTemplateId,
    this.dependentTaskUniqueCode,
    this.dependentTaskTemplateTitle,
    this.dependentEntityOrLocationId,
    this.dependentEntityOrLocationType,
    this.dependentTaskApplicationTypeId,
    this.dependentEntityOrLocationDetails,
    this.dependentTaskTemplateAssignmentId,
  });

  DependentTasks.fromJson(Map<String, dynamic> json) {
    dependentTaskTemplateId = json['dependent_task_template_id'];
    dependentTaskUniqueCode = json['dependent_task_unique_code'];
    dependentTaskTemplateTitle = json['dependent_task_template_title'];
    dependentEntityOrLocationId = json['dependent_entity_or_location_id'];
    dependentEntityOrLocationType = json['dependent_entity_or_location_type'];
    dependentTaskApplicationTypeId = json['dependent_task_application_type_id'];
    dependentEntityOrLocationDetails = json['dependent_entity_or_location_details'];
    dependentTaskTemplateAssignmentId = json['dependent_task_template_assignment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dependent_task_template_id'] = this.dependentTaskTemplateId;
    data['dependent_task_unique_code'] = this.dependentTaskUniqueCode;
    data['dependent_task_template_title'] = this.dependentTaskTemplateTitle;
    data['dependent_entity_or_location_id'] = this.dependentEntityOrLocationId;
    data['dependent_entity_or_location_type'] = this.dependentEntityOrLocationType;
    data['dependent_task_application_type_id'] = this.dependentTaskApplicationTypeId;
    data['dependent_entity_or_location_details'] = this.dependentEntityOrLocationDetails;
    data['dependent_task_template_assignment_id'] = this.dependentTaskTemplateAssignmentId;
    return data;
  }
}

class TaskCoWorkers {
  int? employeeId;
  String? employeeCode;
  String? employeeName;
  String? employeePicture;

  TaskCoWorkers({
    this.employeeId,
    this.employeeCode,
    this.employeeName,
    this.employeePicture,
  });

  TaskCoWorkers.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeCode = json['employee_code'];
    employeeName = json['employee_name'];
    employeePicture = json['employee_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['employee_code'] = this.employeeCode;
    data['employee_name'] = this.employeeName;
    data['employee_picture'] = this.employeePicture;
    return data;
  }
}
