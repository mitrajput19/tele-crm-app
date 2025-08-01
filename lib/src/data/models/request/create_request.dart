class CreateRequest {
  int? guestAccountId;
  int? makeARequestCategoryId;
  int? makeARequestTypeId;
  String? numberOfPeople;
  String? deadlineDate;
  String? deadlineTime;
  String? finalDuration;
  String? additionalNotes;

  CreateRequest({
    this.guestAccountId,
    this.makeARequestCategoryId,
    this.makeARequestTypeId,
    this.numberOfPeople,
    this.deadlineDate,
    this.deadlineTime,
    this.finalDuration,
    this.additionalNotes,
  });

  CreateRequest.fromJson(Map<String, dynamic> json) {
    guestAccountId = json['guest_account_id'];
    makeARequestCategoryId = json['make_a_request_category_id'];
    makeARequestTypeId = json['make_a_request_type_id'];
    numberOfPeople = json['number_of_people'];
    deadlineDate = json['deadline_date'];
    deadlineTime = json['deadline_time'];
    finalDuration = json['final_duration'];
    additionalNotes = json['additional_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guest_account_id'] = this.guestAccountId;
    data['make_a_request_category_id'] = this.makeARequestCategoryId;
    data['make_a_request_type_id'] = this.makeARequestTypeId;
    data['number_of_people'] = this.numberOfPeople;
    data['deadline_date'] = this.deadlineDate;
    data['deadline_time'] = this.deadlineTime;
    data['final_duration'] = this.finalDuration;
    data['additional_notes'] = this.additionalNotes;
    return data;
  }
}
