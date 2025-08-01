class BugLabel {
  int? bugLabelId;
  String? bugLabelName;
  String? bugLabelDescription;
  String? bugLabelBgcolor;
  String? bugLabelTextcolor;

  BugLabel({
    this.bugLabelId,
    this.bugLabelName,
    this.bugLabelDescription,
    this.bugLabelBgcolor,
    this.bugLabelTextcolor,
  });

  BugLabel.fromJson(Map<String, dynamic> json) {
    bugLabelId = json['bug_label_id'];
    bugLabelName = json['bug_label_name'];
    bugLabelDescription = json['bug_label_description'];
    bugLabelBgcolor = json['bug_label_bgcolor'];
    bugLabelTextcolor = json['bug_label_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_label_id'] = this.bugLabelId;
    data['bug_label_name'] = this.bugLabelName;
    data['bug_label_description'] = this.bugLabelDescription;
    data['bug_label_bgcolor'] = this.bugLabelBgcolor;
    data['bug_label_textcolor'] = this.bugLabelTextcolor;
    return data;
  }

  static List<BugLabel> listFromJson(dynamic json) {
    List<BugLabel> list = [];
    if (json['bug_label_master'] != null) {
      json['bug_label_master'].forEach((v) {
        list.add(new BugLabel.fromJson(v));
      });
    }
    return list;
  }
}
