class NotificationsStatus {
  bool? isAppNotificationEnabled;
  bool? isGeneralNotificationEnabled;
  bool? isShiftNotificationEnabled;
  bool? isTaskNotificationEnabled;
  bool? isChatNotificationEnabled;

  NotificationsStatus({
    this.isAppNotificationEnabled,
    this.isGeneralNotificationEnabled,
    this.isShiftNotificationEnabled,
    this.isTaskNotificationEnabled,
    this.isChatNotificationEnabled,
  });

  NotificationsStatus.fromJson(Map<String, dynamic> json) {
    isAppNotificationEnabled = json['isAppNotificationEnabled'];
    isGeneralNotificationEnabled = json['isGeneralNotificationEnabled'];
    isShiftNotificationEnabled = json['isShiftNotificationEnabled'];
    isTaskNotificationEnabled = json['isTaskNotificationEnabled'];
    isChatNotificationEnabled = json['isChatNotificationEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAppNotificationEnabled'] = this.isAppNotificationEnabled;
    data['isGeneralNotificationEnabled'] = this.isGeneralNotificationEnabled;
    data['isShiftNotificationEnabled'] = this.isShiftNotificationEnabled;
    data['isTaskNotificationEnabled'] = this.isTaskNotificationEnabled;
    data['isChatNotificationEnabled'] = this.isChatNotificationEnabled;
    return data;
  }

  NotificationsStatus copyWith({
    bool? isAppNotificationEnabled,
    bool? isGeneralNotificationEnabled,
    bool? isShiftNotificationEnabled,
    bool? isTaskNotificationEnabled,
    bool? isChatNotificationEnabled,
  }) {
    return NotificationsStatus(
      isAppNotificationEnabled: isAppNotificationEnabled ?? this.isAppNotificationEnabled,
      isGeneralNotificationEnabled: isGeneralNotificationEnabled ?? this.isGeneralNotificationEnabled,
      isShiftNotificationEnabled: isShiftNotificationEnabled ?? this.isShiftNotificationEnabled,
      isTaskNotificationEnabled: isTaskNotificationEnabled ?? this.isTaskNotificationEnabled,
      isChatNotificationEnabled: isChatNotificationEnabled ?? this.isChatNotificationEnabled,
    );
  }
}
