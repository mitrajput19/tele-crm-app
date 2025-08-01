class ContactChatMessageRequest {
  String? type;
  String? action;
  int? userId;
  String? username;
  int? id;
  String? user;
  String? data;
  String? timestamp;

  ContactChatMessageRequest({
    this.type,
    this.action,
    this.userId,
    this.username,
    this.id,
    this.user,
    this.data,
    this.timestamp,
  });

  ContactChatMessageRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    action = json['action'];
    userId = json['user_id'];
    username = json['username'];
    id = json['id'];
    user = json['user'];
    data = json['data'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['action'] = this.action;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['id'] = this.id;
    data['user'] = this.user;
    data['data'] = this.data;
    data['timestamp'] = this.timestamp;
    return data;
  }

  ContactChatMessageRequest copyWith({
    String? type,
    String? action,
    int? userId,
    String? username,
    int? id,
    String? user,
    String? data,
    String? timestamp,
  }) {
    return ContactChatMessageRequest(
      type: type ?? this.type,
      action: action ?? this.action,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      id: id ?? this.id,
      user: user ?? this.user,
      data: data ?? this.data,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
