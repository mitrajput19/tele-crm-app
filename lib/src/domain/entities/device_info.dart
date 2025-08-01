class DeviceInfo {
  String? deviceName;
  String? deviceModel;
  String? deviceVersion;

  DeviceInfo({
    this.deviceName,
    this.deviceModel,
    this.deviceVersion,
  });

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceName = json['device_name'];
    deviceModel = json['device_model'];
    deviceVersion = json['device_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_name'] = this.deviceName;
    data['device_model'] = this.deviceModel;
    data['device_version'] = this.deviceVersion;
    return data;
  }

  @override
  String toString() => '$deviceName - $deviceModel - $deviceVersion';
}
