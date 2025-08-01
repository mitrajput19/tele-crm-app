class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? alternatePhone;
  final String? companyName;
  final String? jobTitle;
  final String? address;
  final String? city;
  final String? state;
  final String country;
  final String? postalCode;
  final String? source;
  final int leadScore;
  final String status;
  final String? assignedTo;
  final String createdBy;
  final String? notes;
  final DateTime? lastContactDate;
  final DateTime? nextFollowUp;
  final List<String>? tags;
  final Map<String, dynamic> customFields;
  final DateTime createdAt;
  final DateTime updatedAt;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.alternatePhone,
    this.companyName,
    this.jobTitle,
    this.address,
    this.city,
    this.state,
    this.country = 'India',
    this.postalCode,
    this.source,
    this.leadScore = 0,
    this.status = 'new',
    this.assignedTo,
    required this.createdBy,
    this.notes,
    this.lastContactDate,
    this.nextFollowUp,
    this.tags,
    this.customFields = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    phone: json['phone'],
    alternatePhone: json['alternate_phone'],
    companyName: json['company_name'],
    jobTitle: json['job_title'],
    address: json['address'],
    city: json['city'],
    state: json['state'],
    country: json['country'] ?? 'India',
    postalCode: json['postal_code'],
    source: json['source'],
    leadScore: json['lead_score'] ?? 0,
    status: json['status'] ?? 'new',
    assignedTo: json['assigned_to'],
    createdBy: json['created_by'],
    notes: json['notes'],
    lastContactDate: json['last_contact_date'] != null ? DateTime.parse(json['last_contact_date']) : null,
    nextFollowUp: json['next_follow_up'] != null ? DateTime.parse(json['next_follow_up']) : null,
    tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    customFields: json['custom_fields'] ?? {},
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone': phone,
    'alternate_phone': alternatePhone,
    'company_name': companyName,
    'job_title': jobTitle,
    'address': address,
    'city': city,
    'state': state,
    'country': country,
    'postal_code': postalCode,
    'source': source,
    'lead_score': leadScore,
    'status': status,
    'assigned_to': assignedTo,
    'created_by': createdBy,
    'notes': notes,
    'last_contact_date': lastContactDate?.toIso8601String(),
    'next_follow_up': nextFollowUp?.toIso8601String(),
    'tags': tags,
    'custom_fields': customFields,
  };
}

