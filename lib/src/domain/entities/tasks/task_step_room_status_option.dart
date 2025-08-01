class TaskStepRoomStatusOption {
  int? roomHousekeepingStatusId;
  String? roomHousekeepingStatusName;

  TaskStepRoomStatusOption({
    this.roomHousekeepingStatusId,
    this.roomHousekeepingStatusName,
  });

  TaskStepRoomStatusOption.fromJson(Map<String, dynamic> json) {
    roomHousekeepingStatusId = json['room_housekeeping_status_id'];
    roomHousekeepingStatusName = json['room_housekeeping_status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_housekeeping_status_id'] = this.roomHousekeepingStatusId;
    data['room_housekeeping_status_name'] = this.roomHousekeepingStatusName;
    return data;
  }

  static List<TaskStepRoomStatusOption> listFromJson(dynamic json) {
    List<TaskStepRoomStatusOption> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new TaskStepRoomStatusOption.fromJson(v));
      });
    }
    return list;
  }
}
