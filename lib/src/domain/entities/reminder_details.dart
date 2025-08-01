import 'dart:convert';

class ReminderDetails {
  String? id;
  String? title;
  String? description;
  String? dateTime;
  String? route;
  String? recurring;
  String? snoozeDuration;
  bool? isSnoozeActive;
  bool? isEmergency;

  ReminderDetails({
    this.id,
    this.title,
    this.description,
    this.dateTime,
    this.route,
    this.recurring,
    this.snoozeDuration,
    this.isSnoozeActive,
    this.isEmergency,
  });

  ReminderDetails copyWith({
    String? id,
    String? title,
    String? description,
    String? dateTime,
    String? route,
    String? recurring,
    String? snoozeDuration,
    bool? isSnoozeActive,
    bool? isEmergency,
  }) {
    return ReminderDetails(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      route: route ?? this.route,
      recurring: recurring ?? this.recurring,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
      isSnoozeActive: isSnoozeActive ?? this.isSnoozeActive,
      isEmergency: isEmergency ?? this.isEmergency,
    );
  }

  ReminderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    dateTime = json['dateTime'];
    route = json['route'];
    recurring = json['recurring'];
    snoozeDuration = json['snoozeDuration'];
    isSnoozeActive = json['isSnoozeActive'];
    isEmergency = json['isEmergency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['dateTime'] = this.dateTime;
    data['route'] = this.route;
    data['recurring'] = this.recurring;
    data['snoozeDuration'] = this.snoozeDuration;
    data['isSnoozeActive'] = this.isSnoozeActive;
    data['isEmergency'] = this.isEmergency;
    return data;
  }

  static List<ReminderDetails> listFromJson(dynamic json) {
    List<ReminderDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new ReminderDetails.fromJson(jsonDecode(v)));
      });
    }
    return list;
  }

  static List<String> listToJson(List<ReminderDetails>? reminders) {
    List<String> list = [];
    if (reminders != null) {
      reminders.forEach((reminder) {
        list.add(jsonEncode(reminder.toJson()));
      });
    }
    return list;
  }
}
