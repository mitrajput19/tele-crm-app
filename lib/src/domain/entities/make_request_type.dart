class MakeRequestType {
  int? makeARequestTypeId;
  int? taskApplicationTypeId;
  String? taskApplicationTypeName;
  String? makeARequestTypeTitle;
  String? makeARequestTypeDescription;
  int? isApplicableForGuest;
  int? isApplicableForInternalEmployees;
  int? isApplicableForExternalEmployees;

  MakeRequestType({
    this.makeARequestTypeId,
    this.taskApplicationTypeId,
    this.taskApplicationTypeName,
    this.makeARequestTypeTitle,
    this.makeARequestTypeDescription,
    this.isApplicableForGuest,
    this.isApplicableForInternalEmployees,
    this.isApplicableForExternalEmployees,
  });

  MakeRequestType.fromJson(Map<String, dynamic> json) {
    makeARequestTypeId = json['make_a_request_type_id'];
    taskApplicationTypeId = json['task_application_type_id'];
    taskApplicationTypeName = json['task_application_type_name'];
    makeARequestTypeTitle = json['make_a_request_type_title'];
    makeARequestTypeDescription = json['make_a_request_type_description'];
    isApplicableForGuest = json['is_applicable_for_guest'];
    isApplicableForInternalEmployees = json['is_applicable_for_internal_employees'];
    isApplicableForExternalEmployees = json['is_applicable_for_external_employees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['make_a_request_type_id'] = this.makeARequestTypeId;
    data['task_application_type_id'] = this.taskApplicationTypeId;
    data['task_application_type_name'] = this.taskApplicationTypeName;
    data['make_a_request_type_title'] = this.makeARequestTypeTitle;
    data['make_a_request_type_description'] = this.makeARequestTypeDescription;
    data['is_applicable_for_guest'] = this.isApplicableForGuest;
    data['is_applicable_for_internal_employees'] = this.isApplicableForInternalEmployees;
    data['is_applicable_for_external_employees'] = this.isApplicableForExternalEmployees;
    return data;
  }

  static List<MakeRequestType> listFromJson(dynamic json) {
    List<MakeRequestType> list = [];
    if (json['details']['make_a_request_type_list'] != null) {
      json['details']['make_a_request_type_list'].forEach((v) {
        list.add(new MakeRequestType.fromJson(v));
      });
    }
    return list;
  }
}
