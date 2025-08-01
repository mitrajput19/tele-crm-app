class BugSeverity {
  int? bugSeverityId;
  String? bugSeverityName;
  String? bugSeverityDescription;
  String? bugSeverityBgcolor;
  String? bugSeverityTextcolor;

  BugSeverity({
    this.bugSeverityId,
    this.bugSeverityName,
    this.bugSeverityDescription,
    this.bugSeverityBgcolor,
    this.bugSeverityTextcolor,
  });

  BugSeverity.fromJson(Map<String, dynamic> json) {
    bugSeverityId = json['bug_severity_id'];
    bugSeverityName = json['bug_severity_name'];
    bugSeverityDescription = json['bug_severity_description'];
    bugSeverityBgcolor = json['bug_severity_bgcolor'];
    bugSeverityTextcolor = json['bug_severity_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_severity_id'] = this.bugSeverityId;
    data['bug_severity_name'] = this.bugSeverityName;
    data['bug_severity_description'] = this.bugSeverityDescription;
    data['bug_severity_bgcolor'] = this.bugSeverityBgcolor;
    data['bug_severity_textcolor'] = this.bugSeverityTextcolor;
    return data;
  }

  static List<BugSeverity> listFromJson(dynamic json) {
    List<BugSeverity> list = [];
    if (json['bug_severity_master'] != null) {
      json['bug_severity_master'].forEach((v) {
        list.add(new BugSeverity.fromJson(v));
      });
    }
    return list;
  }
}
