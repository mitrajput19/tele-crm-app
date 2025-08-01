class RoomAvailabilityDetails {
  int? roomCategoryId;
  String? roomCategoryName;
  List<GuestRooms>? rooms;

  RoomAvailabilityDetails({
    this.roomCategoryId,
    this.roomCategoryName,
    this.rooms,
  });

  RoomAvailabilityDetails.fromJson(Map<String, dynamic> json) {
    roomCategoryId = json['room_category_id'];
    roomCategoryName = json['room_category_name'];
    if (json['rooms'] != null) {
      rooms = <GuestRooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new GuestRooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_category_id'] = this.roomCategoryId;
    data['room_category_name'] = this.roomCategoryName;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<RoomAvailabilityDetails> listFromJson(dynamic json) {
    List<RoomAvailabilityDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new RoomAvailabilityDetails.fromJson(v));
      });
    }
    return list;
  }
}

class GuestRooms {
  int? roomNumberId;
  String? roomNumberName;
  List<GuestRoomAvailability>? availability;

  GuestRooms({
    this.roomNumberId,
    this.roomNumberName,
    this.availability,
  });

  GuestRooms.fromJson(Map<String, dynamic> json) {
    roomNumberId = json['room_number_id'];
    roomNumberName = json['room_number_name'];
    if (json['availability'] != null) {
      availability = <GuestRoomAvailability>[];
      json['availability'].forEach((v) {
        availability!.add(new GuestRoomAvailability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_number_id'] = this.roomNumberId;
    data['room_number_name'] = this.roomNumberName;
    if (this.availability != null) {
      data['availability'] = this.availability!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GuestRoomAvailability {
  String? dateOfAvailability;
  int? availabilityStatus;
  String? availabilityStatusDisplay;
  String? availabilityStatusBgColor;
  String? availabilityStatusTextColor;
  String? notAvailableReasonStatus;
  String? notAvailableReasonStatusDisplay;
  String? notAvailableReasonStatusBgColor;
  String? notAvailableReasonStatusTextColor;
  int? bookableViaPms;
  int? bookableViaCm;
  int? bookableViaWhiteLabeledWebsite;
  int? bookableViaWhiteLabeledApp;
  String? additionalNotes;

  GuestRoomAvailability({
    this.dateOfAvailability,
    this.availabilityStatus,
    this.availabilityStatusDisplay,
    this.availabilityStatusBgColor,
    this.availabilityStatusTextColor,
    this.notAvailableReasonStatus,
    this.notAvailableReasonStatusDisplay,
    this.notAvailableReasonStatusBgColor,
    this.notAvailableReasonStatusTextColor,
    this.bookableViaPms,
    this.bookableViaCm,
    this.bookableViaWhiteLabeledWebsite,
    this.bookableViaWhiteLabeledApp,
    this.additionalNotes,
  });

  GuestRoomAvailability.fromJson(Map<String, dynamic> json) {
    dateOfAvailability = json['date_of_availability'];
    availabilityStatus = json['availability_status'];
    availabilityStatusDisplay = json['availability_status_display'];
    availabilityStatusBgColor = json['availability_status_bg_color'];
    availabilityStatusTextColor = json['availability_status_text_color'];
    notAvailableReasonStatus = json['not_available_reason_status'];
    notAvailableReasonStatusDisplay = json['not_available_reason_status_display'];
    notAvailableReasonStatusBgColor = json['not_available_reason_status_bg_color'];
    notAvailableReasonStatusTextColor = json['not_available_reason_status_text_color'];
    bookableViaPms = json['bookable_via_pms'];
    bookableViaCm = json['bookable_via_cm'];
    bookableViaWhiteLabeledWebsite = json['bookable_via_white_labeled_website'];
    bookableViaWhiteLabeledApp = json['bookable_via_white_labeled_app'];
    additionalNotes = json['additional_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_of_availability'] = this.dateOfAvailability;
    data['availability_status'] = this.availabilityStatus;
    data['availability_status_display'] = this.availabilityStatusDisplay;
    data['availability_status_bg_color'] = this.availabilityStatusBgColor;
    data['availability_status_text_color'] = this.availabilityStatusTextColor;
    data['not_available_reason_status'] = this.notAvailableReasonStatus;
    data['not_available_reason_status_display'] = this.notAvailableReasonStatusDisplay;
    data['not_available_reason_status_bg_color'] = this.notAvailableReasonStatusBgColor;
    data['not_available_reason_status_text_color'] = this.notAvailableReasonStatusTextColor;
    data['bookable_via_pms'] = this.bookableViaPms;
    data['bookable_via_cm'] = this.bookableViaCm;
    data['bookable_via_white_labeled_website'] = this.bookableViaWhiteLabeledWebsite;
    data['bookable_via_white_labeled_app'] = this.bookableViaWhiteLabeledApp;
    data['additional_notes'] = this.additionalNotes;
    return data;
  }
}
