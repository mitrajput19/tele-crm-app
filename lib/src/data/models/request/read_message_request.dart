class ReadMessageStatusRequest {
  String? type;
  String? action;
  String? status;
  int? senderId;
  int? receiverId;

  ReadMessageStatusRequest({
    this.type,
    this.action,
    this.status,
    this.senderId,
    this.receiverId,
  });

  ReadMessageStatusRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    action = json['action'];
    status = json['status'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['action'] = this.action;
    data['status'] = this.status;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    return data;
  }

  ReadMessageStatusRequest copyWith({
    String? type,
    String? action,
    String? status,
    int? senderId,
    int? receiverId,
  }) {
    return ReadMessageStatusRequest(
      type: type ?? this.type,
      action: action ?? this.action,
      status: status ?? this.status,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
    );
  }
}
