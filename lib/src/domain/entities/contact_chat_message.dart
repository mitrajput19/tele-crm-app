class ContactChat {
  int? id;
  int? conversationId;
  int? senderId;
  int? receiverId;
  ChatContent? content;
  String? readAt;
  String? status;
  String? createdAt;

  ContactChat({
    this.id,
    this.conversationId,
    this.senderId,
    this.receiverId,
    this.content,
    this.readAt,
    this.status,
    this.createdAt,
  });

  ContactChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    content = json['content'] != null ? new ChatContent.fromJson(json['content']) : null;
    readAt = json['read_at'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['conversation_id'] = this.conversationId;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['read_at'] = this.readAt;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }

  static List<ContactChat> listFromJson(dynamic json) {
    List<ContactChat> list = [];
    if (json != null) {
      json.forEach((v) {
        list.add(new ContactChat.fromJson(v));
      });
    }
    return list;
  }
}

class ChatContent {
  String? from;
  String? to;
  String? sender;
  String? reciever;
  String? message;
  String? mimeType;
  String? timestamp;

  ChatContent({
    this.from,
    this.to,
    this.sender,
    this.reciever,
    this.message,
    this.mimeType,
    this.timestamp,
  });

  ChatContent.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    sender = json['sender'];
    reciever = json['reciever'];
    message = json['message'];
    mimeType = json['mime_type'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['sender'] = this.sender;
    data['reciever'] = this.reciever;
    data['message'] = this.message;
    data['mime_type'] = this.mimeType;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
