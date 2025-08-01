import '../../app/app.dart';

class FrontDeskDetails {
  List<FrontDeskRoomCategoryAndRooms>? roomCategoryAndRooms;
  List<FrontDeskRoomReservations>? roomReservations;
  List<FrontDeskRoomBlocks>? roomBlocks;

  FrontDeskDetails({
    this.roomCategoryAndRooms,
    this.roomReservations,
    this.roomBlocks,
  });

  FrontDeskDetails.fromJson(Map<String, dynamic> json) {
    if (json['room_category_and_rooms'] != null) {
      roomCategoryAndRooms = <FrontDeskRoomCategoryAndRooms>[];
      json['room_category_and_rooms'].forEach((v) {
        roomCategoryAndRooms!.add(new FrontDeskRoomCategoryAndRooms.fromJson(v));
      });
    }
    if (json['room_reservations'] != null) {
      roomReservations = <FrontDeskRoomReservations>[];
      json['room_reservations'].forEach((v) {
        roomReservations!.add(new FrontDeskRoomReservations.fromJson(v));
      });
    }
    if (json['room_blocks'] != null) {
      roomBlocks = <FrontDeskRoomBlocks>[];
      json['room_blocks'].forEach((v) {
        roomBlocks!.add(new FrontDeskRoomBlocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roomCategoryAndRooms != null) {
      data['room_category_and_rooms'] = this.roomCategoryAndRooms!.map((v) => v.toJson()).toList();
    }
    if (this.roomReservations != null) {
      data['room_reservations'] = this.roomReservations!.map((v) => v.toJson()).toList();
    }
    if (this.roomBlocks != null) {
      data['room_blocks'] = this.roomBlocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FrontDeskRoomCategoryAndRooms {
  int? roomCategoryId;
  String? roomCategoryName;
  List<FrontDeskRoomInfo>? rooms;

  FrontDeskRoomCategoryAndRooms({
    this.roomCategoryId,
    this.roomCategoryName,
    this.rooms,
  });

  FrontDeskRoomCategoryAndRooms.fromJson(Map<String, dynamic> json) {
    roomCategoryId = json['room_category_id'];
    roomCategoryName = json['room_category_name'];
    if (json['rooms'] != null) {
      rooms = <FrontDeskRoomInfo>[];
      json['rooms'].forEach((v) {
        rooms!.add(new FrontDeskRoomInfo.fromJson(v));
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
}

// class FrontDeskRoomInfo {
//   int? roomNumberId;
//   String? roomNumberName;

//   FrontDeskRoomInfo({
//     this.roomNumberId,
//     this.roomNumberName,
//   });

//   FrontDeskRoomInfo.fromJson(Map<String, dynamic> json) {
//     roomNumberId = json['room_number_id'];
//     roomNumberName = json['room_number_name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['room_number_id'] = this.roomNumberId;
//     data['room_number_name'] = this.roomNumberName;
//     return data;
//   }
// }

class FrontDeskRoomInfo {
  int? roomNumberId;
  String? roomNumberName;
  bool? smokingAllowedStatus;
  bool? petsAllowedStatus;
  bool? wheelchairAllowedStatus;
  bool? minibarAllowedStatus;
  String? roomViewName;
  StatusInfo? roomHousekeepingStatus;

  FrontDeskRoomInfo({
    this.roomNumberId,
    this.roomNumberName,
    this.smokingAllowedStatus,
    this.petsAllowedStatus,
    this.wheelchairAllowedStatus,
    this.minibarAllowedStatus,
    this.roomViewName,
    this.roomHousekeepingStatus,
  });

  FrontDeskRoomInfo.fromJson(Map<String, dynamic> json) {
    roomNumberId = json['room_number_id'];
    roomNumberName = json['room_number_name'];
    smokingAllowedStatus = json['smoking_allowed_status'];
    petsAllowedStatus = json['pets_allowed_status'];
    wheelchairAllowedStatus = json['wheelchair_allowed_status'];
    minibarAllowedStatus = json['minibar_allowed_status'];
    roomViewName = json['room_view_name'];
    roomHousekeepingStatus =
        json['room_housekeeping_status'] != null ? new StatusInfo.fromJson(json['room_housekeeping_status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_number_id'] = this.roomNumberId;
    data['room_number_name'] = this.roomNumberName;
    data['smoking_allowed_status'] = this.smokingAllowedStatus;
    data['pets_allowed_status'] = this.petsAllowedStatus;
    data['wheelchair_allowed_status'] = this.wheelchairAllowedStatus;
    data['minibar_allowed_status'] = this.minibarAllowedStatus;
    data['room_view_name'] = this.roomViewName;
    if (this.roomHousekeepingStatus != null) {
      data['room_housekeeping_status'] = this.roomHousekeepingStatus!.toJson();
    }
    return data;
  }
}

class FrontDeskRoomReservations {
  int? roomReservationDetailId;
  int? roomReservationId;
  int? propertyId;
  String? bookingSource;
  String? reservationNumber;
  String? arrivalDate;
  String? departureDate;
  String? standarCheckinTime;
  String? standarCheckoutTime;
  int? adultOccupancyCount;
  int? childrenOccupancyCount;
  int? infantCount;
  int? petCount;
  String? checkInDatetime;
  String? checkOutDatetime;
  int? roomNumberId;
  FrontDeskRoomStayStatus? stayStatus;
  String? stayStatusCode;
  String? stayStatusDisplay;
  FrontDeskGuestDetails? guestDetails;
  bool? hasPastDates;

  FrontDeskRoomReservations({
    this.roomReservationDetailId,
    this.roomReservationId,
    this.propertyId,
    this.bookingSource,
    this.reservationNumber,
    this.arrivalDate,
    this.departureDate,
    this.standarCheckinTime,
    this.standarCheckoutTime,
    this.adultOccupancyCount,
    this.childrenOccupancyCount,
    this.infantCount,
    this.petCount,
    this.checkInDatetime,
    this.checkOutDatetime,
    this.roomNumberId,
    this.stayStatus,
    this.stayStatusCode,
    this.stayStatusDisplay,
    this.guestDetails,
    this.hasPastDates,
  });

  FrontDeskRoomReservations.fromJson(Map<String, dynamic> json) {
    roomReservationDetailId = json['room_reservation_detail_id'];
    roomReservationId = json['room_reservation_id'];
    propertyId = json['property_id'];
    bookingSource = json['booking_source'];
    reservationNumber = json['reservation_number'];
    arrivalDate = json['arrival_date'];
    departureDate = json['departure_date'];
    standarCheckinTime = json['standar_checkin_time'];
    standarCheckoutTime = json['standar_checkout_time'];
    adultOccupancyCount = json['adult_occupancy_count'];
    childrenOccupancyCount = json['children_occupancy_count'];
    infantCount = json['infant_count'];
    petCount = json['pet_count'];
    checkInDatetime = json['check_in_datetime'];
    checkOutDatetime = json['check_out_datetime'];
    roomNumberId = json['room_number_id'];
    stayStatus = json['stay_status'] != null ? new FrontDeskRoomStayStatus.fromJson(json['stay_status']) : null;
    stayStatusCode = json['stay_status_code'];
    stayStatusDisplay = json['stay_status_display'];
    guestDetails = json['guest_details'] != null ? new FrontDeskGuestDetails.fromJson(json['guest_details']) : null;
    hasPastDates = json['has_past_dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_reservation_detail_id'] = this.roomReservationDetailId;
    data['room_reservation_id'] = this.roomReservationId;
    data['property_id'] = this.propertyId;
    data['booking_source'] = this.bookingSource;
    data['reservation_number'] = this.reservationNumber;
    data['arrival_date'] = this.arrivalDate;
    data['departure_date'] = this.departureDate;
    data['standar_checkin_time'] = this.standarCheckinTime;
    data['standar_checkout_time'] = this.standarCheckoutTime;
    data['adult_occupancy_count'] = this.adultOccupancyCount;
    data['children_occupancy_count'] = this.childrenOccupancyCount;
    data['infant_count'] = this.infantCount;
    data['pet_count'] = this.petCount;
    data['check_in_datetime'] = this.checkInDatetime;
    data['check_out_datetime'] = this.checkOutDatetime;
    data['room_number_id'] = this.roomNumberId;
    if (this.stayStatus != null) {
      data['stay_status'] = this.stayStatus!.toJson();
    }
    data['stay_status_code'] = this.stayStatusCode;
    data['stay_status_display'] = this.stayStatusDisplay;
    if (this.guestDetails != null) {
      data['guest_details'] = this.guestDetails!.toJson();
    }
    data['has_past_dates'] = this.hasPastDates;
    return data;
  }
}

class FrontDeskRoomStayStatus {
  String? actualCode;
  String? code;
  String? display;
  String? textColor;
  String? bgColor;

  FrontDeskRoomStayStatus({
    this.actualCode,
    this.code,
    this.display,
    this.textColor,
    this.bgColor,
  });

  FrontDeskRoomStayStatus.fromJson(Map<String, dynamic> json) {
    actualCode = json['actual_code'];
    code = json['code'];
    display = json['display'];
    textColor = json['text_color'];
    bgColor = json['bg_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actual_code'] = this.actualCode;
    data['code'] = this.code;
    data['display'] = this.display;
    data['text_color'] = this.textColor;
    data['bg_color'] = this.bgColor;
    return data;
  }
}

class FrontDeskGuestDetails {
  int? guestAccountId;
  String? guestCode;
  String? guestFullName;

  FrontDeskGuestDetails({this.guestAccountId, this.guestCode, this.guestFullName});

  FrontDeskGuestDetails.fromJson(Map<String, dynamic> json) {
    guestAccountId = json['guest_account_id'];
    guestCode = json['guest_code'];
    guestFullName = json['guest_full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guest_account_id'] = this.guestAccountId;
    data['guest_code'] = this.guestCode;
    data['guest_full_name'] = this.guestFullName;
    return data;
  }
}

class FrontDeskRoomBlocks {
  int? roomNumberId;
  String? startDate;
  String? endDate;
  String? standarCheckinTime;
  String? standarCheckoutTime;
  String? notAvailableReasonStatus;
  int? blockedReasonId;
  String? blockedReasonName;
  String? blockedReasonBgcolor;
  String? blockedReasonTextcolor;
  String? additionalNotes;
  FrontDeskReservationDetails? reservationDetails;
  bool? hasPastDates;

  FrontDeskRoomBlocks({
    this.roomNumberId,
    this.startDate,
    this.endDate,
    this.standarCheckinTime,
    this.standarCheckoutTime,
    this.notAvailableReasonStatus,
    this.blockedReasonId,
    this.blockedReasonName,
    this.blockedReasonBgcolor,
    this.blockedReasonTextcolor,
    this.additionalNotes,
    this.reservationDetails,
    this.hasPastDates,
  });

  FrontDeskRoomBlocks.fromJson(Map<String, dynamic> json) {
    roomNumberId = json['room_number_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    standarCheckinTime = json['standar_checkin_time'];
    standarCheckoutTime = json['standar_checkout_time'];
    notAvailableReasonStatus = json['not_available_reason_status'];
    blockedReasonId = json['blocked_reason_id'];
    blockedReasonName = json['blocked_reason_name'];
    blockedReasonBgcolor = json['blocked_reason_bgcolor'];
    blockedReasonTextcolor = json['blocked_reason_textcolor'];
    additionalNotes = json['additional_notes'];
    reservationDetails = json['reservation_details'] != null
        ? new FrontDeskReservationDetails.fromJson(json['reservation_details'])
        : null;
    hasPastDates = json['has_past_dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_number_id'] = this.roomNumberId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['standar_checkin_time'] = this.standarCheckinTime;
    data['standar_checkout_time'] = this.standarCheckoutTime;
    data['not_available_reason_status'] = this.notAvailableReasonStatus;
    data['blocked_reason_id'] = this.blockedReasonId;
    data['blocked_reason_name'] = this.blockedReasonName;
    data['blocked_reason_bgcolor'] = this.blockedReasonBgcolor;
    data['blocked_reason_textcolor'] = this.blockedReasonTextcolor;
    data['additional_notes'] = this.additionalNotes;
    if (this.reservationDetails != null) {
      data['reservation_details'] = this.reservationDetails!.toJson();
    }
    data['has_past_dates'] = this.hasPastDates;
    return data;
  }
}

class FrontDeskReservationDetails {
  int? roomReservationId;
  String? bookingSource;
  String? reservationNumber;
  FrontDeskGuestDetails? guestDetails;

  FrontDeskReservationDetails({
    this.roomReservationId,
    this.bookingSource,
    this.reservationNumber,
    this.guestDetails,
  });

  FrontDeskReservationDetails.fromJson(Map<String, dynamic> json) {
    roomReservationId = json['room_reservation_id'];
    bookingSource = json['booking_source'];
    reservationNumber = json['reservation_number'];
    guestDetails = json['guest_details'] != null ? new FrontDeskGuestDetails.fromJson(json['guest_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_reservation_id'] = this.roomReservationId;
    data['booking_source'] = this.bookingSource;
    data['reservation_number'] = this.reservationNumber;
    if (this.guestDetails != null) {
      data['guest_details'] = this.guestDetails!.toJson();
    }
    return data;
  }
}
