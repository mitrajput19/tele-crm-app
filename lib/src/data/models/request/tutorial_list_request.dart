class TutorialListRequest {
  String? token;
  int? languageId;
  String? searchValue;
  int? perPage;
  int? page;

  TutorialListRequest({
    this.token,
    this.languageId,
    this.searchValue,
    this.perPage = 10,
    this.page,
  });

  TutorialListRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    languageId = json['language_id'];
    searchValue = json['search_value'];
    perPage = json['per_page'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['language_id'] = this.languageId;
    data['search_value'] = this.searchValue;
    data['per_page'] = this.perPage;
    data['page'] = this.page;
    return data;
  }
}
