class BugDevice {
  int? deviceId;
  String? deviceName;

  BugDevice({
    this.deviceId,
    this.deviceName,
  });

  BugDevice.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    deviceName = json['device_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_id'] = this.deviceId;
    data['device_name'] = this.deviceName;
    return data;
  }

  static List<BugDevice> listFromJson(dynamic json) {
    List<BugDevice> list = [];
    if (json['device_master'] != null) {
      json['device_master'].forEach((v) {
        list.add(new BugDevice.fromJson(v));
      });
    }
    return list;
  }
}
