class MainMenuDropdownData {
  List<MainMenuDropdownOption> options;
  String? selectedId;

  MainMenuDropdownData({
    required this.options,
    required this.selectedId,
  });
}

class MainMenuDropdownOption {
  String? mdId;
  String? mdName;
  String? mdSlug;

  MainMenuDropdownOption({
    this.mdId,
    this.mdName,
    this.mdSlug,
  });

  MainMenuDropdownOption.fromJson(Map<String, dynamic> json) {
    mdId = json['md_id'];
    mdName = json['md_name'];
    mdSlug = json['md_slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['md_id'] = this.mdId;
    data['md_name'] = this.mdName;
    data['md_slug'] = this.mdSlug;
    return data;
  }
}

class MainMenuData {
  String? mdId;
  String? mdName;
  String? mdSlug;
  String? mdIdPrevious;

  MainMenuData({
    this.mdId,
    this.mdName,
    this.mdSlug,
    this.mdIdPrevious,
  });

  MainMenuData.fromJson(Map<String, dynamic> json) {
    mdId = json['md_id'];
    mdName = json['md_name'];
    mdSlug = json['md_slug'];
    mdIdPrevious = json['md_id_previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['md_id'] = this.mdId;
    data['md_name'] = this.mdName;
    data['md_slug'] = this.mdSlug;
    data['md_id_previous'] = this.mdIdPrevious;
    return data;
  }

  static List<MainMenuData> listFromJson(dynamic json) {
    List<MainMenuData> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new MainMenuData.fromJson(v));
      });
    }
    return list;
  }
}
