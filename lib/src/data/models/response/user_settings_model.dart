class UserSettings {
  final String? id;
  final String? userId;
  final String? callRecordingPath;
  final String? deviceModel;
  final String? deviceBrand;
  final String? osVersion;
  final String? appVersion;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserSettings({
    this.id,
    this.userId,
    this.callRecordingPath,
    this.deviceModel,
    this.deviceBrand,
    this.osVersion,
    this.appVersion,
    this.createdAt,
    this.updatedAt,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      id: json['id'],
      userId: json['user_id'],
      callRecordingPath: json['call_recording_path'],
      deviceModel: json['device_model'],
      deviceBrand: json['device_brand'],
      osVersion: json['os_version'],
      appVersion: json['app_version'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'call_recording_path': callRecordingPath,
      'device_model': deviceModel,
      'device_brand': deviceBrand,
      'os_version': osVersion,
      'app_version': appVersion,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  UserSettings copyWith({
    String? id,
    String? userId,
    String? callRecordingPath,
    String? deviceModel,
    String? deviceBrand,
    String? osVersion,
    String? appVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserSettings(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      callRecordingPath: callRecordingPath ?? this.callRecordingPath,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceBrand: deviceBrand ?? this.deviceBrand,
      osVersion: osVersion ?? this.osVersion,
      appVersion: appVersion ?? this.appVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}