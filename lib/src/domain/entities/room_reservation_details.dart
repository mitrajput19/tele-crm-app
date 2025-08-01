class RoomReservationDetails {
  int? roomReservationId;
  int? propertyId;
  String? defaultCurrencySymbol;
  String? propertyName;
  String? reservationNumber;
  String? masterArrivalDate;
  String? masterDepartureDate;
  String? reservationHtmlCard;
  String? bookingSource;
  String? channelCode;
  String? otaName;
  String? otaReservationCode;
  String? latestReservationStatus;
  String? latestReservationStatusHtml;
  String? latestReservationStatusText;
  int? guestAccountId;
  String? guestName;
  String? guestEmail;
  String? guestPhone;
  String? guestHtmlCard;
  String? totalGrossAmount;
  String? totalPaymentReceived;
  String? totalBalancePayment;
  String? totalBalancePaymentDisplay;
  List<RoomReservationData>? details;
  List<RoomReservationExtras>? extras;
  List<RoomReservationTransactions>? transactions;
  String? reservationType;
  String? reservationTypeBadge;

  RoomReservationDetails({
    this.roomReservationId,
    this.propertyId,
    this.defaultCurrencySymbol,
    this.propertyName,
    this.reservationNumber,
    this.masterArrivalDate,
    this.masterDepartureDate,
    this.reservationHtmlCard,
    this.bookingSource,
    this.channelCode,
    this.otaName,
    this.otaReservationCode,
    this.latestReservationStatus,
    this.latestReservationStatusHtml,
    this.latestReservationStatusText,
    this.guestAccountId,
    this.guestName,
    this.guestEmail,
    this.guestPhone,
    this.guestHtmlCard,
    this.totalGrossAmount,
    this.totalPaymentReceived,
    this.totalBalancePayment,
    this.totalBalancePaymentDisplay,
    this.details,
    this.extras,
    this.transactions,
    this.reservationType,
    this.reservationTypeBadge,
  });

  RoomReservationDetails.fromJson(Map<String, dynamic> json) {
    roomReservationId = json['room_reservation_id'];
    propertyId = json['property_id'];
    defaultCurrencySymbol = json['default_currency_symbol'];
    propertyName = json['property_name'];
    reservationNumber = json['reservation_number'];
    masterArrivalDate = json['master_arrival_date'];
    masterDepartureDate = json['master_departure_date'];
    reservationHtmlCard = json['reservation_html_card'];
    bookingSource = json['booking_source'];
    channelCode = json['channel_code'];
    otaName = json['ota_name'];
    otaReservationCode = json['ota_reservation_code'];
    latestReservationStatus = json['latest_reservation_status'];
    latestReservationStatusHtml = json['latest_reservation_status_html'];
    latestReservationStatusText = json['latest_reservation_status_text'];
    guestAccountId = json['guest_account_id'];
    guestName = json['guest_name'];
    guestEmail = json['guest_email'];
    guestPhone = json['guest_phone'];
    guestHtmlCard = json['guest_html_card'];
    totalGrossAmount = json['total_gross_amount'];
    totalPaymentReceived = json['total_payment_received'];
    totalBalancePayment = json['total_balance_payment'];
    totalBalancePaymentDisplay = json['total_balance_payment_display'];
    if (json['details'] != null) {
      details = <RoomReservationData>[];
      json['details'].forEach((v) {
        details!.add(new RoomReservationData.fromJson(v));
      });
    }
    if (json['extras'] != null) {
      extras = <RoomReservationExtras>[];
      json['extras'].forEach((v) {
        extras!.add(new RoomReservationExtras.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <RoomReservationTransactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new RoomReservationTransactions.fromJson(v));
      });
    }
    reservationType = json['reservation_type'];
    reservationTypeBadge = json['reservation_type_badge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_reservation_id'] = this.roomReservationId;
    data['property_id'] = this.propertyId;
    data['default_currency_symbol'] = this.defaultCurrencySymbol;
    data['property_name'] = this.propertyName;
    data['reservation_number'] = this.reservationNumber;
    data['master_arrival_date'] = this.masterArrivalDate;
    data['master_departure_date'] = this.masterDepartureDate;
    data['reservation_html_card'] = this.reservationHtmlCard;
    data['booking_source'] = this.bookingSource;
    data['channel_code'] = this.channelCode;
    data['ota_name'] = this.otaName;
    data['ota_reservation_code'] = this.otaReservationCode;
    data['latest_reservation_status'] = this.latestReservationStatus;
    data['latest_reservation_status_html'] = this.latestReservationStatusHtml;
    data['latest_reservation_status_text'] = this.latestReservationStatusText;
    data['guest_account_id'] = this.guestAccountId;
    data['guest_name'] = this.guestName;
    data['guest_email'] = this.guestEmail;
    data['guest_phone'] = this.guestPhone;
    data['guest_html_card'] = this.guestHtmlCard;
    data['total_gross_amount'] = this.totalGrossAmount;
    data['total_payment_received'] = this.totalPaymentReceived;
    data['total_balance_payment'] = this.totalBalancePayment;
    data['total_balance_payment_display'] = this.totalBalancePaymentDisplay;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    if (this.extras != null) {
      data['extras'] = this.extras!.map((v) => v.toJson()).toList();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['reservation_type'] = this.reservationType;
    data['reservation_type_badge'] = this.reservationTypeBadge;
    return data;
  }

  static List<RoomReservationDetails> listFromJson(dynamic json) {
    List<RoomReservationDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new RoomReservationDetails.fromJson(v));
      });
    }
    return list;
  }
}

class RoomReservationData {
  int? roomReservationDetailId;
  int? adultOccupancyCount;
  int? childrenOccupancyCount;
  int? infantCount;
  int? petCount;
  String? arrivalDate;
  String? departureDate;
  String? checkInDatetime;
  String? checkOutDatetime;
  String? checkInDatetimeText;
  String? checkOutDatetimeText;
  String? totalGrossAmount;
  List<RoomReservationStays>? stays;
  List<RoomReservationGuestOccupancy>? guestOccupancy;

  RoomReservationData({
    this.roomReservationDetailId,
    this.adultOccupancyCount,
    this.childrenOccupancyCount,
    this.infantCount,
    this.petCount,
    this.arrivalDate,
    this.departureDate,
    this.checkInDatetime,
    this.checkOutDatetime,
    this.checkInDatetimeText,
    this.checkOutDatetimeText,
    this.totalGrossAmount,
    this.stays,
    this.guestOccupancy,
  });

  RoomReservationData.fromJson(Map<String, dynamic> json) {
    roomReservationDetailId = json['room_reservation_detail_id'];
    adultOccupancyCount = json['adult_occupancy_count'];
    childrenOccupancyCount = json['children_occupancy_count'];
    infantCount = json['infant_count'];
    petCount = json['pet_count'];
    arrivalDate = json['arrival_date'];
    departureDate = json['departure_date'];
    checkInDatetime = json['check_in_datetime'];
    checkOutDatetime = json['check_out_datetime'];
    checkInDatetimeText = json['check_in_datetime_text'];
    checkOutDatetimeText = json['check_out_datetime_text'];
    totalGrossAmount = json['total_gross_amount'];
    if (json['stays'] != null) {
      stays = <RoomReservationStays>[];
      json['stays'].forEach((v) {
        stays!.add(new RoomReservationStays.fromJson(v));
      });
    }
    if (json['guest_occupancy'] != null) {
      guestOccupancy = <RoomReservationGuestOccupancy>[];
      json['guest_occupancy'].forEach((v) {
        guestOccupancy!.add(new RoomReservationGuestOccupancy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_reservation_detail_id'] = this.roomReservationDetailId;
    data['adult_occupancy_count'] = this.adultOccupancyCount;
    data['children_occupancy_count'] = this.childrenOccupancyCount;
    data['infant_count'] = this.infantCount;
    data['pet_count'] = this.petCount;
    data['arrival_date'] = this.arrivalDate;
    data['departure_date'] = this.departureDate;
    data['check_in_datetime'] = this.checkInDatetime;
    data['check_out_datetime'] = this.checkOutDatetime;
    data['check_in_datetime_text'] = this.checkInDatetimeText;
    data['check_out_datetime_text'] = this.checkOutDatetimeText;
    data['total_gross_amount'] = this.totalGrossAmount;
    if (this.stays != null) {
      data['stays'] = this.stays!.map((v) => v.toJson()).toList();
    }
    if (this.guestOccupancy != null) {
      data['guest_occupancy'] = this.guestOccupancy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomReservationStays {
  int? roomReservationStayDetailId;
  String? stayDate;
  String? amountPerNight;
  String? amountToBeCharged;
  String? roomNumber;
  String? roomCategoryName;
  String? ratePlanName;
  int? isComplementaryStay;
  int? isCancelled;
  int? isChanged;
  String? cancellationDatetime;
  String? changedDatetime;
  int? changedFromRoomReservationStayDetailId;
  List<RoomReservationTaxes>? taxes;
  List<RoomReservationDiscounts>? discounts;
  String? grossAmount;

  RoomReservationStays({
    this.roomReservationStayDetailId,
    this.stayDate,
    this.amountPerNight,
    this.amountToBeCharged,
    this.roomNumber,
    this.roomCategoryName,
    this.ratePlanName,
    this.isComplementaryStay,
    this.isCancelled,
    this.isChanged,
    this.cancellationDatetime,
    this.changedDatetime,
    this.changedFromRoomReservationStayDetailId,
    this.taxes,
    this.discounts,
    this.grossAmount,
  });

  RoomReservationStays.fromJson(Map<String, dynamic> json) {
    roomReservationStayDetailId = json['room_reservation_stay_detail_id'];
    stayDate = json['stay_date'];
    amountPerNight = json['amount_per_night'];
    amountToBeCharged = json['amount_to_be_charged'];
    roomNumber = json['room_number'];
    roomCategoryName = json['room_category_name'];
    ratePlanName = json['rate_plan_name'];
    isComplementaryStay = json['is_complementary_stay'];
    isCancelled = json['is_cancelled'];
    isChanged = json['is_changed'];
    cancellationDatetime = json['cancellation_datetime'];
    changedDatetime = json['changed_datetime'];
    changedFromRoomReservationStayDetailId = json['changed_from_room_reservation_stay_detail_id'];
    if (json['taxes'] != null) {
      taxes = <RoomReservationTaxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(new RoomReservationTaxes.fromJson(v));
      });
    }
    if (json['discounts'] != null) {
      discounts = <RoomReservationDiscounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(new RoomReservationDiscounts.fromJson(v));
      });
    }
    grossAmount = json['gross_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_reservation_stay_detail_id'] = this.roomReservationStayDetailId;
    data['stay_date'] = this.stayDate;
    data['amount_per_night'] = this.amountPerNight;
    data['amount_to_be_charged'] = this.amountToBeCharged;
    data['room_number'] = this.roomNumber;
    data['room_category_name'] = this.roomCategoryName;
    data['rate_plan_name'] = this.ratePlanName;
    data['is_complementary_stay'] = this.isComplementaryStay;
    data['is_cancelled'] = this.isCancelled;
    data['is_changed'] = this.isChanged;
    data['cancellation_datetime'] = this.cancellationDatetime;
    data['changed_datetime'] = this.changedDatetime;
    data['changed_from_room_reservation_stay_detail_id'] = this.changedFromRoomReservationStayDetailId;
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    if (this.discounts != null) {
      data['discounts'] = this.discounts!.map((v) => v.toJson()).toList();
    }
    data['gross_amount'] = this.grossAmount;
    return data;
  }
}

class RoomReservationTaxes {
  int? taxId;
  String? taxName;
  String? taxShortname;
  String? taxAmount;

  RoomReservationTaxes({
    this.taxId,
    this.taxName,
    this.taxShortname,
    this.taxAmount,
  });

  RoomReservationTaxes.fromJson(Map<String, dynamic> json) {
    taxId = json['tax_id'];
    taxName = json['tax_name'];
    taxShortname = json['tax_shortname'];
    taxAmount = json['tax_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_id'] = this.taxId;
    data['tax_name'] = this.taxName;
    data['tax_shortname'] = this.taxShortname;
    data['tax_amount'] = this.taxAmount;
    return data;
  }
}

class RoomReservationDiscounts {
  int? discountId;
  String? discountCode;
  String? discountName;
  String? discountType;
  String? discountAmount;

  RoomReservationDiscounts({
    this.discountId,
    this.discountCode,
    this.discountName,
    this.discountType,
    this.discountAmount,
  });

  RoomReservationDiscounts.fromJson(Map<String, dynamic> json) {
    discountId = json['discount_id'];
    discountCode = json['discount_code'];
    discountName = json['discount_name'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_id'] = this.discountId;
    data['discount_code'] = this.discountCode;
    data['discount_name'] = this.discountName;
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    return data;
  }
}

class RoomReservationGuestOccupancy {
  int? guestAccountId;
  String? guestName;
  String? guestEmail;
  String? guestPhone;
  String? guestType;
  int? isPrimaryGuest;

  RoomReservationGuestOccupancy({
    this.guestAccountId,
    this.guestName,
    this.guestEmail,
    this.guestPhone,
    this.guestType,
    this.isPrimaryGuest,
  });

  RoomReservationGuestOccupancy.fromJson(Map<String, dynamic> json) {
    guestAccountId = json['guest_account_id'];
    guestName = json['guest_name'];
    guestEmail = json['guest_email'];
    guestPhone = json['guest_phone'];
    guestType = json['guest_type'];
    isPrimaryGuest = json['is_primary_guest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guest_account_id'] = this.guestAccountId;
    data['guest_name'] = this.guestName;
    data['guest_email'] = this.guestEmail;
    data['guest_phone'] = this.guestPhone;
    data['guest_type'] = this.guestType;
    data['is_primary_guest'] = this.isPrimaryGuest;
    return data;
  }
}

class RoomReservationExtras {
  int? roomReservationExtraId;
  int? extrasId;
  String? extrasName;
  String? unitAmount;
  int? quantity;
  List<RoomReservationTaxes>? taxes;
  List<RoomReservationDiscounts>? discounts;
  String? grossAmount;

  RoomReservationExtras({
    this.roomReservationExtraId,
    this.extrasId,
    this.extrasName,
    this.unitAmount,
    this.quantity,
    this.taxes,
    this.discounts,
    this.grossAmount,
  });

  RoomReservationExtras.fromJson(Map<String, dynamic> json) {
    roomReservationExtraId = json['room_reservation_extra_id'];
    extrasId = json['extras_id'];
    extrasName = json['extras_name'];
    unitAmount = json['unit_amount'];
    quantity = json['quantity'];
    if (json['taxes'] != null) {
      taxes = <RoomReservationTaxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(new RoomReservationTaxes.fromJson(v));
      });
    }
    if (json['discounts'] != null) {
      discounts = <RoomReservationDiscounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(new RoomReservationDiscounts.fromJson(v));
      });
    }
    grossAmount = json['gross_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_reservation_extra_id'] = this.roomReservationExtraId;
    data['extras_id'] = this.extrasId;
    data['extras_name'] = this.extrasName;
    data['unit_amount'] = this.unitAmount;
    data['quantity'] = this.quantity;
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    if (this.discounts != null) {
      data['discounts'] = this.discounts!.map((v) => v.toJson()).toList();
    }
    data['gross_amount'] = this.grossAmount;
    return data;
  }
}

class RoomReservationTransactions {
  int? propertyTransactionId;
  String? internalTransactionUniqueNumber;
  String? externalTransactionUniqueNumber;
  int? paymentModeId;
  String? transactionDate;
  String? transactionTime;
  int? transactionCurrencyId;
  String? transactionAmount;
  String? transactionAmountUsd;
  String? transactionAmountDefault;
  String? usdRateAtTimeOfPayment;
  String? transactionType;
  int? isRefundable;
  int? isRefund;
  String? transactionStatus;
  String? settlementDate;

  RoomReservationTransactions({
    this.propertyTransactionId,
    this.internalTransactionUniqueNumber,
    this.externalTransactionUniqueNumber,
    this.paymentModeId,
    this.transactionDate,
    this.transactionTime,
    this.transactionCurrencyId,
    this.transactionAmount,
    this.transactionAmountUsd,
    this.transactionAmountDefault,
    this.usdRateAtTimeOfPayment,
    this.transactionType,
    this.isRefundable,
    this.isRefund,
    this.transactionStatus,
    this.settlementDate,
  });

  RoomReservationTransactions.fromJson(Map<String, dynamic> json) {
    propertyTransactionId = json['property_transaction_id'];
    internalTransactionUniqueNumber = json['internal_transaction_unique_number'];
    externalTransactionUniqueNumber = json['external_transaction_unique_number'];
    paymentModeId = json['payment_mode_id'];
    transactionDate = json['transaction_date'];
    transactionTime = json['transaction_time'];
    transactionCurrencyId = json['transaction_currency_id'];
    transactionAmount = json['transaction_amount'];
    transactionAmountUsd = json['transaction_amount_usd'];
    transactionAmountDefault = json['transaction_amount_default'];
    usdRateAtTimeOfPayment = json['usd_rate_at_time_of_payment'];
    transactionType = json['transaction_type'];
    isRefundable = json['is_refundable'];
    isRefund = json['is_refund'];
    transactionStatus = json['transaction_status'];
    settlementDate = json['settlement_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_transaction_id'] = this.propertyTransactionId;
    data['internal_transaction_unique_number'] = this.internalTransactionUniqueNumber;
    data['external_transaction_unique_number'] = this.externalTransactionUniqueNumber;
    data['payment_mode_id'] = this.paymentModeId;
    data['transaction_date'] = this.transactionDate;
    data['transaction_time'] = this.transactionTime;
    data['transaction_currency_id'] = this.transactionCurrencyId;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_amount_usd'] = this.transactionAmountUsd;
    data['transaction_amount_default'] = this.transactionAmountDefault;
    data['usd_rate_at_time_of_payment'] = this.usdRateAtTimeOfPayment;
    data['transaction_type'] = this.transactionType;
    data['is_refundable'] = this.isRefundable;
    data['is_refund'] = this.isRefund;
    data['transaction_status'] = this.transactionStatus;
    data['settlement_date'] = this.settlementDate;
    return data;
  }
}
