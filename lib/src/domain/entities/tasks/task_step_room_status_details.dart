class TaskStepRoomStatusDetails {
  int? currentRoomHousekeepingStatusId;
  int? isRoomStatusUpdated;
  int? updatedRoomHousekeepingStatusId;
  String? currentRoomHousekeepingStatusText;
  String? updatedRoomHousekeepingStatusText;
  int? roomHkStatusId;

  TaskStepRoomStatusDetails({
    this.currentRoomHousekeepingStatusId,
    this.isRoomStatusUpdated,
    this.updatedRoomHousekeepingStatusId,
    this.currentRoomHousekeepingStatusText,
    this.updatedRoomHousekeepingStatusText,
    this.roomHkStatusId,
  });

  TaskStepRoomStatusDetails.fromJson(Map<String, dynamic> json) {
    currentRoomHousekeepingStatusId = json['current_room_housekeeping_status_id'];
    isRoomStatusUpdated = json['is_room_status_updated'];
    updatedRoomHousekeepingStatusId = json['updated_room_housekeeping_status_id'];
    currentRoomHousekeepingStatusText = json['current_room_housekeeping_status_text'];
    updatedRoomHousekeepingStatusText = json['updated_room_housekeeping_status_text'];
    roomHkStatusId = json['room_hk_status_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_room_housekeeping_status_id'] = this.currentRoomHousekeepingStatusId;
    data['is_room_status_updated'] = this.isRoomStatusUpdated;
    data['updated_room_housekeeping_status_id'] = this.updatedRoomHousekeepingStatusId;
    data['current_room_housekeeping_status_text'] = this.currentRoomHousekeepingStatusText;
    data['updated_room_housekeeping_status_text'] = this.updatedRoomHousekeepingStatusText;
    data['room_hk_status_id'] = this.roomHkStatusId;
    return data;
  }
}
