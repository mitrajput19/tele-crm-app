
class CallRequest {
  final String id;
  final String leadId;
  final String customerName;
  final String phoneNumber;
  final String? alternatePhone;
  final String status; // 'pending', 'in_progress', 'completed', 'failed'
  final String priority; // 'high', 'medium', 'low'
  final String? assignedTo;
  final DateTime requestedAt;
  final DateTime? scheduledAt;
  final String? notes;
  final String source; // 'web', 'mobile', 'api'
  final Map<String, dynamic>? metadata;

  CallRequest({
    required this.id,
    required this.leadId,
    required this.customerName,
    required this.phoneNumber,
    this.alternatePhone,
    required this.status,
    required this.priority,
    this.assignedTo,
    required this.requestedAt,
    this.scheduledAt,
    this.notes,
    required this.source,
    this.metadata,
  });

  factory CallRequest.fromJson(Map<String, dynamic> json) => CallRequest(
    id: json['id'],
    leadId: json['lead_id'],
    customerName: json['customer_name'],
    phoneNumber: json['phone_number'],
    alternatePhone: json['alternate_phone'],
    status: json['status'],
    priority: json['priority'],
    assignedTo: json['assigned_to'],
    requestedAt: DateTime.parse(json['requested_at']),
    scheduledAt: json['scheduled_at'] != null ? DateTime.parse(json['scheduled_at']) : null,
    notes: json['notes'],
    source: json['source'],
    metadata: json['metadata'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'lead_id': leadId,
    'customer_name': customerName,
    'phone_number': phoneNumber,
    'alternate_phone': alternatePhone,
    'status': status,
    'priority': priority,
    'assigned_to': assignedTo,
    'requested_at': requestedAt.toIso8601String(),
    'scheduled_at': scheduledAt?.toIso8601String(),
    'notes': notes,
    'source': source,
    'metadata': metadata,
  };

  CallRequest copyWith({
    String? id,
    String? leadId,
    String? customerName,
    String? phoneNumber,
    String? alternatePhone,
    String? status,
    String? priority,
    String? assignedTo,
    DateTime? requestedAt,
    DateTime? scheduledAt,
    String? notes,
    String? source,
    Map<String, dynamic>? metadata,
  }) {
    return CallRequest(
      id: id ?? this.id,
      leadId: leadId ?? this.leadId,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      alternatePhone: alternatePhone ?? this.alternatePhone,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedTo: assignedTo ?? this.assignedTo,
      requestedAt: requestedAt ?? this.requestedAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      notes: notes ?? this.notes,
      source: source ?? this.source,
      metadata: metadata ?? this.metadata,
    );
  }
}
