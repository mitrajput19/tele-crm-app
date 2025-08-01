class RequestDetails {
  int? requestId;
  String? status;
  StatusColor? colors;
  String? numberOfPeople;
  String? finalDuration;
  String? deadline;
  String? referenceNumber;
  RequestPriorityData? priority;
  RequestTypeData? requestType;
  RequestLocationData? location;
  RequestTimestamp? timestamps;
  List<RequestFile>? files;
  String? notes;

  RequestDetails({
    this.requestId,
    this.status,
    this.colors,
    this.numberOfPeople,
    this.finalDuration,
    this.deadline,
    this.priority,
    this.referenceNumber,
    this.requestType,
    this.location,
    this.timestamps,
    this.files,
    this.notes,
  });

  RequestDetails.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    status = json['status'];
    colors = json['colors'] != null ? new StatusColor.fromJson(json['colors']) : null;
    numberOfPeople = json['number_of_people'];
    finalDuration = json['final_duration'];
    deadline = json['deadline'];
    referenceNumber = json['reference_number'];
    priority = json['priority'] != null ? new RequestPriorityData.fromJson(json['priority']) : null;
    requestType = json['request_type'] != null ? new RequestTypeData.fromJson(json['request_type']) : null;
    location = json['location'] != null ? new RequestLocationData.fromJson(json['location']) : null;
    timestamps = json['timestamps'] != null ? new RequestTimestamp.fromJson(json['timestamps']) : null;
    if (json['files'] != null) {
      files = <RequestFile>[];
      json['files'].forEach((v) {
        files!.add(new RequestFile.fromJson(v));
      });
    }
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['status'] = this.status;
    if (this.colors != null) {
      data['colors'] = this.colors!.toJson();
    }
    data['number_of_people'] = this.numberOfPeople;
    data['final_duration'] = this.finalDuration;
    data['deadline'] = this.deadline;
    data['reference_number'] = this.referenceNumber;
    if (this.priority != null) {
      data['priority'] = this.priority!.toJson();
    }
    if (this.requestType != null) {
      data['request_type'] = this.requestType!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.timestamps != null) {
      data['timestamps'] = this.timestamps!.toJson();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['notes'] = this.notes;
    return data;
  }

  static List<RequestDetails> listFromJson(dynamic json) {
    List<RequestDetails> list = [];
    if (json['requests'] != null) {
      json['requests'].forEach((v) {
        list.add(new RequestDetails.fromJson(v));
      });
    }
    return list;
  }

  bool get hasMoreData {
    return _hasData(referenceNumber) ||
        _hasData(deadline) ||
        _hasData(numberOfPeople) ||
        _hasData(finalDuration) ||
        _hasData(notes) ||
        (files != null && files!.isNotEmpty);
  }

  bool _hasData(String? value) {
    return value != null && value.isNotEmpty && value != '-';
  }
}

class RequestFile {
  int? assetId;
  String? fileName;
  String? fileType;
  String? fileUrl;

  RequestFile({
    this.assetId,
    this.fileName,
    this.fileType,
    this.fileUrl,
  });

  RequestFile.fromJson(Map<String, dynamic> json) {
    assetId = json['asset_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset_id'] = this.assetId;
    data['file_name'] = this.fileName;
    data['file_type'] = this.fileType;
    data['file_url'] = this.fileUrl;
    return data;
  }
}

class RequestPriorityData {
  int? id;
  String? name;
  StatusColor? colors;

  RequestPriorityData({
    this.id,
    this.name,
    this.colors,
  });

  RequestPriorityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    colors = json['colors'] != null ? new StatusColor.fromJson(json['colors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.colors != null) {
      data['colors'] = this.colors!.toJson();
    }
    return data;
  }
}

class RequestTypeData {
  int? id;
  String? name;
  int? categoryId;
  String? categoryName;
  String? categoryIcon;

  RequestTypeData({
    this.id,
    this.name,
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
  });

  RequestTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryIcon = json['category_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_icon'] = this.categoryIcon;
    return data;
  }
}

class RequestLocationData {
  String? type;
  int? id;
  String? details;

  RequestLocationData({
    this.type,
    this.id,
    this.details,
  });

  RequestLocationData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['details'] = this.details;
    return data;
  }
}

class RequestFileData {
  int? assetId;
  String? fileName;
  String? fileType;
  String? fileUrl;

  RequestFileData({
    this.assetId,
    this.fileName,
    this.fileType,
    this.fileUrl,
  });

  RequestFileData.fromJson(Map<String, dynamic> json) {
    assetId = json['asset_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset_id'] = this.assetId;
    data['file_name'] = this.fileName;
    data['file_type'] = this.fileType;
    data['file_url'] = this.fileUrl;
    return data;
  }
}

class RequestTimestamp {
  String? createdAt;
  String? createdAtDisplay;
  String? updatedAt;
  String? updatedAtDisplay;

  RequestTimestamp({
    this.createdAt,
    this.createdAtDisplay,
    this.updatedAt,
    this.updatedAtDisplay,
  });

  RequestTimestamp.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    createdAtDisplay = json['created_at_display'];
    updatedAt = json['updated_at'];
    updatedAtDisplay = json['updated_at_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['created_at_display'] = this.createdAtDisplay;
    data['updated_at'] = this.updatedAt;
    data['updated_at_display'] = this.updatedAtDisplay;
    return data;
  }
}

class StatusColor {
  String? background;
  String? foreground;

  StatusColor({this.background, this.foreground});

  StatusColor.fromJson(Map<String, dynamic> json) {
    background = json['background'];
    foreground = json['foreground'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['background'] = this.background;
    data['foreground'] = this.foreground;
    return data;
  }
}
