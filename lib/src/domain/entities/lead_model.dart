
class Lead {
  final String id;
  final String customerName;
  final String email;
  final String phoneNumber;
  final String? alternatePhone;
  final String? company;
  final String status;
  final String priority;
  final String source;
  final String? assignedTo;
  final String? assignedToName;
  final DateTime createdAt;
  final DateTime? lastContactedAt;
  final DateTime? nextFollowUp;
  final String? notes;
  final Map<String, dynamic>? customFields;
  final double? estimatedValue;
  final String? stage;

  Lead({
    required this.id,
    required this.customerName,
    required this.email,
    required this.phoneNumber,
    this.alternatePhone,
    this.company,
    required this.status,
    required this.priority,
    required this.source,
    this.assignedTo,
    this.assignedToName,
    required this.createdAt,
    this.lastContactedAt,
    this.nextFollowUp,
    this.notes,
    this.customFields,
    this.estimatedValue,
    this.stage,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
    id: json['id'],
    customerName: json['customer_name'],
    email: json['email'],
    phoneNumber: json['phone_number'],
    alternatePhone: json['alternate_phone'],
    company: json['company'],
    status: json['status'],
    priority: json['priority'],
    source: json['source'],
    assignedTo: json['assigned_to'],
    assignedToName: json['assigned_to_name'],
    createdAt: DateTime.parse(json['created_at']),
    lastContactedAt: json['last_contacted_at'] != null 
        ? DateTime.parse(json['last_contacted_at']) 
        : null,
    nextFollowUp: json['next_follow_up'] != null 
        ? DateTime.parse(json['next_follow_up']) 
        : null,
    notes: json['notes'],
    customFields: json['custom_fields'],
    estimatedValue: json['estimated_value']?.toDouble(),
    stage: json['stage'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'customer_name': customerName,
    'email': email,
    'phone_number': phoneNumber,
    'alternate_phone': alternatePhone,
    'company': company,
    'status': status,
    'priority': priority,
    'source': source,
    'assigned_to': assignedTo,
    'assigned_to_name': assignedToName,
    'created_at': createdAt.toIso8601String(),
    'last_contacted_at': lastContactedAt?.toIso8601String(),
    'next_follow_up': nextFollowUp?.toIso8601String(),
    'notes': notes,
    'custom_fields': customFields,
    'estimated_value': estimatedValue,
    'stage': stage,
  };

  Lead copyWith({
    String? id,
    String? customerName,
    String? email,
    String? phoneNumber,
    String? alternatePhone,
    String? company,
    String? status,
    String? priority,
    String? source,
    String? assignedTo,
    String? assignedToName,
    DateTime? createdAt,
    DateTime? lastContactedAt,
    DateTime? nextFollowUp,
    String? notes,
    Map<String, dynamic>? customFields,
    double? estimatedValue,
    String? stage,
  }) {
    return Lead(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      alternatePhone: alternatePhone ?? this.alternatePhone,
      company: company ?? this.company,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      source: source ?? this.source,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedToName: assignedToName ?? this.assignedToName,
      createdAt: createdAt ?? this.createdAt,
      lastContactedAt: lastContactedAt ?? this.lastContactedAt,
      nextFollowUp: nextFollowUp ?? this.nextFollowUp,
      notes: notes ?? this.notes,
      customFields: customFields ?? this.customFields,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      stage: stage ?? this.stage,
    );
  }
}
