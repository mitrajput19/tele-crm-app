class OnlineUser {
  String? id;
  int? userId;
  bool? connected;

  OnlineUser({
    this.id,
    this.userId,
    this.connected,
  });

  OnlineUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    connected = json['connected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['connected'] = this.connected;
    return data;
  }

  static List<OnlineUser> listFromJson(dynamic json) {
    List<OnlineUser> list = [];
    if (json['online_users'] != null) {
      json['online_users'].forEach((v) {
        list.add(new OnlineUser.fromJson(v));
      });
    }
    return list;
  }
}
