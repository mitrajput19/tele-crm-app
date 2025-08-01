class MakeRequestGuestCategoryType {
  int? makeARequestTypeId;
  int? makeARequestCategoryId;
  String? makeARequestTypeTitle;

  MakeRequestGuestCategoryType({
    this.makeARequestTypeId,
    this.makeARequestCategoryId,
    this.makeARequestTypeTitle,
  });

  MakeRequestGuestCategoryType.fromJson(Map<String, dynamic> json) {
    makeARequestTypeId = json['make_a_request_type_id'];
    makeARequestCategoryId = json['make_a_request_category_id'];
    makeARequestTypeTitle = json['make_a_request_type_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['make_a_request_type_id'] = this.makeARequestTypeId;
    data['make_a_request_category_id'] = this.makeARequestCategoryId;
    data['make_a_request_type_title'] = this.makeARequestTypeTitle;
    return data;
  }

  static List<MakeRequestGuestCategoryType> listFromJson(dynamic json) {
    List<MakeRequestGuestCategoryType> list = [];
    if (json['details']['types'] != null) {
      json['details']['types'].forEach((v) {
        list.add(new MakeRequestGuestCategoryType.fromJson(v));
      });
    }
    return list;
  }
}


