// class EmployeeShiftBreakDetails {
//   int? employeeShiftBreakTimingId;
//   int? employeeShiftDetailId;
//   int? shiftBreakTypeId;
//   String? shiftBreakTypeName;
//   String? shiftBreakStartTime;
//   String? shiftBreakEndTime;
//   String? timeDifferenceConverted;
//   String? shiftBreakStartDisplayTime;
//   String? shiftBreakEndDisplayTime;

//   EmployeeShiftBreakDetails({
//     this.employeeShiftBreakTimingId,
//     this.employeeShiftDetailId,
//     this.shiftBreakTypeId,
//     this.shiftBreakTypeName,
//     this.shiftBreakStartTime,
//     this.shiftBreakEndTime,
//     this.timeDifferenceConverted,
//     this.shiftBreakStartDisplayTime,
//     this.shiftBreakEndDisplayTime,
//   });

//   EmployeeShiftBreakDetails.fromJson(Map<String, dynamic> json) {
//     employeeShiftBreakTimingId = json['employee_shift_break_timing_id'];
//     employeeShiftDetailId = json['employee_shift_detail_id'];
//     shiftBreakTypeId = json['shift_break_type_id'];
//     shiftBreakTypeName = json['shift_break_type_name'];
//     shiftBreakStartTime = json['shift_break_start_time'];
//     shiftBreakEndTime = json['shift_break_end_time'];
//     timeDifferenceConverted = json['time_difference_converted'];
//     shiftBreakStartDisplayTime = json['shift_break_start_display_time'];
//     shiftBreakEndDisplayTime = json['shift_break_end_display_time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['employee_shift_break_timing_id'] = this.employeeShiftBreakTimingId;
//     data['employee_shift_detail_id'] = this.employeeShiftDetailId;
//     data['shift_break_type_id'] = this.shiftBreakTypeId;
//     data['shift_break_type_name'] = this.shiftBreakTypeName;
//     data['shift_break_start_time'] = this.shiftBreakStartTime;
//     data['shift_break_end_time'] = this.shiftBreakEndTime;
//     data['time_difference_converted'] = this.timeDifferenceConverted;
//     data['shift_break_start_display_time'] = this.shiftBreakStartDisplayTime;
//     data['shift_break_end_display_time'] = this.shiftBreakEndDisplayTime;
//     return data;
//   }

//   static List<EmployeeShiftBreakDetails> listFromJson(dynamic json) {
//     List<EmployeeShiftBreakDetails> list = [];
//     if (json['data'] != null) {
//       json['data'].forEach((v) {
//         list.add(new EmployeeShiftBreakDetails.fromJson(v));
//       });
//     }
//     return list;
//   }
// }
