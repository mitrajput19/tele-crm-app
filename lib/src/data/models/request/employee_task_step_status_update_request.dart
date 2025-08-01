import 'package:dio/dio.dart';

class EmployeeTaskStepStatusUpdateRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? taskTemplateAssignmentEmployeeResponseId;
  String? stepStatus;
  int? taskTemplateAssignmentEmployeeMappingId;
  List<TaskStepCollectItemsResponseData>? collectItemsResponse;
  List<TaskStepAddItemsResponseData>? addItemsResponse;
  List<TaskStepCustomStepResponseData>? customStepResponse;
  TaskStepChangeRoomStatusResponseData? changeRoomStatusResponse;

  EmployeeTaskStepStatusUpdateRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.taskTemplateAssignmentEmployeeResponseId,
    this.stepStatus,
    this.taskTemplateAssignmentEmployeeMappingId,
    this.collectItemsResponse,
    this.addItemsResponse,
    this.customStepResponse,
    this.changeRoomStatusResponse,
  });

  EmployeeTaskStepStatusUpdateRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    taskTemplateAssignmentEmployeeResponseId = json['task_template_assignment_employee_response_id'];
    stepStatus = json['step_status'];
    taskTemplateAssignmentEmployeeMappingId = json['task_template_assignment_employee_mapping_id'];
    if (json['collect_items_response'] != null) {
      collectItemsResponse = <TaskStepCollectItemsResponseData>[];
      json['collect_items_response'].forEach((v) {
        collectItemsResponse!.add(new TaskStepCollectItemsResponseData.fromJson(v));
      });
    }
    if (json['add_items_response'] != null) {
      addItemsResponse = <TaskStepAddItemsResponseData>[];
      json['add_items_response'].forEach((v) {
        addItemsResponse!.add(new TaskStepAddItemsResponseData.fromJson(v));
      });
    }
    if (json['custom_step_response'] != null) {
      customStepResponse = <TaskStepCustomStepResponseData>[];
      json['custom_step_response'].forEach((v) {
        customStepResponse!.add(new TaskStepCustomStepResponseData.fromJson(v));
      });
    }
    changeRoomStatusResponse = json['change_room_status_response'] != null
        ? new TaskStepChangeRoomStatusResponseData.fromJson(json['change_room_status_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['task_template_assignment_employee_response_id'] = this.taskTemplateAssignmentEmployeeResponseId;
    data['step_status'] = this.stepStatus;
    data['task_template_assignment_employee_mapping_id'] = this.taskTemplateAssignmentEmployeeMappingId;
    if (this.collectItemsResponse != null) {
      data['collect_items_response'] = this.collectItemsResponse!.map((v) => v.toJson()).toList();
    }
    if (this.addItemsResponse != null) {
      data['add_items_response'] = this.addItemsResponse!.map((v) => v.toJson()).toList();
    }
    if (this.customStepResponse != null) {
      data['custom_step_response'] = this.customStepResponse!.map((v) => v.toJson()).toList();
    }
    if (this.changeRoomStatusResponse != null) {
      data['change_room_status_response'] = this.changeRoomStatusResponse!.toJson();
    }
    return data;
  }
}

class TaskStepCollectItemsResponseData {
  int? housekeepingProductsInRoomId;
  int? itemsCollectedQuantity;

  TaskStepCollectItemsResponseData({
    this.housekeepingProductsInRoomId,
    this.itemsCollectedQuantity,
  });

  TaskStepCollectItemsResponseData.fromJson(Map<String, dynamic> json) {
    housekeepingProductsInRoomId = json['housekeeping_products_in_room_id'];
    itemsCollectedQuantity = json['items_collected_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['housekeeping_products_in_room_id'] = this.housekeepingProductsInRoomId;
    data['items_collected_quantity'] = this.itemsCollectedQuantity;
    return data;
  }
}

class TaskStepAddItemsResponseData {
  int? housekeepingProductsInRoomId;
  int? itemsAddedQuantity;

  TaskStepAddItemsResponseData({
    this.housekeepingProductsInRoomId,
    this.itemsAddedQuantity,
  });

  TaskStepAddItemsResponseData.fromJson(Map<String, dynamic> json) {
    housekeepingProductsInRoomId = json['housekeeping_products_in_room_id'];
    itemsAddedQuantity = json['items_added_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['housekeeping_products_in_room_id'] = this.housekeepingProductsInRoomId;
    data['items_added_quantity'] = this.itemsAddedQuantity;
    return data;
  }
}

class TaskStepCustomStepResponseData {
  int? taskTrainingQuestionnaireRelatedStepFieldId;
  dynamic response;

  TaskStepCustomStepResponseData({
    this.taskTrainingQuestionnaireRelatedStepFieldId,
    this.response,
  });

  TaskStepCustomStepResponseData.fromJson(Map<String, dynamic> json) {
    taskTrainingQuestionnaireRelatedStepFieldId = json['task_training_questionnaire_related_step_field_id'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_training_questionnaire_related_step_field_id'] = this.taskTrainingQuestionnaireRelatedStepFieldId;
    data['response'] = this.response;
    return data;
  }
}

class TaskStepChangeRoomStatusResponseData {
  int? updatedRoomHousekeepingStatusId;

  TaskStepChangeRoomStatusResponseData({
    this.updatedRoomHousekeepingStatusId,
  });

  TaskStepChangeRoomStatusResponseData.fromJson(Map<String, dynamic> json) {
    updatedRoomHousekeepingStatusId = json['updated_room_housekeeping_status_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_room_housekeeping_status_id'] = this.updatedRoomHousekeepingStatusId;
    return data;
  }
}

class TaskStepRoomPicturesResponseData {
  int? id;
  List<MultipartFile>? filesList;

  TaskStepRoomPicturesResponseData({this.id, this.filesList});

  // TaskStepRoomPicturesResponseData.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   filesList = (json['filesList'] as List<dynamic>?)
  //       ?.map(
  //         (file) => MultipartFileExtension.fromJson(file),
  //       )
  //       .toList();
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['filesList'] = filesList?.map((file) => MultipartFileExtension.toJson(file)).toList();
  //   return data;
  // }
}

class TaskStepRoomInspectionResponseData {
  int? id;
  int? valueId;
  List<MultipartFile>? filesList;

  TaskStepRoomInspectionResponseData({this.id, this.valueId, this.filesList});

  // TaskStepRoomInspectionResponseData.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   valueId = json['valueId'];
  //   filesList = (json['filesList'] as List<dynamic>?)
  //       ?.map(
  //         (file) => MultipartFileExtension.fromJson(file),
  //       )
  //       .toList();
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['valueId'] = valueId;
  //   data['filesList'] = filesList?.map((file) => MultipartFileExtension.toJson(file)).toList();
  //   return data;
  // }
}
