class RemoteConfigAppStatusData {
  bool? maintenanceStatus;
  String? maintenanceTitle;
  String? maintenanceDescription;

  RemoteConfigAppStatusData({
    this.maintenanceStatus,
    this.maintenanceTitle,
    this.maintenanceDescription,
  });

  RemoteConfigAppStatusData.fromJson(Map<String, dynamic> json) {
    maintenanceStatus = json['maintenance_status'];
    maintenanceTitle = json['maintenance_title'];
    maintenanceDescription = json['maintenance_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_status'] = this.maintenanceStatus;
    data['maintenance_title'] = this.maintenanceTitle;
    data['maintenance_description'] = this.maintenanceDescription;
    return data;
  }
}
