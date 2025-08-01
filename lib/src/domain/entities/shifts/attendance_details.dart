// class AttendanceDetails {
//   int? employeeShiftAttendanceId;
//   int? employeeShiftDetailId;
//   int? employeeId;
//   String? eventType;
//   String? eventDatetime;
//   String? comments;
//   String? latitude;
//   String? longitude;
//   String? eventDatetimeDisplay;

//   AttendanceDetails({
//     this.employeeShiftAttendanceId,
//     this.employeeShiftDetailId,
//     this.employeeId,
//     this.eventType,
//     this.eventDatetime,
//     this.comments,
//     this.latitude,
//     this.longitude,
//     this.eventDatetimeDisplay,
//   });

//   AttendanceDetails.fromJson(Map<String, dynamic> json) {
//     employeeShiftAttendanceId = json['employee_shift_attendance_id'];
//     employeeShiftDetailId = json['employee_shift_detail_id'];
//     employeeId = json['employee_id'];
//     eventType = json['event_type'];
//     eventDatetime = json['event_datetime'];
//     comments = json['comments'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     eventDatetimeDisplay = json['event_datetime_display'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['employee_shift_attendance_id'] = this.employeeShiftAttendanceId;
//     data['employee_shift_detail_id'] = this.employeeShiftDetailId;
//     data['employee_id'] = this.employeeId;
//     data['event_type'] = this.eventType;
//     data['event_datetime'] = this.eventDatetime;
//     data['comments'] = this.comments;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['event_datetime_display'] = this.eventDatetimeDisplay;
//     return data;
//   }

//   static List<AttendanceDetails> listFromJson(dynamic json) {
//     List<AttendanceDetails> list = [];
//     if (json['attendance_details'] != null) {
//       json['attendance_details'].forEach((v) {
//         list.add(new AttendanceDetails.fromJson(v));
//       });
//     }
//     return list;
//   }
// }
