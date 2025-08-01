class PropertyTransactionData {
  List<PropertyTransactionDetails>? transactions;
  Pagination? pagination;

  PropertyTransactionData({
    this.transactions,
    this.pagination,
  });

  PropertyTransactionData.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <PropertyTransactionDetails>[];
      json['transactions'].forEach((v) {
        transactions!.add(new PropertyTransactionDetails.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class PropertyTransactionDetails {
  int? propertyId;
  int? propetyCurrencyId;
  String? propetyCurrencySymbol;
  String? propetyCurrencyIso3;
  int? propertyTransactionId;
  String? internalTransactionUniqueNumber;
  String? externalTransactionUniqueNumber;
  String? transactionDate;
  String? transactionDateDisplay;
  String? transactionTime;
  String? transactionTimeDisplay;
  int? transactionCurrencyId;
  String? transactionCurrencyIso3;
  String? transactionCurrencySymbol;
  String? transactionAmount;
  String? transactionType;
  TransactionTypeColors? transactionTypeColors;
  String? transactionStatus;
  TransactionTypeColors? transactionStatusColors;
  String? transactionReferenceEntity;
  int? transactionReferenceEntityId;
  int? synchronizationStatus;
  TransactionTypeColors? synchronizationStatusColors;
  String? synchronizationDetails;
  int? paymentModeId;
  String? paymentModeName;
  int? isDeposit;
  int? isRefundable;
  int? isRefund;
  String? commissionAmount;
  String? settlementDate;
  String? additionalDetails;
  int? accountMasterId;
  int? guestId;
  int? primaryPropertyTransactionId;
  int? isTransactionAmountAdjusted;
  String? transactionOriginalAmount;
  String? transactionAdjustedAmount;
  String? usdRateAtTimeOfPayment;
  String? usdPropertyRateAtTimeOfPayment;
  int? transactionAdjustedByEmployeeId;
  String? transactionAdjustedByEmployeeCardHtml;
  int? synchronizationActionTakenByEmployeeId;
  String? synchronizationActionTakenByEmployeeCardHtml;
  int? nightAuditByEmployeeId;
  String? nightAuditByEmployeeCardHtml;
  int? addedByEmployeeId;
  String? addedByEmployeeCardHtml;
  int? updatedByEmployeeId;
  String? updatedByEmployeeCardHtml;
  AccountMasterDetails? accountMasterDetails;
  GuestDetails? guestDetails;
  PrimaryPropertyTransactionDetails? primaryPropertyTransactionDetails;
  TransactionEntityDetails? transactionEntityDetails;

  PropertyTransactionDetails({
    this.propertyId,
    this.propetyCurrencyId,
    this.propetyCurrencySymbol,
    this.propetyCurrencyIso3,
    this.propertyTransactionId,
    this.internalTransactionUniqueNumber,
    this.externalTransactionUniqueNumber,
    this.transactionDate,
    this.transactionDateDisplay,
    this.transactionTime,
    this.transactionTimeDisplay,
    this.transactionCurrencyId,
    this.transactionCurrencyIso3,
    this.transactionCurrencySymbol,
    this.transactionAmount,
    this.transactionType,
    this.transactionTypeColors,
    this.transactionStatus,
    this.transactionStatusColors,
    this.transactionReferenceEntity,
    this.transactionReferenceEntityId,
    this.synchronizationStatus,
    this.synchronizationStatusColors,
    this.synchronizationDetails,
    this.paymentModeId,
    this.paymentModeName,
    this.isDeposit,
    this.isRefundable,
    this.isRefund,
    this.commissionAmount,
    this.settlementDate,
    this.additionalDetails,
    this.accountMasterId,
    this.guestId,
    this.primaryPropertyTransactionId,
    this.isTransactionAmountAdjusted,
    this.transactionOriginalAmount,
    this.transactionAdjustedAmount,
    this.usdRateAtTimeOfPayment,
    this.usdPropertyRateAtTimeOfPayment,
    this.transactionAdjustedByEmployeeId,
    this.transactionAdjustedByEmployeeCardHtml,
    this.synchronizationActionTakenByEmployeeId,
    this.synchronizationActionTakenByEmployeeCardHtml,
    this.nightAuditByEmployeeId,
    this.nightAuditByEmployeeCardHtml,
    this.addedByEmployeeId,
    this.addedByEmployeeCardHtml,
    this.updatedByEmployeeId,
    this.updatedByEmployeeCardHtml,
    this.accountMasterDetails,
    this.guestDetails,
    this.primaryPropertyTransactionDetails,
    this.transactionEntityDetails,
  });

  PropertyTransactionDetails.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'];
    propetyCurrencyId = json['propety_currency_id'];
    propetyCurrencySymbol = json['propety_currency_symbol'];
    propetyCurrencyIso3 = json['propety_currency_iso3'];
    propertyTransactionId = json['property_transaction_id'];
    internalTransactionUniqueNumber = json['internal_transaction_unique_number'];
    externalTransactionUniqueNumber = json['external_transaction_unique_number'];
    transactionDate = json['transaction_date'];
    transactionDateDisplay = json['transaction_date_display'];
    transactionTime = json['transaction_time'];
    transactionTimeDisplay = json['transaction_time_display'];
    transactionCurrencyId = json['transaction_currency_id'];
    transactionCurrencyIso3 = json['transaction_currency_iso3'];
    transactionCurrencySymbol = json['transaction_currency_symbol'];
    transactionAmount = json['transaction_amount'];
    transactionType = json['transaction_type'];
    transactionTypeColors = json['transaction_type_colors'] != null
        ? new TransactionTypeColors.fromJson(json['transaction_type_colors'])
        : null;
    transactionStatus = json['transaction_status'];
    transactionStatusColors = json['transaction_status_colors'] != null
        ? new TransactionTypeColors.fromJson(json['transaction_status_colors'])
        : null;
    transactionReferenceEntity = json['transaction_reference_entity'];
    transactionReferenceEntityId = json['transaction_reference_entity_id'];
    synchronizationStatus = json['synchronization_status'];
    synchronizationStatusColors = json['synchronization_status_colors'] != null
        ? new TransactionTypeColors.fromJson(json['synchronization_status_colors'])
        : null;
    synchronizationDetails = json['synchronization_details'];
    paymentModeId = json['payment_mode_id'];
    paymentModeName = json['payment_mode_name'];
    isDeposit = json['is_deposit'];
    isRefundable = json['is_refundable'];
    isRefund = json['is_refund'];
    commissionAmount = json['commission_amount'];
    settlementDate = json['settlement_date'];
    additionalDetails = json['additional_details'];
    accountMasterId = json['account_master_id'];
    guestId = json['guest_id'];
    primaryPropertyTransactionId = json['primary_property_transaction_id'];
    isTransactionAmountAdjusted = json['is_transaction_amount_adjusted'];
    transactionOriginalAmount = json['transaction_original_amount'];
    transactionAdjustedAmount = json['transaction_adjusted_amount'];
    usdRateAtTimeOfPayment = json['usd_rate_at_time_of_payment'];
    usdPropertyRateAtTimeOfPayment = json['usd_property_rate_at_time_of_payment'];
    transactionAdjustedByEmployeeId = json['transaction_adjusted_by_employee_id'];
    transactionAdjustedByEmployeeCardHtml = json['transaction_adjusted_by_employee_card_html'];
    synchronizationActionTakenByEmployeeId = json['synchronization_action_taken_by_employee_id'];
    synchronizationActionTakenByEmployeeCardHtml = json['synchronization_action_taken_by_employee_card_html'];
    nightAuditByEmployeeId = json['night_audit_by_employee_id'];
    nightAuditByEmployeeCardHtml = json['night_audit_by_employee_card_html'];
    addedByEmployeeId = json['added_by_employee_id'];
    addedByEmployeeCardHtml = json['added_by_employee_card_html'];
    updatedByEmployeeId = json['updated_by_employee_id'];
    updatedByEmployeeCardHtml = json['updated_by_employee_card_html'];
    accountMasterDetails = json['account_master_details'] != null
        ? new AccountMasterDetails.fromJson(json['account_master_details'])
        : null;
    guestDetails = json['guest_details'] != null ? new GuestDetails.fromJson(json['guest_details']) : null;
    primaryPropertyTransactionDetails = json['primary_property_transaction_details'] != null
        ? new PrimaryPropertyTransactionDetails.fromJson(json['primary_property_transaction_details'])
        : null;
    transactionEntityDetails = json['transaction_entity_details'] != null
        ? new TransactionEntityDetails.fromJson(json['transaction_entity_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_id'] = this.propertyId;
    data['propety_currency_id'] = this.propetyCurrencyId;
    data['propety_currency_symbol'] = this.propetyCurrencySymbol;
    data['propety_currency_iso3'] = this.propetyCurrencyIso3;
    data['property_transaction_id'] = this.propertyTransactionId;
    data['internal_transaction_unique_number'] = this.internalTransactionUniqueNumber;
    data['external_transaction_unique_number'] = this.externalTransactionUniqueNumber;
    data['transaction_date'] = this.transactionDate;
    data['transaction_date_display'] = this.transactionDateDisplay;
    data['transaction_time'] = this.transactionTime;
    data['transaction_time_display'] = this.transactionTimeDisplay;
    data['transaction_currency_id'] = this.transactionCurrencyId;
    data['transaction_currency_iso3'] = this.transactionCurrencyIso3;
    data['transaction_currency_symbol'] = this.transactionCurrencySymbol;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_type'] = this.transactionType;
    if (this.transactionTypeColors != null) {
      data['transaction_type_colors'] = this.transactionTypeColors!.toJson();
    }
    data['transaction_status'] = this.transactionStatus;
    if (this.transactionStatusColors != null) {
      data['transaction_status_colors'] = this.transactionStatusColors!.toJson();
    }
    data['transaction_reference_entity'] = this.transactionReferenceEntity;
    data['transaction_reference_entity_id'] = this.transactionReferenceEntityId;
    data['synchronization_status'] = this.synchronizationStatus;
    if (this.synchronizationStatusColors != null) {
      data['synchronization_status_colors'] = this.synchronizationStatusColors!.toJson();
    }
    data['synchronization_details'] = this.synchronizationDetails;
    data['payment_mode_id'] = this.paymentModeId;
    data['payment_mode_name'] = this.paymentModeName;
    data['is_deposit'] = this.isDeposit;
    data['is_refundable'] = this.isRefundable;
    data['is_refund'] = this.isRefund;
    data['commission_amount'] = this.commissionAmount;
    data['settlement_date'] = this.settlementDate;
    data['additional_details'] = this.additionalDetails;
    data['account_master_id'] = this.accountMasterId;
    data['guest_id'] = this.guestId;
    data['primary_property_transaction_id'] = this.primaryPropertyTransactionId;
    data['is_transaction_amount_adjusted'] = this.isTransactionAmountAdjusted;
    data['transaction_original_amount'] = this.transactionOriginalAmount;
    data['transaction_adjusted_amount'] = this.transactionAdjustedAmount;
    data['usd_rate_at_time_of_payment'] = this.usdRateAtTimeOfPayment;
    data['usd_property_rate_at_time_of_payment'] = this.usdPropertyRateAtTimeOfPayment;
    data['transaction_adjusted_by_employee_id'] = this.transactionAdjustedByEmployeeId;
    data['transaction_adjusted_by_employee_card_html'] = this.transactionAdjustedByEmployeeCardHtml;
    data['synchronization_action_taken_by_employee_id'] = this.synchronizationActionTakenByEmployeeId;
    data['synchronization_action_taken_by_employee_card_html'] = this.synchronizationActionTakenByEmployeeCardHtml;
    data['night_audit_by_employee_id'] = this.nightAuditByEmployeeId;
    data['night_audit_by_employee_card_html'] = this.nightAuditByEmployeeCardHtml;
    data['added_by_employee_id'] = this.addedByEmployeeId;
    data['added_by_employee_card_html'] = this.addedByEmployeeCardHtml;
    data['updated_by_employee_id'] = this.updatedByEmployeeId;
    data['updated_by_employee_card_html'] = this.updatedByEmployeeCardHtml;
    if (this.accountMasterDetails != null) {
      data['account_master_details'] = this.accountMasterDetails!.toJson();
    }
    if (this.guestDetails != null) {
      data['guest_details'] = this.guestDetails!.toJson();
    }
    if (this.primaryPropertyTransactionDetails != null) {
      data['primary_property_transaction_details'] = this.primaryPropertyTransactionDetails!.toJson();
    }
    if (this.transactionEntityDetails != null) {
      data['transaction_entity_details'] = this.transactionEntityDetails!.toJson();
    }
    return data;
  }

  static List<PropertyTransactionDetails> listFromJson(dynamic json) {
    List<PropertyTransactionDetails> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new PropertyTransactionDetails.fromJson(v));
      });
    }
    return list;
  }
}

class TransactionTypeColors {
  String? background;
  String? text;

  TransactionTypeColors({
    this.background,
    this.text,
  });

  TransactionTypeColors.fromJson(Map<String, dynamic> json) {
    background = json['background'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['background'] = this.background;
    data['text'] = this.text;
    return data;
  }
}

class AccountMasterDetails {
  int? accountMasterId;
  String? typeOfAccount;
  String? bankName;

  AccountMasterDetails({
    this.accountMasterId,
    this.typeOfAccount,
    this.bankName,
  });

  AccountMasterDetails.fromJson(Map<String, dynamic> json) {
    accountMasterId = json['account_master_id'];
    typeOfAccount = json['type_of_account'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_master_id'] = this.accountMasterId;
    data['type_of_account'] = this.typeOfAccount;
    data['bank_name'] = this.bankName;
    return data;
  }
}

class GuestDetails {
  int? guestId;
  String? guestName;
  String? guestEmail;
  String? guestPhone;

  GuestDetails({
    this.guestId,
    this.guestName,
    this.guestEmail,
    this.guestPhone,
  });

  GuestDetails.fromJson(Map<String, dynamic> json) {
    guestId = json['guest_id'];
    guestName = json['guest_name'];
    guestEmail = json['guest_email'];
    guestPhone = json['guest_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guest_id'] = this.guestId;
    data['guest_name'] = this.guestName;
    data['guest_email'] = this.guestEmail;
    data['guest_phone'] = this.guestPhone;
    return data;
  }
}

class PrimaryPropertyTransactionDetails {
  int? propertyTransactionId;
  String? internalTransactionUniqueNumber;
  String? transactionDate;
  String? transactionTime;
  String? transactionAmount;
  String? transactionType;
  String? transactionStatus;

  PrimaryPropertyTransactionDetails({
    this.propertyTransactionId,
    this.internalTransactionUniqueNumber,
    this.transactionDate,
    this.transactionTime,
    this.transactionAmount,
    this.transactionType,
    this.transactionStatus,
  });

  PrimaryPropertyTransactionDetails.fromJson(Map<String, dynamic> json) {
    propertyTransactionId = json['property_transaction_id'];
    internalTransactionUniqueNumber = json['internal_transaction_unique_number'];
    transactionDate = json['transaction_date'];
    transactionTime = json['transaction_time'];
    transactionAmount = json['transaction_amount'];
    transactionType = json['transaction_type'];
    transactionStatus = json['transaction_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_transaction_id'] = this.propertyTransactionId;
    data['internal_transaction_unique_number'] = this.internalTransactionUniqueNumber;
    data['transaction_date'] = this.transactionDate;
    data['transaction_time'] = this.transactionTime;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_type'] = this.transactionType;
    data['transaction_status'] = this.transactionStatus;
    return data;
  }
}

class TransactionEntityDetails {
  int? roomReservationId;
  String? reservationNumber;
  String? arrivalDate;
  String? departureDate;
  int? propertyExpenseEntryId;
  String? expenseTitle;
  String? dateOfExpense;
  String? totalExpenseAmount;

  TransactionEntityDetails({
    this.roomReservationId,
    this.reservationNumber,
    this.arrivalDate,
    this.departureDate,
    this.propertyExpenseEntryId,
    this.expenseTitle,
    this.dateOfExpense,
    this.totalExpenseAmount,
  });

  TransactionEntityDetails.fromJson(Map<String, dynamic> json) {
    roomReservationId = json['room_reservation_id'];
    reservationNumber = json['reservation_number'];
    arrivalDate = json['arrival_date'];
    departureDate = json['departure_date'];
    propertyExpenseEntryId = json['property_expense_entry_id'];
    expenseTitle = json['expense_title'];
    dateOfExpense = json['date_of_expense'];
    totalExpenseAmount = json['total_expense_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_reservation_id'] = this.roomReservationId;
    data['reservation_number'] = this.reservationNumber;
    data['arrival_date'] = this.arrivalDate;
    data['departure_date'] = this.departureDate;
    data['property_expense_entry_id'] = this.propertyExpenseEntryId;
    data['expense_title'] = this.expenseTitle;
    data['date_of_expense'] = this.dateOfExpense;
    data['total_expense_amount'] = this.totalExpenseAmount;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? perPage;
  int? totalItems;
  int? totalPages;

  Pagination({
    this.currentPage,
    this.perPage,
    this.totalItems,
    this.totalPages,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    totalItems = json['total_items'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    data['total_items'] = this.totalItems;
    data['total_pages'] = this.totalPages;
    return data;
  }
}
