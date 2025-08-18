class AuditLog {
  final String id;
  final String tableName;
  final String recordId;
  final String action;
  final Map<String, dynamic>? oldValues;
  final Map<String, dynamic>? newValues;
  final String? userId;
  final String? userName;
  final DateTime createdAt;
  final String? description;

  AuditLog({
    required this.id,
    required this.tableName,
    required this.recordId,
    required this.action,
    this.oldValues,
    this.newValues,
    this.userId,
    this.userName,
    required this.createdAt,
    this.description,
  });

  factory AuditLog.fromJson(Map<String, dynamic> json) => AuditLog(
    id: json['id'],
    tableName: json['tableName'] ?? json['table_name'],
    recordId: json['recordId'] ?? json['record_id'],
    action: json['action'] ?? json['action_type'],
    oldValues: json['oldValues'] ?? json['old_values'],
    newValues: json['newValues'] ?? json['new_values'],
    userId: json['userId'] ?? json['user_id'],
    userName: json['userName'] ?? json['user_name'],
    createdAt: DateTime.parse(json['createdAt'] ?? json['created_at']),
    description: json['description'],
  );
}