class TaskChipInfo {
  String? status;
  String? displayText;
  String? bgColor;
  String? textColor;

  TaskChipInfo({
    this.status,
    this.displayText,
    this.bgColor,
    this.textColor,
  });

  TaskChipInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    displayText = json['display_text'];
    bgColor = json['bgcolor'];
    textColor = json['textcolor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['display_text'] = this.displayText;
    data['bgcolor'] = this.bgColor;
    data['textcolor'] = this.textColor;
    return data;
  }

  static List<TaskChipInfo> listFromJson(dynamic json) {
    List<TaskChipInfo> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new TaskChipInfo.fromJson(v));
      });
    }
    return list;
  }
}
