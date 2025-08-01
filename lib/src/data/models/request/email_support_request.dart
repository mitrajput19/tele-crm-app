class EmailSupportRequest {
  String? fourroomsStaffEmail;
  String? emailSubject;
  String? emailMessage;

  EmailSupportRequest({
    this.fourroomsStaffEmail,
    this.emailSubject,
    this.emailMessage,
  });

  EmailSupportRequest.fromJson(Map<String, dynamic> json) {
    fourroomsStaffEmail = json['fourrooms_staff_email'];
    emailSubject = json['email_subject'];
    emailMessage = json['email_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fourrooms_staff_email'] = this.fourroomsStaffEmail;
    data['email_subject'] = this.emailSubject;
    data['email_message'] = this.emailMessage;
    return data;
  }
}
