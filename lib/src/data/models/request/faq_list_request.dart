class FaqListRequest {
  String? token;
  int? perPage;
  int? page;
  String? searchValue;

  FaqListRequest({
    this.token,
    this.perPage = 10,
    this.page = 1,
    this.searchValue,
  });

  FaqListRequest.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    perPage = json['per_page'];
    page = json['page'];
    searchValue = json['search_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['per_page'] = this.perPage;
    data['page'] = this.page;
    data['search_value'] = this.searchValue;
    return data;
  }
}
