class MakeRequestDetails {
  int? makeARequestId;
  int? propertyId;
  int? generalPriorityId;
  int? makeARequestTypeId;
  int? departmentId;
  int? roleId;
  String? title;
  String? description;
  int? makeARequestStatusId;
  String? deadlineDatetime;
  int? assignmentTypeId;
  int? assignmentId;
  String? manuallyEnteredLocation;
  int? taskTemplateAssignmentEmployeeMappingId;
  String? requestedBy;
  int? requestedById;
  String? createdAt;
  String? propertyName;
  String? makeARequestTypeTitle;
  String? departmentName;
  String? roleName;
  String? requestedByName;
  String? guestCode;
  String? guestProfilePictureUrl;
  String? employeePicture;
  String? employeeCode;
  String? assignmentName;
  String? taskTemplateTitle;
  String? htmlUserCard;
  String? location;
  String? generalPriorityName;
  String? generalPriorityHtml;
  String? generalPriorityBgcolor;
  String? generalPriorityTextcolor;
  String? makeARequestStatusName;
  String? makeARequestStatusHtml;
  String? makeARequestStatusBgcolor;
  String? makeARequestStatusTextcolor;
  String? assignmentTypeName;
  List<MakeRequestAsset>? assets;
  List<MakeRequestStatusHistory>? statusHistory;

  MakeRequestDetails({
    this.makeARequestId,
    this.propertyId,
    this.generalPriorityId,
    this.makeARequestTypeId,
    this.departmentId,
    this.roleId,
    this.title,
    this.description,
    this.makeARequestStatusId,
    this.deadlineDatetime,
    this.assignmentTypeId,
    this.assignmentId,
    this.manuallyEnteredLocation,
    this.taskTemplateAssignmentEmployeeMappingId,
    this.requestedBy,
    this.requestedById,
    this.createdAt,
    this.propertyName,
    this.makeARequestTypeTitle,
    this.departmentName,
    this.roleName,
    this.requestedByName,
    this.guestCode,
    this.guestProfilePictureUrl,
    this.employeePicture,
    this.employeeCode,
    this.assignmentName,
    this.taskTemplateTitle,
    this.htmlUserCard,
    this.location,
    this.generalPriorityName,
    this.generalPriorityHtml,
    this.generalPriorityBgcolor,
    this.generalPriorityTextcolor,
    this.makeARequestStatusName,
    this.makeARequestStatusHtml,
    this.makeARequestStatusBgcolor,
    this.makeARequestStatusTextcolor,
    this.assignmentTypeName,
    this.assets,
    this.statusHistory,
  });

  MakeRequestDetails.fromJson(Map<String, dynamic> json) {
    makeARequestId = json['make_a_request_id'];
    propertyId = json['property_id'];
    generalPriorityId = json['general_priority_id'];
    makeARequestTypeId = json['make_a_request_type_id'];
    departmentId = json['department_id'];
    roleId = json['role_id'];
    title = json['title'];
    description = json['description'];
    makeARequestStatusId = json['make_a_request_status_id'];
    deadlineDatetime = json['deadline_datetime'];
    assignmentTypeId = json['assignment_type_id'];
    assignmentId = json['assignment_id'];
    manuallyEnteredLocation = json['manually_entered_location'];
    taskTemplateAssignmentEmployeeMappingId = json['task_template_assignment_employee_mapping_id'];
    requestedBy = json['requested_by'];
    requestedById = json['requested_by_id'];
    createdAt = json['created_at'];
    propertyName = json['property_name'];
    makeARequestTypeTitle = json['make_a_request_type_title'];
    departmentName = json['department_name'];
    roleName = json['role_name'];
    requestedByName = json['requested_by_name'];
    guestCode = json['guest_code'];
    guestProfilePictureUrl = json['guest_profile_picture_url'];
    employeePicture = json['employee_picture'];
    employeeCode = json['employee_code'];
    assignmentName = json['assignment_name'];
    taskTemplateTitle = json['task_template_title'];
    htmlUserCard = json['html_user_card'];
    location = json['location'];
    generalPriorityName = json['general_priority_name'];
    generalPriorityHtml = json['general_priority_html'];
    generalPriorityBgcolor = json['general_priority_bgcolor'];
    generalPriorityTextcolor = json['general_priority_textcolor'];
    makeARequestStatusName = json['make_a_request_status_name'];
    makeARequestStatusHtml = json['make_a_request_status_html'];
    makeARequestStatusBgcolor = json['make_a_request_status_bgcolor'];
    makeARequestStatusTextcolor = json['make_a_request_status_textcolor'];
    assignmentTypeName = json['assignment_type_name'];
    if (json['assets'] != null) {
      assets = <MakeRequestAsset>[];
      json['assets'].forEach((v) {
        assets!.add(new MakeRequestAsset.fromJson(v));
      });
    }
    if (json['status_history'] != null) {
      statusHistory = <MakeRequestStatusHistory>[];
      json['status_history'].forEach((v) {
        statusHistory!.add(new MakeRequestStatusHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['make_a_request_id'] = this.makeARequestId;
    data['property_id'] = this.propertyId;
    data['general_priority_id'] = this.generalPriorityId;
    data['make_a_request_type_id'] = this.makeARequestTypeId;
    data['department_id'] = this.departmentId;
    data['role_id'] = this.roleId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['make_a_request_status_id'] = this.makeARequestStatusId;
    data['deadline_datetime'] = this.deadlineDatetime;
    data['assignment_type_id'] = this.assignmentTypeId;
    data['assignment_id'] = this.assignmentId;
    data['manually_entered_location'] = this.manuallyEnteredLocation;
    data['task_template_assignment_employee_mapping_id'] = this.taskTemplateAssignmentEmployeeMappingId;
    data['requested_by'] = this.requestedBy;
    data['requested_by_id'] = this.requestedById;
    data['created_at'] = this.createdAt;
    data['property_name'] = this.propertyName;
    data['make_a_request_type_title'] = this.makeARequestTypeTitle;
    data['department_name'] = this.departmentName;
    data['role_name'] = this.roleName;
    data['requested_by_name'] = this.requestedByName;
    data['guest_code'] = this.guestCode;
    data['guest_profile_picture_url'] = this.guestProfilePictureUrl;
    data['employee_picture'] = this.employeePicture;
    data['employee_code'] = this.employeeCode;
    data['assignment_name'] = this.assignmentName;
    data['task_template_title'] = this.taskTemplateTitle;
    data['html_user_card'] = this.htmlUserCard;
    data['location'] = this.location;
    data['general_priority_name'] = this.generalPriorityName;
    data['general_priority_html'] = this.generalPriorityHtml;
    data['general_priority_bgcolor'] = this.generalPriorityBgcolor;
    data['general_priority_textcolor'] = this.generalPriorityTextcolor;
    data['make_a_request_status_name'] = this.makeARequestStatusName;
    data['make_a_request_status_html'] = this.makeARequestStatusHtml;
    data['make_a_request_status_bgcolor'] = this.makeARequestStatusBgcolor;
    data['make_a_request_status_textcolor'] = this.makeARequestStatusTextcolor;
    data['assignment_type_name'] = this.assignmentTypeName;
    if (this.assets != null) {
      data['assets'] = this.assets!.map((v) => v.toJson()).toList();
    }
    if (this.statusHistory != null) {
      data['status_history'] = this.statusHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<MakeRequestDetails> listFromJson(dynamic json) {
    List<MakeRequestDetails> list = [];
    if (json['details']['make_a_request_list'] != null) {
      json['details']['make_a_request_list'].forEach((v) {
        list.add(new MakeRequestDetails.fromJson(v));
      });
    }
    return list;
  }
}

class MakeRequestAsset {
  int? makeARequestAssetId;
  int? assetId;
  String? assetName;
  String? assetDescription;
  String? assetFileUrl;
  String? assetType;
  String? assetMimeType;
  int? assetFileSize;
  String? addedByEmployeeName;
  String? assetAddedAt;
  String? formattedFileSize;

  MakeRequestAsset({
    this.makeARequestAssetId,
    this.assetId,
    this.assetName,
    this.assetDescription,
    this.assetFileUrl,
    this.assetType,
    this.assetMimeType,
    this.assetFileSize,
    this.addedByEmployeeName,
    this.assetAddedAt,
    this.formattedFileSize,
  });

  MakeRequestAsset.fromJson(Map<String, dynamic> json) {
    makeARequestAssetId = json['make_a_request_asset_id'];
    assetId = json['asset_id'];
    assetName = json['asset_name'];
    assetDescription = json['asset_description'];
    assetFileUrl = json['asset_file_url'];
    assetType = json['asset_type'];
    assetMimeType = json['asset_mime_type'];
    assetFileSize = json['asset_file_size'];
    addedByEmployeeName = json['added_by_employee_name'];
    assetAddedAt = json['asset_added_at'];
    formattedFileSize = json['formatted_file_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['make_a_request_asset_id'] = this.makeARequestAssetId;
    data['asset_id'] = this.assetId;
    data['asset_name'] = this.assetName;
    data['asset_description'] = this.assetDescription;
    data['asset_file_url'] = this.assetFileUrl;
    data['asset_type'] = this.assetType;
    data['asset_mime_type'] = this.assetMimeType;
    data['asset_file_size'] = this.assetFileSize;
    data['added_by_employee_name'] = this.addedByEmployeeName;
    data['asset_added_at'] = this.assetAddedAt;
    data['formatted_file_size'] = this.formattedFileSize;
    return data;
  }
}

class MakeRequestStatusHistory {
  int? makeARequestStatusHistoryId;
  int? makeARequestStatusId;
  String? statusChangedAt;
  String? addedByEmployeeName;
  String? statusName;
  String? statusBgcolor;
  String? statusTextcolor;
  String? statusHtml;

  MakeRequestStatusHistory({
    this.makeARequestStatusHistoryId,
    this.makeARequestStatusId,
    this.statusChangedAt,
    this.addedByEmployeeName,
    this.statusName,
    this.statusBgcolor,
    this.statusTextcolor,
    this.statusHtml,
  });

  MakeRequestStatusHistory.fromJson(Map<String, dynamic> json) {
    makeARequestStatusHistoryId = json['make_a_request_status_history_id'];
    makeARequestStatusId = json['make_a_request_status_id'];
    statusChangedAt = json['status_changed_at'];
    addedByEmployeeName = json['added_by_employee_name'];
    statusName = json['status_name'];
    statusBgcolor = json['status_bgcolor'];
    statusTextcolor = json['status_textcolor'];
    statusHtml = json['status_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['make_a_request_status_history_id'] = this.makeARequestStatusHistoryId;
    data['make_a_request_status_id'] = this.makeARequestStatusId;
    data['status_changed_at'] = this.statusChangedAt;
    data['added_by_employee_name'] = this.addedByEmployeeName;
    data['status_name'] = this.statusName;
    data['status_bgcolor'] = this.statusBgcolor;
    data['status_textcolor'] = this.statusTextcolor;
    data['status_html'] = this.statusHtml;
    return data;
  }
}
