import 'location_details.dart';

class ChatItem {
  final ChatMessage? chatMessage;
  final List<ChatMessage?>? imageSequence;

  ChatItem({this.chatMessage, this.imageSequence});

  bool get isChatMessage => chatMessage != null;
  bool get isImageSequence => imageSequence != null;
}

class ChatMessage {
  String? messageId;
  String? senderId;
  String? receiverId;
  String? message;
  String? type;
  String? timeStamp;
  String? isSeenTimeStamp;
  bool? isSeen;
  bool? isReply;
  bool? isForwarded;
  LocationDetails? locationData;
  String? repliedMessage;
  String? repliedMessageType;
  String? repliedMessageId;
  String? repliedMessageSenderId;
  String? repliedMessageReceiverId;

  ChatMessage({
    this.messageId,
    this.senderId,
    this.receiverId,
    this.message,
    this.type,
    this.timeStamp,
    this.isSeen,
    this.isSeenTimeStamp,
    this.isForwarded,
    this.isReply,
    this.locationData,
    this.repliedMessage,
    this.repliedMessageType,
    this.repliedMessageId,
    this.repliedMessageSenderId,
    this.repliedMessageReceiverId,
  });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    messageId = json['messageId'];
    type = json['type'];
    timeStamp = json['timeStamp'];
    isSeenTimeStamp = json['isSeenTimeStamp'];
    isSeen = json['isSeen'];
    isForwarded = json['isForwarded'];
    isReply = json['isReply'];
    locationData = json['locationData'] != null ? LocationDetails.fromJson(json['locationData']) : null;
    repliedMessage = json['repliedMessage'];
    repliedMessageType = json['repliedMessageType'];
    repliedMessageId = json['repliedMessageId'];
    repliedMessageSenderId = json['repliedMessageSenderId'];
    repliedMessageReceiverId = json['repliedMessageReceiverId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['message'] = this.message;
    data['messageId'] = this.messageId;
    data['type'] = this.type;
    data['timeStamp'] = this.timeStamp;
    data['isSeenTimeStamp'] = this.isSeenTimeStamp;
    data['isSeen'] = this.isSeen;
    data['isForwarded'] = this.isForwarded;
    data['isReply'] = this.isReply;
    data['locationData'] = this.locationData?.toJson();
    data['repliedMessage'] = this.repliedMessage;
    data['repliedMessageType'] = this.repliedMessageType;
    data['repliedMessageId'] = this.repliedMessageId;
    data['repliedMessageSenderId'] = this.repliedMessageSenderId;
    data['repliedMessageReceiverId'] = this.repliedMessageReceiverId;
    return data;
  }
}
