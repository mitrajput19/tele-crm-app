class MakeRequestGuestCategory {
  int? makeARequestCategoryId;
  String? makeARequestCategoryName;
  String? makeARequestCategoryShortName;
  String? makeARequestCategoryDescription;
  String? makeARequestCategoryIconUrl;
  String? makeARequestCategoryType;
  String? promptDescription;

  MakeRequestGuestCategory({
    this.makeARequestCategoryId,
    this.makeARequestCategoryName,
    this.makeARequestCategoryShortName,
    this.makeARequestCategoryDescription,
    this.makeARequestCategoryIconUrl,
    this.makeARequestCategoryType,
    this.promptDescription,
  });

  MakeRequestGuestCategory.fromJson(Map<String, dynamic> json) {
    makeARequestCategoryId = json['make_a_request_category_id'];
    makeARequestCategoryName = json['make_a_request_category_name'];
    makeARequestCategoryShortName = json['make_a_request_category_short_name'];
    makeARequestCategoryDescription = json['make_a_request_category_description'];
    makeARequestCategoryIconUrl = json['make_a_request_category_icon_url'];
    makeARequestCategoryType = json['make_a_request_category_type'];
    promptDescription = json['prompt_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['make_a_request_category_id'] = this.makeARequestCategoryId;
    data['make_a_request_category_name'] = this.makeARequestCategoryName;
    data['make_a_request_category_short_name'] = this.makeARequestCategoryShortName;
    data['make_a_request_category_description'] = this.makeARequestCategoryDescription;
    data['make_a_request_category_icon_url'] = this.makeARequestCategoryIconUrl;
    data['make_a_request_category_type'] = this.makeARequestCategoryType;
    data['prompt_description'] = this.promptDescription;
    return data;
  }

  static List<MakeRequestGuestCategory> listFromJson(dynamic json) {
    List<MakeRequestGuestCategory> list = [];
    if (json['details']['categories'] != null) {
      json['details']['categories'].forEach((v) {
        list.add(MakeRequestGuestCategory.fromJson(v));
      });
    }
    return list;
  }
}
