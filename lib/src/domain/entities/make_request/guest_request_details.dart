import '../../../app/app.dart';

class GuestRequestDetails {
  int? makeARequestId;
  RequestGuestInfo? guestDetails;
  String? requestCategory;
  String? requestName;
  String? deadlineDate;
  String? deadlineTime;
  String? deadlineDatetime;
  String? numberOfPeople;
  String? finalDuration;
  String? additionalNotes;
  List<MakeRequestFile>? files;
  StatusInfo? makeARequestStatus;

  GuestRequestDetails({
    this.makeARequestId,
    this.guestDetails,
    this.requestCategory,
    this.requestName,
    this.deadlineDate,
    this.deadlineTime,
    this.deadlineDatetime,
    this.numberOfPeople,
    this.finalDuration,
    this.additionalNotes,
    this.files,
    this.makeARequestStatus,
  });

  GuestRequestDetails.fromJson(Map<String, dynamic> json) {
    makeARequestId = json['make_a_request_id'];
    guestDetails = json['guest_details'] != null ? new RequestGuestInfo.fromJson(json['guest_details']) : null;
    requestCategory = json['request_category'];
    requestName = json['request_name'];
    deadlineDate = json['deadline_date'];
    deadlineTime = json['deadline_time'];
    deadlineDatetime = json['deadline_datetime'];
    numberOfPeople = json['number_of_people'];
    finalDuration = json['final_duration'];
    additionalNotes = json['additional_notes'];
    if (json['files'] != null) {
      files = <MakeRequestFile>[];
      json['files'].forEach((v) {
        files!.add(new MakeRequestFile.fromJson(v));
      });
    }
    makeARequestStatus =
        json['make_a_request_status'] != null ? new StatusInfo.fromJson(json['make_a_request_status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['make_a_request_id'] = this.makeARequestId;
    if (this.guestDetails != null) {
      data['guest_details'] = this.guestDetails!.toJson();
    }
    data['request_category'] = this.requestCategory;
    data['request_name'] = this.requestName;
    data['deadline_date'] = this.deadlineDate;
    data['deadline_time'] = this.deadlineTime;
    data['deadline_datetime'] = this.deadlineDatetime;
    data['number_of_people'] = this.numberOfPeople;
    data['final_duration'] = this.finalDuration;
    data['additional_notes'] = this.additionalNotes;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.makeARequestStatus != null) {
      data['make_a_request_status'] = this.makeARequestStatus!.toJson();
    }
    return data;
  }

  static List<GuestRequestDetails> listFromJson(dynamic json) {
    List<GuestRequestDetails> list = [];
    if (json['details']['requests'] != null) {
      json['details']['requests'].forEach((v) {
        list.add(GuestRequestDetails.fromJson(v));
      });
    }
    return list;
  }
}

class RequestGuestInfo {
  String? guestEmail;
  String? guestName;

  RequestGuestInfo({this.guestEmail, this.guestName});

  RequestGuestInfo.fromJson(Map<String, dynamic> json) {
    guestEmail = json['guest_email'];
    guestName = json['guest_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guest_email'] = this.guestEmail;
    data['guest_name'] = this.guestName;
    return data;
  }
}

class MakeRequestFile {
  int? assetId;
  String? fileName;
  String? fileType;
  String? fileUrl;

  MakeRequestFile({
    this.assetId,
    this.fileName,
    this.fileType,
    this.fileUrl,
  });

  MakeRequestFile.fromJson(Map<String, dynamic> json) {
    assetId = json['asset_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset_id'] = this.assetId;
    data['file_name'] = this.fileName;
    data['file_type'] = this.fileType;
    data['file_url'] = this.fileUrl;
    return data;
  }
}
