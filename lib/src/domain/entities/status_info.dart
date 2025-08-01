class StatusInfo {
  int? statusId;
  String? code;
  String? label;
  StatusColors? colors;

  StatusInfo({
    this.statusId,
    this.code,
    this.label,
    this.colors,
  });

  StatusInfo.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    code = json['code'];
    label = json['label'];
    colors = json['colors'] != null ? new StatusColors.fromJson(json['colors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_id'] = this.statusId;
    data['code'] = this.code;
    data['label'] = this.label;
    if (this.colors != null) {
      data['colors'] = this.colors!.toJson();
    }
    return data;
  }
}

class StatusColors {
  String? background;
  String? foreground;

  StatusColors({
    this.background,
    this.foreground,
  });

  StatusColors.fromJson(Map<String, dynamic> json) {
    background = json['background'];
    foreground = json['foreground'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['background'] = this.background;
    data['foreground'] = this.foreground;
    return data;
  }
}
