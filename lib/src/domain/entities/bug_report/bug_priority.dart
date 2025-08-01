class BugPriority {
  int? bugPriorityId;
  String? bugPriorityName;
  String? bugPriorityDescription;
  String? bugPriorityBgcolor;
  String? bugPriorityTextcolor;

  BugPriority({
    this.bugPriorityId,
    this.bugPriorityName,
    this.bugPriorityDescription,
    this.bugPriorityBgcolor,
    this.bugPriorityTextcolor,
  });

  BugPriority.fromJson(Map<String, dynamic> json) {
    bugPriorityId = json['bug_priority_id'];
    bugPriorityName = json['bug_priority_name'];
    bugPriorityDescription = json['bug_priority_description'];
    bugPriorityBgcolor = json['bug_priority_bgcolor'];
    bugPriorityTextcolor = json['bug_priority_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_priority_id'] = this.bugPriorityId;
    data['bug_priority_name'] = this.bugPriorityName;
    data['bug_priority_description'] = this.bugPriorityDescription;
    data['bug_priority_bgcolor'] = this.bugPriorityBgcolor;
    data['bug_priority_textcolor'] = this.bugPriorityTextcolor;
    return data;
  }

  static List<BugPriority> listFromJson(dynamic json) {
    List<BugPriority> list = [];
    if (json['bug_priority_master'] != null) {
      json['bug_priority_master'].forEach((v) {
        list.add(new BugPriority.fromJson(v));
      });
    }
    return list;
  }
}
