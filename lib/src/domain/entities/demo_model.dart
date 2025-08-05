class Demo {
  final String id;
  final String studentName;
  final String? board;
  final String standard;
  final String? contactNo;
  final String? alternateContactNo;
  final DateTime demoDate;
  final String? assignedTo;
  final String status;
  final String? notes;
  final String? createdBy;
  final String? schoolName;
  final String? city;
  final String? address;
  final String? sourceOfLead;
  final String? demoPerformedBy;
  final double? quoteAmount;
  final DateTime? postponeDate;
  final String? postponeNote;
  final DateTime? followUpDate;
  final String? followUpNote;
  final String? notInterestedReason;
  final double? finalizedAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Demo({
    required this.id,
    required this.studentName,
    this.board,
    required this.standard,
    this.contactNo,
    this.alternateContactNo,
    required this.demoDate,
    this.assignedTo,
    required this.status,
    this.notes,
    this.createdBy,
    this.schoolName,
    this.city,
    this.address,
    this.sourceOfLead,
    this.demoPerformedBy,
    this.quoteAmount,
    this.postponeDate,
    this.postponeNote,
    this.followUpDate,
    this.followUpNote,
    this.notInterestedReason,
    this.finalizedAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Demo.fromJson(Map<String, dynamic> json) => Demo(
    id: json['id'],
    studentName: json['student_name'],
    board: json['board'],
    standard: json['standard'],
    contactNo: json['contact_no'],
    alternateContactNo: json['alternate_contact_no'],
    demoDate: DateTime.parse(json['demo_date']),
    assignedTo: json['assigned_to'],
    status: json['status'],
    notes: json['notes'],
    createdBy: json['created_by'],
    schoolName: json['school_name'],
    city: json['city'],
    address: json['address'],
    sourceOfLead: json['source_of_lead'],
    demoPerformedBy: json['demo_performed_by'],
    quoteAmount: json['quote_amount']?.toDouble(),
    postponeDate: json['postpone_date'] != null ? DateTime.parse(json['postpone_date']) : null,
    postponeNote: json['postpone_note'],
    followUpDate: json['follow_up_date'] != null ? DateTime.parse(json['follow_up_date']) : null,
    followUpNote: json['follow_up_note'],
    notInterestedReason: json['not_interested_reason'],
    finalizedAmount: json['finalized_amount']?.toDouble(),
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'student_name': studentName,
    'board': board,
    'standard': standard,
    'contact_no': contactNo,
    'alternate_contact_no': alternateContactNo,
    'demo_date': demoDate.toIso8601String(),
    'assigned_to': assignedTo,
    'status': status,
    'notes': notes,
    'created_by': createdBy,
    'school_name': schoolName,
    'city': city,
    'address': address,
    'source_of_lead': sourceOfLead,
    'demo_performed_by': demoPerformedBy,
    'quote_amount': quoteAmount,
    'postpone_date': postponeDate?.toIso8601String(),
    'postpone_note': postponeNote,
    'follow_up_date': followUpDate?.toIso8601String(),
    'follow_up_note': followUpNote,
    'not_interested_reason': notInterestedReason,
    'finalized_amount': finalizedAmount,
  };

  Demo copyWith({
    String? studentName,
    String? standard,
    DateTime? demoDate,
    String? status, 
    String? notes,
    String? createdBy,
    String? schoolName,
    String? city,
    String? address,
    String? sourceOfLead,
    String? demoPerformedBy,
    double? quoteAmount,
    DateTime? postponeDate,
    String? postponeNote,
    DateTime? followUpDate,
    String? followUpNote,
    String? notInterestedReason,
    double? finalizedAmount,
  }) => Demo(
    id: id,
    studentName: studentName ?? this.studentName,
    standard: standard ?? this.standard,
    demoDate: demoDate ?? this.demoDate,
    status: status ?? this.status,
    notes: notes ?? this.notes,
    createdBy: createdBy ?? this.createdBy,
    schoolName: schoolName ?? this.schoolName,
    city: city ?? this.city,
    address: address ?? this.address,
    sourceOfLead: sourceOfLead ?? this.sourceOfLead,
    demoPerformedBy: demoPerformedBy ?? this.demoPerformedBy,
    quoteAmount: quoteAmount ?? this.quoteAmount,
    postponeDate: postponeDate ?? this.postponeDate,
    postponeNote: postponeNote ?? this.postponeNote,
    followUpDate: followUpDate ?? this.followUpDate,
    followUpNote: followUpNote ?? this.followUpNote,
    notInterestedReason: notInterestedReason ?? this.notInterestedReason,
    finalizedAmount: finalizedAmount ?? this.finalizedAmount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}

