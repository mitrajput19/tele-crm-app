class BugStatus {
  int? bugStatusId;
  String? bugStatusName;
  String? bugStatusDescription;
  String? bugStatusBgcolor;
  String? bugStatusTextcolor;

  BugStatus({
    this.bugStatusId,
    this.bugStatusName,
    this.bugStatusDescription,
    this.bugStatusBgcolor,
    this.bugStatusTextcolor,
  });

  BugStatus.fromJson(Map<String, dynamic> json) {
    bugStatusId = json['bug_status_id'];
    bugStatusName = json['bug_status_name'];
    bugStatusDescription = json['bug_status_description'];
    bugStatusBgcolor = json['bug_status_bgcolor'];
    bugStatusTextcolor = json['bug_status_textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bug_status_id'] = this.bugStatusId;
    data['bug_status_name'] = this.bugStatusName;
    data['bug_status_description'] = this.bugStatusDescription;
    data['bug_status_bgcolor'] = this.bugStatusBgcolor;
    data['bug_status_textcolor'] = this.bugStatusTextcolor;
    return data;
  }

  static List<BugStatus> listFromJson(dynamic json) {
    List<BugStatus> list = [];
    if (json['bug_status_master'] != null) {
      json['bug_status_master'].forEach((v) {
        list.add(new BugStatus.fromJson(v));
      });
    }
    return list;
  }
}
