class TaskStepTraningDetails {
  int? taskTrainingQuestionnaireRelatedStepFieldId;
  String? fieldType;
  String? fieldTitle;
  String? fieldPlaceholder;
  int? fieldSequenceNumber;
  List<TaskStepTraningAvailableStepFieldValues>? availableStepFieldValues;
  List<TaskStepTraningResponseDetails>? responseDetails;

  TaskStepTraningDetails({
    this.taskTrainingQuestionnaireRelatedStepFieldId,
    this.fieldType,
    this.fieldTitle,
    this.fieldPlaceholder,
    this.fieldSequenceNumber,
    this.availableStepFieldValues,
    this.responseDetails,
  });

  TaskStepTraningDetails.fromJson(Map<String, dynamic> json) {
    taskTrainingQuestionnaireRelatedStepFieldId = json['task_training_questionnaire_related_step_field_id'];
    fieldType = json['field_type'];
    fieldTitle = json['field_title'];
    fieldPlaceholder = json['field_placeholder'];
    fieldSequenceNumber = json['field_sequence_number'];
    if (json['available_step_field_values'] != null) {
      availableStepFieldValues = <TaskStepTraningAvailableStepFieldValues>[];
      json['available_step_field_values'].forEach((v) {
        availableStepFieldValues!.add(new TaskStepTraningAvailableStepFieldValues.fromJson(v));
      });
    }
    if (json['response_details'] != null) {
      responseDetails = <TaskStepTraningResponseDetails>[];
      json['response_details'].forEach((v) {
        responseDetails!.add(new TaskStepTraningResponseDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_training_questionnaire_related_step_field_id'] = this.taskTrainingQuestionnaireRelatedStepFieldId;
    data['field_type'] = this.fieldType;
    data['field_title'] = this.fieldTitle;
    data['field_placeholder'] = this.fieldPlaceholder;
    data['field_sequence_number'] = this.fieldSequenceNumber;
    if (this.availableStepFieldValues != null) {
      data['available_step_field_values'] = this.availableStepFieldValues!.map((v) => v.toJson()).toList();
    }
    if (this.responseDetails != null) {
      data['response_details'] = this.responseDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<TaskStepTraningDetails> listFromJson(dynamic json) {
    List<TaskStepTraningDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new TaskStepTraningDetails.fromJson(v));
      });
    }
    return list;
  }
}

class TaskStepTraningAvailableStepFieldValues {
  int? taskTrainingQuestionnaireRelatedStepFieldValueId;
  int? taskTrainingQuestionnaireRelatedStepFieldId;
  String? taskTrainingRelatedFieldValue;

  TaskStepTraningAvailableStepFieldValues({
    this.taskTrainingQuestionnaireRelatedStepFieldValueId,
    this.taskTrainingQuestionnaireRelatedStepFieldId,
    this.taskTrainingRelatedFieldValue,
  });

  TaskStepTraningAvailableStepFieldValues.fromJson(Map<String, dynamic> json) {
    taskTrainingQuestionnaireRelatedStepFieldValueId = json['task_training_questionnaire_related_step_field_value_id'];
    taskTrainingQuestionnaireRelatedStepFieldId = json['task_training_questionnaire_related_step_field_id'];
    taskTrainingRelatedFieldValue = json['task_training_related_field_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_training_questionnaire_related_step_field_value_id'] =
        this.taskTrainingQuestionnaireRelatedStepFieldValueId;
    data['task_training_questionnaire_related_step_field_id'] = this.taskTrainingQuestionnaireRelatedStepFieldId;
    data['task_training_related_field_value'] = this.taskTrainingRelatedFieldValue;
    return data;
  }
}

class TaskStepTraningResponseDetails {
  int? taskEmployeeResponseStepId;
  int? taskTrainingQuestionnaireRelatedStepFieldId;
  String? response;

  TaskStepTraningResponseDetails({
    this.taskEmployeeResponseStepId,
    this.taskTrainingQuestionnaireRelatedStepFieldId,
    this.response,
  });

  TaskStepTraningResponseDetails.fromJson(Map<String, dynamic> json) {
    taskEmployeeResponseStepId = json['task_employee_response_step_id'];
    taskTrainingQuestionnaireRelatedStepFieldId = json['task_training_questionnaire_related_step_field_id'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_employee_response_step_id'] = this.taskEmployeeResponseStepId;
    data['task_training_questionnaire_related_step_field_id'] = this.taskTrainingQuestionnaireRelatedStepFieldId;
    data['response'] = this.response;
    return data;
  }
}
