class ContactChatFileRequest {
  String? type;
  String? action;
  int? userId;
  String? username;
  int? id;
  String? user;

  ContactChatFileRequest({
    this.type,
    this.action,
    this.userId,
    this.username,
    this.id,
    this.user,
  });

  ContactChatFileRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    action = json['action'];
    userId = json['user_id'];
    username = json['username'];
    id = json['id'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['action'] = this.action;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['id'] = this.id;
    data['user'] = this.user;
    return data;
  }

  ContactChatFileRequest copyWith({
    String? type,
    String? action,
    int? userId,
    String? username,
  }) {
    return ContactChatFileRequest(
      type: type ?? this.type,
      action: action ?? this.action,
      userId: userId ?? this.userId,
      username: username ?? this.username,
    );
  }
}
