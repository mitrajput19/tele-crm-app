class Attendance {
  final String id;
  final String profileId;
  final DateTime punchIn;
  final DateTime? punchOut;
  final DateTime date;
  final double? totalHours;
  final String? notes;
  final String? punchInImageUrl;
  final double? punchInLatitude;
  final double? punchInLongitude;
  final String? punchOutImageUrl;
  final double? punchOutLatitude;
  final double? punchOutLongitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attendance({
    required this.id,
    required this.profileId,
    required this.punchIn,
    this.punchOut,
    required this.date,
    this.totalHours,
    this.notes,
    this.punchInImageUrl,
    this.punchInLatitude,
    this.punchInLongitude,
    this.punchOutImageUrl,
    this.punchOutLatitude,
    this.punchOutLongitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json['id'],
    profileId: json['profile_id'],
    punchIn: DateTime.parse(json['punch_in']),
    punchOut: json['punch_out'] != null ? DateTime.parse(json['punch_out']) : null,
    date: DateTime.parse(json['date']),
    totalHours: json['total_hours']?.toDouble(),
    notes: json['notes'],
    punchInImageUrl: json['punch_in_image_url'],
    punchInLatitude: json['punch_in_latitude']?.toDouble(),
    punchInLongitude: json['punch_in_longitude']?.toDouble(),
    punchOutImageUrl: json['punch_out_image_url'],
    punchOutLatitude: json['punch_out_latitude']?.toDouble(),
    punchOutLongitude: json['punch_out_longitude']?.toDouble(),
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'profile_id': profileId,
    'punch_in': punchIn.toIso8601String(),
    'punch_out': punchOut?.toIso8601String(),
    'date': date.toIso8601String().split('T')[0],
    'total_hours': totalHours,
    'notes': notes,
    'punch_in_image_url': punchInImageUrl,
    'punch_in_latitude': punchInLatitude,
    'punch_in_longitude': punchInLongitude,
    'punch_out_image_url': punchOutImageUrl,
    'punch_out_latitude': punchOutLatitude,
    'punch_out_longitude': punchOutLongitude,
  };
}
