class LeaveReason {
  int? shiftLeaveReasonId;
  String? shiftLeaveReasonName;

  LeaveReason({
    this.shiftLeaveReasonId,
    this.shiftLeaveReasonName,
  });

  LeaveReason.fromJson(Map<String, dynamic> json) {
    shiftLeaveReasonId = json['shift_leave_reason_id'];
    shiftLeaveReasonName = json['shift_leave_reason_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shift_leave_reason_id'] = this.shiftLeaveReasonId;
    data['shift_leave_reason_name'] = this.shiftLeaveReasonName;
    return data;
  }

  static List<LeaveReason> listFromJson(dynamic json) {
    List<LeaveReason> list = [];
    if (json['shift_leave_reason_master'] != null) {
      json['shift_leave_reason_master'].forEach((v) {
        list.add(new LeaveReason.fromJson(v));
      });
    }
    return list;
  }
}
