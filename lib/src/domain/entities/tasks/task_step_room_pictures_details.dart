class TaskStepRoomPicturesDetails {
  int? internalRoomId;
  String? internalRoomName;
  List<TaskStepRoomAsset>? assets;

  TaskStepRoomPicturesDetails({
    this.internalRoomId,
    this.internalRoomName,
    this.assets,
  });

  TaskStepRoomPicturesDetails.fromJson(Map<String, dynamic> json) {
    internalRoomId = json['internal_room_id'];
    internalRoomName = json['internal_room_name'];
    if (json['assets'] != null) {
      assets = <TaskStepRoomAsset>[];
      json['assets'].forEach((v) {
        assets!.add(new TaskStepRoomAsset.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['internal_room_id'] = this.internalRoomId;
    data['internal_room_name'] = this.internalRoomName;
    if (this.assets != null) {
      data['assets'] = this.assets!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<TaskStepRoomPicturesDetails> listFromJson(dynamic json) {
    List<TaskStepRoomPicturesDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new TaskStepRoomPicturesDetails.fromJson(v));
      });
    }
    return list;
  }
}

class TaskStepRoomAsset {
  int? assetId;
  String? assetName;
  String? assetDescription;
  String? assetFileUrl;
  String? assetType;
  String? assetMimeType;
  int? assetFileSize;

  TaskStepRoomAsset({
    this.assetId,
    this.assetName,
    this.assetDescription,
    this.assetFileUrl,
    this.assetType,
    this.assetMimeType,
    this.assetFileSize,
  });

  TaskStepRoomAsset.fromJson(Map<String, dynamic> json) {
    assetId = json['asset_id'];
    assetName = json['asset_name'];
    assetDescription = json['asset_description'];
    assetFileUrl = json['asset_file_url'];
    assetType = json['asset_type'];
    assetMimeType = json['asset_mime_type'];
    assetFileSize = json['asset_file_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset_id'] = this.assetId;
    data['asset_name'] = this.assetName;
    data['asset_description'] = this.assetDescription;
    data['asset_file_url'] = this.assetFileUrl;
    data['asset_type'] = this.assetType;
    data['asset_mime_type'] = this.assetMimeType;
    data['asset_file_size'] = this.assetFileSize;
    return data;
  }
}
