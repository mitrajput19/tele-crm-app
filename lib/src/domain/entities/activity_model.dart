
class Activity {
  final String id;
  final String profileId;
  final String activityName;
  final String? description;
  final DateTime startTime;
  final DateTime? endTime;
  final String status;
  final double startLatitude;
  final double startLongitude;
  final double? endLatitude;
  final double? endLongitude;
  final int? totalDurationMinutes;
  final String? attendanceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Activity({
    required this.id,
    required this.profileId,
    required this.activityName,
    this.description,
    required this.startTime,
    this.endTime,
    this.status = 'active',
    required this.startLatitude,
    required this.startLongitude,
    this.endLatitude,
    this.endLongitude,
    this.totalDurationMinutes,
    this.attendanceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json['id'],
    profileId: json['profile_id'],
    activityName: json['activity_name'],
    description: json['description'],
    startTime: DateTime.parse(json['start_time']),
    endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
    status: json['status'],
    startLatitude: json['start_latitude'].toDouble(),
    startLongitude: json['start_longitude'].toDouble(),
    endLatitude: json['end_latitude']?.toDouble(),
    endLongitude: json['end_longitude']?.toDouble(),
    totalDurationMinutes: json['total_duration_minutes'],
    attendanceId: json['attendance_id'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'profile_id': profileId,
    'activity_name': activityName,
    'description': description,
    'start_time': startTime.toIso8601String(),
    'end_time': endTime?.toIso8601String(),
    'status': status,
    'start_latitude': startLatitude,
    'start_longitude': startLongitude,
    'end_latitude': endLatitude,
    'end_longitude': endLongitude,
    'total_duration_minutes': totalDurationMinutes,
    'attendance_id': attendanceId,
  };
}

