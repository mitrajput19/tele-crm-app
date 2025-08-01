class AppNotificationDetails {
  int? notificationId;
  int? companyId;
  int? addedByEmployeeId;
  int? employeeId;
  int? showOnWeb;
  int? showOnApp;
  int? readStatus;
  String? notificationCode;
  String? notificationTitle;
  String? notificationDescription;
  String? notificationType;
  String? createdAt;
  NotificationFirebaseData? notificationFirebaseData;

  AppNotificationDetails({
    this.notificationId,
    this.companyId,
    this.addedByEmployeeId,
    this.employeeId,
    this.showOnWeb,
    this.showOnApp,
    this.readStatus,
    this.notificationCode,
    this.notificationTitle,
    this.notificationDescription,
    this.notificationType,
    this.createdAt,
    this.notificationFirebaseData,
  });

  AppNotificationDetails.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    companyId = json['company_id'];
    addedByEmployeeId = json['added_by_employee_id'];
    employeeId = json['employee_id'];
    showOnWeb = json['show_on_web'];
    showOnApp = json['show_on_app'];
    readStatus = json['read_status'];
    notificationCode = json['notification_code'];
    notificationTitle = json['notification_title'];
    notificationDescription = json['notification_description'];
    notificationType = json['notification_type'];
    createdAt = json['created_at'];
    notificationFirebaseData = json['notification_firebase_data'] != null
        ? new NotificationFirebaseData.fromJson(json['notification_firebase_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['company_id'] = this.companyId;
    data['added_by_employee_id'] = this.addedByEmployeeId;
    data['employee_id'] = this.employeeId;
    data['show_on_web'] = this.showOnWeb;
    data['show_on_app'] = this.showOnApp;
    data['read_status'] = this.readStatus;
    data['notification_code'] = this.notificationCode;
    data['notification_title'] = this.notificationTitle;
    data['notification_description'] = this.notificationDescription;
    data['notification_type'] = this.notificationType;
    data['created_at'] = this.createdAt;
    if (this.notificationFirebaseData != null) {
      data['notification_firebase_data'] = this.notificationFirebaseData!.toJson();
    }
    return data;
  }

  static List<AppNotificationDetails> listFromJson(dynamic json) {
    List<AppNotificationDetails> list = [];
    if (json['details']['notifications'] != null) {
      json['details']['notifications'].forEach((v) {
        list.add(new AppNotificationDetails.fromJson(v));
      });
    }
    return list;
  }
}

class NotificationFirebaseData {
  String? title;
  String? text;
  String? body;
  String? image;
  String? hasImage;
  String? sound;
  String? priority;
  String? badge;
  String? mutableContent;
  String? clickAction;
  String? isSave;
  dynamic additionalData;

  NotificationFirebaseData({
    this.title,
    this.text,
    this.body,
    this.image,
    this.hasImage,
    this.sound,
    this.priority,
    this.badge,
    this.mutableContent,
    this.clickAction,
    this.isSave,
    this.additionalData,
  });

  NotificationFirebaseData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    body = json['body'];
    image = json['image'];
    hasImage = json['has_image'];
    sound = json['sound'];
    priority = json['priority'];
    badge = json['badge'];
    mutableContent = json['mutable_content'];
    clickAction = json['click_action'];
    isSave = json['is_save'];
    additionalData = json['additional_data'] != null ? {} : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['body'] = this.body;
    data['image'] = this.image;
    data['has_image'] = this.hasImage;
    data['sound'] = this.sound;
    data['priority'] = this.priority;
    data['badge'] = this.badge;
    data['mutable_content'] = this.mutableContent;
    data['click_action'] = this.clickAction;
    data['is_save'] = this.isSave;
    if (this.additionalData != null) {
      data['additional_data'] = this.additionalData!.toJson();
    }
    return data;
  }
}
