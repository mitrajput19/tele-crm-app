class GeneralPriority {
  int? generalPriorityId;
  String? generalPriorityName;
  String? generalPriorityDescription;
  String? generalPriorityBgcolor;
  String? generalPriorityTextcolor;

  GeneralPriority({
    this.generalPriorityId,
    this.generalPriorityName,
    this.generalPriorityDescription,
    this.generalPriorityBgcolor,
    this.generalPriorityTextcolor,
  });

  GeneralPriority.fromJson(Map<String, dynamic> json) {
    generalPriorityId = json['general_priority_id'];
    generalPriorityName = json['general_priority_name'];
    generalPriorityDescription = json['general_priority_description'];
    generalPriorityBgcolor = json['general_priority_bgcolor'];
    generalPriorityTextcolor = json['general_priority_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['general_priority_id'] = this.generalPriorityId;
    data['general_priority_name'] = this.generalPriorityName;
    data['general_priority_description'] = this.generalPriorityDescription;
    data['general_priority_bgcolor'] = this.generalPriorityBgcolor;
    data['general_priority_textcolor'] = this.generalPriorityTextcolor;
    return data;
  }

  static List<GeneralPriority> listFromJson(dynamic json) {
    List<GeneralPriority> list = [];
    if (json['general_priority_master'] != null) {
      json['general_priority_master'].forEach((v) {
        list.add(new GeneralPriority.fromJson(v));
      });
    }
    return list;
  }
}
