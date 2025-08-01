class RequestCallbackDetails {
  int? currentPage;
  List<RequestCallback>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<RequestCallbackLinks>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  RequestCallbackDetails({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  RequestCallbackDetails.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <RequestCallback>[];
      json['data'].forEach((v) {
        data!.add(new RequestCallback.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <RequestCallbackLinks>[];
      json['links'].forEach((v) {
        links!.add(new RequestCallbackLinks.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class RequestCallback {
  int? fourRoomsHotelRequestCallbackId;
  int? accountId;
  int? companyId;
  int? employeeId;
  int? fourroomsStaffId;
  String? callbackDate;
  String? datetimeCallInitiatedByAccountManager;
  String? timeRange;
  int? callbackStatus;
  String? hotelNotes;
  String? callbackDateFormat;
  String? datetimeCallInitiatedByAccountManagerFormat;
  String? callbackStatusName;
  String? callbackStatusColor;
  RequestCallbackStaffDetails? staffDetails;

  RequestCallback({
    this.fourRoomsHotelRequestCallbackId,
    this.accountId,
    this.companyId,
    this.employeeId,
    this.fourroomsStaffId,
    this.callbackDate,
    this.datetimeCallInitiatedByAccountManager,
    this.timeRange,
    this.callbackStatus,
    this.hotelNotes,
    this.callbackDateFormat,
    this.datetimeCallInitiatedByAccountManagerFormat,
    this.callbackStatusName,
    this.callbackStatusColor,
    this.staffDetails,
  });

  RequestCallback.fromJson(Map<String, dynamic> json) {
    fourRoomsHotelRequestCallbackId = json['four_rooms_hotel_request_callback_id'];
    accountId = json['account_id'];
    companyId = json['company_id'];
    employeeId = json['employee_id'];
    fourroomsStaffId = json['fourrooms_staff_id'];
    callbackDate = json['callback_date'];
    datetimeCallInitiatedByAccountManager = json['datetime_call_initiated_by_account_manager'];
    timeRange = json['time_range'];
    callbackStatus = json['callback_status'];
    hotelNotes = json['hotel_notes'];
    callbackDateFormat = json['callback_date_format'];
    datetimeCallInitiatedByAccountManagerFormat = json['datetime_call_initiated_by_account_manager_format'];
    callbackStatusName = json['callback_status_name'];
    callbackStatusColor = json['callback_status_color'];
    staffDetails =
        json['staff_details'] != null ? new RequestCallbackStaffDetails.fromJson(json['staff_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['four_rooms_hotel_request_callback_id'] = this.fourRoomsHotelRequestCallbackId;
    data['account_id'] = this.accountId;
    data['company_id'] = this.companyId;
    data['employee_id'] = this.employeeId;
    data['fourrooms_staff_id'] = this.fourroomsStaffId;
    data['callback_date'] = this.callbackDate;
    data['datetime_call_initiated_by_account_manager'] = this.datetimeCallInitiatedByAccountManager;
    data['time_range'] = this.timeRange;
    data['callback_status'] = this.callbackStatus;
    data['hotel_notes'] = this.hotelNotes;
    data['callback_date_format'] = this.callbackDateFormat;
    data['datetime_call_initiated_by_account_manager_format'] = this.datetimeCallInitiatedByAccountManagerFormat;
    data['callback_status_name'] = this.callbackStatusName;
    data['callback_status_color'] = this.callbackStatusColor;
    if (this.staffDetails != null) {
      data['staff_details'] = this.staffDetails!.toJson();
    }
    return data;
  }
}

class RequestCallbackStaffDetails {
  int? fourroomsStaffId;
  String? fourroomsStaffName;
  String? fourroomsStaffEmail;
  int? fourroomsStaffStatus;

  RequestCallbackStaffDetails({
    this.fourroomsStaffId,
    this.fourroomsStaffName,
    this.fourroomsStaffEmail,
    this.fourroomsStaffStatus,
  });

  RequestCallbackStaffDetails.fromJson(Map<String, dynamic> json) {
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

class RequestCallbackLinks {
  String? url;
  String? label;
  bool? active;

  RequestCallbackLinks({
    this.url,
    this.label,
    this.active,
  });

  RequestCallbackLinks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
