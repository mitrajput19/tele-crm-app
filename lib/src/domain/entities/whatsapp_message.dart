
class WhatsAppMessage {
  final String id;
  final String contactId;
  final String phoneNumber;
  final String messageType; // 'text', 'template', 'media', 'interactive'
  final String content;
  final String status; // 'sent', 'delivered', 'read', 'failed'
  final String direction; // 'outbound', 'inbound'
  final DateTime sentAt;
  final DateTime? deliveredAt;
  final DateTime? readAt;
  final String? templateName;
  final List<String>? templateParams;
  final String? mediaUrl;
  final String? mediaType;
  final Map<String, dynamic>? interactiveData;
  final String? errorMessage;
  final String agentId;

  WhatsAppMessage({
    required this.id,
    required this.contactId,
    required this.phoneNumber,
    required this.messageType,
    required this.content,
    required this.status,
    required this.direction,
    required this.sentAt,
    this.deliveredAt,
    this.readAt,
    this.templateName,
    this.templateParams,
    this.mediaUrl,
    this.mediaType,
    this.interactiveData,
    this.errorMessage,
    required this.agentId,
  });

  factory WhatsAppMessage.fromJson(Map<String, dynamic> json) => WhatsAppMessage(
    id: json['id'],
    contactId: json['contact_id'],
    phoneNumber: json['phone_number'],
    messageType: json['message_type'],
    content: json['content'],
    status: json['status'],
    direction: json['direction'],
    sentAt: DateTime.parse(json['sent_at']),
    deliveredAt: json['delivered_at'] != null ? DateTime.parse(json['delivered_at']) : null,
    readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
    templateName: json['template_name'],
    templateParams: json['template_params']?.cast<String>(),
    mediaUrl: json['media_url'],
    mediaType: json['media_type'],
    interactiveData: json['interactive_data'],
    errorMessage: json['error_message'],
    agentId: json['agent_id'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'contact_id': contactId,
    'phone_number': phoneNumber,
    'message_type': messageType,
    'content': content,
    'status': status,
    'direction': direction,
    'sent_at': sentAt.toIso8601String(),
    'delivered_at': deliveredAt?.toIso8601String(),
    'read_at': readAt?.toIso8601String(),
    'template_name': templateName,
    'template_params': templateParams,
    'media_url': mediaUrl,
    'media_type': mediaType,
    'interactive_data': interactiveData,
    'error_message': errorMessage,
    'agent_id': agentId,
  };
}
