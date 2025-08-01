class AccounManager {
  int? i4roomsHotelAccountManagerId;
  int? fourroomsStaffId;
  int? managerType;
  String? managerTypeName;
  StaffDetails? staffDetails;

  AccounManager({
    this.i4roomsHotelAccountManagerId,
    this.fourroomsStaffId,
    this.managerType,
    this.managerTypeName,
    this.staffDetails,
  });

  AccounManager.fromJson(Map<String, dynamic> json) {
    i4roomsHotelAccountManagerId = json['4rooms_hotel_account_manager_id'];
    fourroomsStaffId = json['fourrooms_staff_id'];
    managerType = json['manager_type'];
    managerTypeName = json['manager_type_name'];
    staffDetails = json['staff_details'] != null ? new StaffDetails.fromJson(json['staff_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['4rooms_hotel_account_manager_id'] = this.i4roomsHotelAccountManagerId;
    data['fourrooms_staff_id'] = this.fourroomsStaffId;
    data['manager_type'] = this.managerType;
    data['manager_type_name'] = this.managerTypeName;
    if (this.staffDetails != null) {
      data['staff_details'] = this.staffDetails!.toJson();
    }
    return data;
  }

  static List<AccounManager> listFromJson(dynamic json) {
    List<AccounManager> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new AccounManager.fromJson(v));
      });
    }
    return list;
  }
}

class StaffDetails {
  int? fourroomsStaffId;
  String? fourroomsStaffName;
  String? fourroomsStaffEmail;
  int? fourroomsStaffStatus;

  StaffDetails({
    this.fourroomsStaffId,
    this.fourroomsStaffName,
    this.fourroomsStaffEmail,
    this.fourroomsStaffStatus,
  });

  StaffDetails.fromJson(Map<String, dynamic> json) {
    fourroomsStaffId = json['fourrooms_staff_id'];
    fourroomsStaffName = json['fourrooms_staff_name'];
    fourroomsStaffEmail = json['fourrooms_staff_email'];
    fourroomsStaffStatus = json['fourrooms_staff_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fourrooms_staff_id'] = this.fourroomsStaffId;
    data['fourrooms_staff_name'] = this.fourroomsStaffName;
    data['fourrooms_staff_email'] = this.fourroomsStaffEmail;
    data['fourrooms_staff_status'] = this.fourroomsStaffStatus;
    return data;
  }
}
