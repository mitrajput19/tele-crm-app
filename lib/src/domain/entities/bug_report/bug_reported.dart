class BugReportedDetails {
  int? currentPage;
  List<BugReported>? bugReport;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<BugReportLinks>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  BugReportedDetails({
    this.currentPage,
    this.bugReport,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  BugReportedDetails.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      bugReport = <BugReported>[];
      json['data'].forEach((v) {
        bugReport!.add(new BugReported.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <BugReportLinks>[];
      json['links'].forEach((v) {
        links!.add(new BugReportLinks.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.bugReport != null) {
      data['data'] = this.bugReport!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class BugReported {
  int? bugTicketId;
  String? bugTitle;
  String? bugDescription;
  int? bugSeverityId;
  int? bugPriorityId;
  int? bugStatusId;
  int? accountId;
  int? companyId;
  int? isClosed;
  int? createdByEmployeeId;
  String? createdAt;
  String? updatedAt;
  String? createdAtFormat;
  String? updatedAtFormat;
  BugReportedSeverityData? bugReportedSeverityData;
  BugReportedPriorityData? bugReportedPriorityData;
  BugReportedStatusData? bugReportedStatusData;
  List<BugReportedDevicesData>? bugReportedDevicesData;
  List<BugReportedLablesData>? bugReportedLablesData;
  List<BugReportedFilesData>? bugReportedFilesData;
  List<BugFollowUpsData>? bugFollowUpsData;

  BugReported({
    this.bugTicketId,
    this.bugTitle,
    this.bugDescription,
    this.bugSeverityId,
    this.bugPriorityId,
    this.bugStatusId,
    this.accountId,
    this.companyId,
    this.isClosed,
    this.createdByEmployeeId,
    this.createdAt,
    this.updatedAt,
    this.createdAtFormat,
    this.updatedAtFormat,
    this.bugReportedSeverityData,
    this.bugReportedPriorityData,
    this.bugReportedStatusData,
    this.bugReportedDevicesData,
    this.bugReportedLablesData,
    this.bugReportedFilesData,
    this.bugFollowUpsData,
  });

  BugReported.fromJson(Map<String, dynamic> json) {
    bugTicketId = json['bug_ticket_id'];
    bugTitle = json['bug_title'];
    bugDescription = json['bug_description'];
    bugSeverityId = json['bug_severity_id'];
    bugPriorityId = json['bug_priority_id'];
    bugStatusId = json['bug_status_id'];
    accountId = json['account_id'];
    companyId = json['company_id'];
    isClosed = json['is_closed'];
    createdByEmployeeId = json['created_by_employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdAtFormat = json['created_at_format'];
    updatedAtFormat = json['updated_at_format'];
    bugReportedSeverityData = json['bug_severity_name_data'] != null
        ? new BugReportedSeverityData.fromJson(json['bug_severity_name_data'])
        : null;
    bugReportedPriorityData =
        json['bug_priority_data'] != null ? new BugReportedPriorityData.fromJson(json['bug_priority_data']) : null;
    bugReportedStatusData =
        json['bug_status_name_data'] != null ? new BugReportedStatusData.fromJson(json['bug_status_name_data']) : null;
    if (json['devices'] != null) {
      bugReportedDevicesData = <BugReportedDevicesData>[];
      json['devices'].forEach((v) {
        bugReportedDevicesData!.add(new BugReportedDevicesData.fromJson(v));
      });
    }
    if (json['lables'] != null) {
      bugReportedLablesData = <BugReportedLablesData>[];
      json['lables'].forEach((v) {
        bugReportedLablesData!.add(new BugReportedLablesData.fromJson(v));
      });
    }
    if (json['bug_reports_files'] != null) {
      bugReportedFilesData = <BugReportedFilesData>[];
      json['bug_reports_files'].forEach((v) {
        bugReportedFilesData!.add(new BugReportedFilesData.fromJson(v));
      });
    }
    if (json['bug_follow_ups'] != null) {
      bugFollowUpsData = <BugFollowUpsData>[];
      json['bug_follow_ups'].forEach((v) {
        bugFollowUpsData!.add(new BugFollowUpsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_ticket_id'] = this.bugTicketId;
    data['bug_title'] = this.bugTitle;
    data['bug_description'] = this.bugDescription;
    data['bug_severity_id'] = this.bugSeverityId;
    data['bug_priority_id'] = this.bugPriorityId;
    data['bug_status_id'] = this.bugStatusId;
    data['account_id'] = this.accountId;
    data['company_id'] = this.companyId;
    data['is_closed'] = this.isClosed;
    data['created_by_employee_id'] = this.createdByEmployeeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_at_format'] = this.createdAtFormat;
    data['updated_at_format'] = this.updatedAtFormat;
    if (this.bugReportedSeverityData != null) {
      data['bug_severity_name_data'] = this.bugReportedSeverityData!.toJson();
    }
    if (this.bugReportedPriorityData != null) {
      data['bug_priority_data'] = this.bugReportedPriorityData!.toJson();
    }
    if (this.bugReportedStatusData != null) {
      data['bug_status_name_data'] = this.bugReportedStatusData!.toJson();
    }
    if (this.bugReportedDevicesData != null) {
      data['devices'] = this.bugReportedDevicesData!.map((v) => v.toJson()).toList();
    }
    if (this.bugReportedLablesData != null) {
      data['lables'] = this.bugReportedLablesData!.map((v) => v.toJson()).toList();
    }
    if (this.bugReportedFilesData != null) {
      data['bug_reports_files'] = this.bugReportedFilesData!.map((v) => v.toJson()).toList();
    }
    if (this.bugReportedFilesData != null) {
      data['bug_follow_ups'] = this.bugReportedFilesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<BugReported> listFromJson(dynamic json) {
    List<BugReported> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new BugReported.fromJson(v));
      });
    }
    return list;
  }
}

class BugReportedSeverityData {
  int? bugSeverityId;
  String? bugSeverityName;

  BugReportedSeverityData({
    this.bugSeverityId,
    this.bugSeverityName,
  });

  BugReportedSeverityData.fromJson(Map<String, dynamic> json) {
    bugSeverityId = json['bug_severity_id'];
    bugSeverityName = json['bug_severity_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_severity_id'] = this.bugSeverityId;
    data['bug_severity_name'] = this.bugSeverityName;
    return data;
  }
}

class BugReportedPriorityData {
  int? bugPriorityId;
  String? bugPriorityName;
  String? bugPriorityDescription;
  int? bugPriorityStatus;
  String? bugPriorityBgcolor;
  String? bugPriorityTextcolor;

  BugReportedPriorityData({
    this.bugPriorityId,
    this.bugPriorityName,
    this.bugPriorityDescription,
    this.bugPriorityStatus,
    this.bugPriorityBgcolor,
    this.bugPriorityTextcolor,
  });

  BugReportedPriorityData.fromJson(Map<String, dynamic> json) {
    bugPriorityId = json['bug_priority_id'];
    bugPriorityName = json['bug_priority_name'];
    bugPriorityDescription = json['bug_priority_description'];
    bugPriorityStatus = json['bug_priority_status'];
    bugPriorityBgcolor = json['bug_priority_bgcolor'];
    bugPriorityTextcolor = json['bug_priority_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_priority_id'] = this.bugPriorityId;
    data['bug_priority_name'] = this.bugPriorityName;
    data['bug_priority_description'] = this.bugPriorityDescription;
    data['bug_priority_status'] = this.bugPriorityStatus;
    data['bug_priority_bgcolor'] = this.bugPriorityBgcolor;
    data['bug_priority_textcolor'] = this.bugPriorityTextcolor;
    return data;
  }
}

class BugReportedStatusData {
  int? bugStatusId;
  String? bugStatusName;
  String? bugStatusDescription;
  String? bugStatusBgcolor;
  String? bugStatusTextcolor;

  BugReportedStatusData({
    this.bugStatusId,
    this.bugStatusName,
    this.bugStatusDescription,
    this.bugStatusBgcolor,
    this.bugStatusTextcolor,
  });

  BugReportedStatusData.fromJson(Map<String, dynamic> json) {
    bugStatusId = json['bug_status_id'];
    bugStatusName = json['bug_status_name'];
    bugStatusDescription = json['bug_status_description'];
    bugStatusBgcolor = json['bug_status_bgcolor'];
    bugStatusTextcolor = json['bug_status_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_status_id'] = this.bugStatusId;
    data['bug_status_name'] = this.bugStatusName;
    data['bug_status_description'] = this.bugStatusDescription;
    data['bug_status_bgcolor'] = this.bugStatusBgcolor;
    data['bug_status_textcolor'] = this.bugStatusTextcolor;
    return data;
  }
}

class BugReportedDevicesData {
  int? bugReportsDeviceMappingId;
  int? bugTicketId;
  int? deviceId;
  DeviceName? deviceName;

  BugReportedDevicesData({
    this.bugReportsDeviceMappingId,
    this.bugTicketId,
    this.deviceId,
    this.deviceName,
  });

  BugReportedDevicesData.fromJson(Map<String, dynamic> json) {
    bugReportsDeviceMappingId = json['bug_reports_device_mapping_id'];
    bugTicketId = json['bug_ticket_id'];
    deviceId = json['device_id'];
    deviceName = json['device_name'] != null ? new DeviceName.fromJson(json['device_name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_reports_device_mapping_id'] = this.bugReportsDeviceMappingId;
    data['bug_ticket_id'] = this.bugTicketId;
    data['device_id'] = this.deviceId;
    if (this.deviceName != null) {
      data['device_name'] = this.deviceName!.toJson();
    }
    return data;
  }
}

class DeviceName {
  int? deviceId;
  String? deviceName;
  int? deviceStatus;

  DeviceName({
    this.deviceId,
    this.deviceName,
    this.deviceStatus,
  });

  DeviceName.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    deviceName = json['device_name'];
    deviceStatus = json['device_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_id'] = this.deviceId;
    data['device_name'] = this.deviceName;
    data['device_status'] = this.deviceStatus;
    return data;
  }
}

class BugReportedLablesData {
  int? bugReportsLabelsMappingId;
  int? bugTicketId;
  int? bugLabelId;
  LabelName? labelName;

  BugReportedLablesData({
    this.bugReportsLabelsMappingId,
    this.bugTicketId,
    this.bugLabelId,
    this.labelName,
  });

  BugReportedLablesData.fromJson(Map<String, dynamic> json) {
    bugReportsLabelsMappingId = json['bug_reports_labels_mapping_id'];
    bugTicketId = json['bug_ticket_id'];
    bugLabelId = json['bug_label_id'];
    labelName = json['label_name'] != null ? new LabelName.fromJson(json['label_name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_reports_labels_mapping_id'] = this.bugReportsLabelsMappingId;
    data['bug_ticket_id'] = this.bugTicketId;
    data['bug_label_id'] = this.bugLabelId;
    if (this.labelName != null) {
      data['label_name'] = this.labelName!.toJson();
    }
    return data;
  }
}

class LabelName {
  int? bugLabelId;
  String? bugLabelName;
  String? bugLabelDescription;
  int? bugLabelStatus;
  String? bugLabelTextcolor;

  LabelName({
    this.bugLabelId,
    this.bugLabelName,
    this.bugLabelDescription,
    this.bugLabelStatus,
    this.bugLabelTextcolor,
  });

  LabelName.fromJson(Map<String, dynamic> json) {
    bugLabelId = json['bug_label_id'];
    bugLabelName = json['bug_label_name'];
    bugLabelDescription = json['bug_label_description'];
    bugLabelStatus = json['bug_label_status'];
    bugLabelTextcolor = json['bug_label_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_label_id'] = this.bugLabelId;
    data['bug_label_name'] = this.bugLabelName;
    data['bug_label_description'] = this.bugLabelDescription;
    data['bug_label_status'] = this.bugLabelStatus;
    data['bug_label_textcolor'] = this.bugLabelTextcolor;
    return data;
  }
}

class BugReportedFilesData {
  int? bugReportsFileId;
  int? bugTicketId;
  int? isFollowup;
  int? userId;
  String? isFollowupName;
  int? uploadedBy;
  String? uploadedByName;
  String? fileUrl;
  String? fileType;
  String? fileExtension;

  BugReportedFilesData({
    this.bugReportsFileId,
    this.bugTicketId,
    this.isFollowup,
    this.userId,
    this.isFollowupName,
    this.uploadedBy,
    this.uploadedByName,
    this.fileUrl,
    this.fileType,
    this.fileExtension,
  });

  BugReportedFilesData.fromJson(Map<String, dynamic> json) {
    bugReportsFileId = json['bug_reports_file_id'];
    bugTicketId = json['bug_ticket_id'];
    isFollowup = json['is_followup'];
    userId = json['user_id'];
    isFollowupName = json['is_followup_name'];
    uploadedBy = json['uploaded_by'];
    uploadedByName = json['uploaded_by_name'];
    fileUrl = json['file_url'];
    fileType = json['file_type'];
    fileExtension = json['file_extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_reports_file_id'] = this.bugReportsFileId;
    data['bug_ticket_id'] = this.bugTicketId;
    data['is_followup'] = this.isFollowup;
    data['user_id'] = this.userId;
    data['is_followup_name'] = this.isFollowupName;
    data['uploaded_by'] = this.uploadedBy;
    data['uploaded_by_name'] = this.uploadedByName;
    data['file_url'] = this.fileUrl;
    data['file_type'] = this.fileType;
    data['file_extension'] = this.fileExtension;
    return data;
  }
}

class BugFollowUpsData {
  int? bugFollowupsId;
  int? bugTicketId;
  int? uploadedBy;
  int? userId;
  int? bugStatusId;
  String? bugResponse;
  String? createdAtFormat;
  String? updatedAtFormat;
  BugStatusNameFollowUpData? bugStatusNameFollowUpData;
  List<BugFollowupReportsFiles>? bugFollowupReportsFiles;

  BugFollowUpsData({
    this.bugFollowupsId,
    this.bugTicketId,
    this.uploadedBy,
    this.userId,
    this.bugStatusId,
    this.bugResponse,
    this.createdAtFormat,
    this.updatedAtFormat,
    this.bugStatusNameFollowUpData,
    this.bugFollowupReportsFiles,
  });

  BugFollowUpsData.fromJson(Map<String, dynamic> json) {
    bugFollowupsId = json['bug_followups_id'];
    bugTicketId = json['bug_ticket_id'];
    uploadedBy = json['uploaded_by'];
    userId = json['user_id'];
    bugStatusId = json['bug_status_id'];
    bugResponse = json['bug_response'];
    createdAtFormat = json['created_at_format'];
    updatedAtFormat = json['updated_at_format'];
    bugStatusNameFollowUpData = json['bug_status_name_follow_up_data'] != null
        ? new BugStatusNameFollowUpData.fromJson(json['bug_status_name_follow_up_data'])
        : null;
    if (json['bug_followup_reports_files'] != null) {
      bugFollowupReportsFiles = <BugFollowupReportsFiles>[];
      json['bug_followup_reports_files'].forEach((v) {
        bugFollowupReportsFiles!.add(new BugFollowupReportsFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_followups_id'] = this.bugFollowupsId;
    data['bug_ticket_id'] = this.bugTicketId;
    data['uploaded_by'] = this.uploadedBy;
    data['user_id'] = this.userId;
    data['bug_status_id'] = this.bugStatusId;
    data['bug_response'] = this.bugResponse;
    data['created_at_format'] = this.createdAtFormat;
    data['updated_at_format'] = this.updatedAtFormat;
    if (this.bugStatusNameFollowUpData != null) {
      data['bug_status_name_follow_up_data'] = this.bugStatusNameFollowUpData!.toJson();
    }
    if (this.bugFollowupReportsFiles != null) {
      data['bug_followup_reports_files'] = this.bugFollowupReportsFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BugStatusNameFollowUpData {
  int? bugStatusId;
  String? bugStatusName;
  String? bugStatusDescription;
  int? bugStatusStatus;
  String? bugStatusBgcolor;
  String? bugStatusTextcolor;

  BugStatusNameFollowUpData({
    this.bugStatusId,
    this.bugStatusName,
    this.bugStatusDescription,
    this.bugStatusStatus,
    this.bugStatusBgcolor,
    this.bugStatusTextcolor,
  });

  BugStatusNameFollowUpData.fromJson(Map<String, dynamic> json) {
    bugStatusId = json['bug_status_id'];
    bugStatusName = json['bug_status_name'];
    bugStatusDescription = json['bug_status_description'];
    bugStatusStatus = json['bug_status_status'];
    bugStatusBgcolor = json['bug_status_bgcolor'];
    bugStatusTextcolor = json['bug_status_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_status_id'] = this.bugStatusId;
    data['bug_status_name'] = this.bugStatusName;
    data['bug_status_description'] = this.bugStatusDescription;
    data['bug_status_status'] = this.bugStatusStatus;
    data['bug_status_bgcolor'] = this.bugStatusBgcolor;
    data['bug_status_textcolor'] = this.bugStatusTextcolor;
    return data;
  }
}

class BugFollowupReportsFiles {
  int? bugReportsFileId;
  int? bugTicketId;
  int? isFollowup;
  int? bugFollowupsId;
  int? uploadedBy;
  int? userId;
  String? fileUrl;
  String? fileType;
  String? fileExtension;
  String? createdAt;

  BugFollowupReportsFiles({
    this.bugReportsFileId,
    this.bugTicketId,
    this.isFollowup,
    this.bugFollowupsId,
    this.uploadedBy,
    this.userId,
    this.fileUrl,
    this.fileType,
    this.fileExtension,
    this.createdAt,
  });

  BugFollowupReportsFiles.fromJson(Map<String, dynamic> json) {
    bugReportsFileId = json['bug_reports_file_id'];
    bugTicketId = json['bug_ticket_id'];
    isFollowup = json['is_followup'];
    bugFollowupsId = json['bug_followups_id'];
    uploadedBy = json['uploaded_by'];
    userId = json['user_id'];
    fileUrl = json['file_url'];
    fileType = json['file_type'];
    fileExtension = json['file_extension'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_reports_file_id'] = this.bugReportsFileId;
    data['bug_ticket_id'] = this.bugTicketId;
    data['is_followup'] = this.isFollowup;
    data['bug_followups_id'] = this.bugFollowupsId;
    data['uploaded_by'] = this.uploadedBy;
    data['user_id'] = this.userId;
    data['file_url'] = this.fileUrl;
    data['file_type'] = this.fileType;
    data['file_extension'] = this.fileExtension;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class BugReportLinks {
  String? url;
  String? label;
  bool? active;

  BugReportLinks({
    this.url,
    this.label,
    this.active,
  });

  BugReportLinks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
