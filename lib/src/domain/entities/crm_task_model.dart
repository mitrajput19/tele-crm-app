class CrmTask {
  final String id;
  final String? contactId;
  final String? demoRequestId;
  final String? callRecordingId;
  final String title;
  final String? description;
  final String taskType;
  final String priority;
  final String status;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final String assignedTo;
  final String createdBy;
  final DateTime? reminderAt;
  final List<String>? tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  CrmTask({
    required this.id,
    this.contactId,
    this.demoRequestId,
    this.callRecordingId,
    required this.title,
    this.description,
    this.taskType = 'follow_up',
    this.priority = 'medium',
    this.status = 'pending',
    this.dueDate,
    this.completedAt,
    required this.assignedTo,
    required this.createdBy,
    this.reminderAt,
    this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CrmTask.fromJson(Map<String, dynamic> json) => CrmTask(
    id: json['id'],
    contactId: json['contact_id'],
    demoRequestId: json['demo_request_id'],
    callRecordingId: json['call_recording_id'],
    title: json['title'],
    description: json['description'],
    taskType: json['task_type'] ?? 'follow_up',
    priority: json['priority'] ?? 'medium',
    status: json['status'] ?? 'pending',
    dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
    completedAt: json['completed_at'] != null ? DateTime.parse(json['completed_at']) : null,
    assignedTo: json['assigned_to'],
    createdBy: json['created_by'],
    reminderAt: json['reminder_at'] != null ? DateTime.parse(json['reminder_at']) : null,
    tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'contact_id': contactId,
    'demo_request_id': demoRequestId,
    'call_recording_id': callRecordingId,
    'title': title,
    'description': description,
    'task_type': taskType,
    'priority': priority,
    'status': status,
    'due_date': dueDate?.toIso8601String(),
    'completed_at': completedAt?.toIso8601String(),
    'assigned_to': assignedTo,
    'created_by': createdBy,
    'reminder_at': reminderAt?.toIso8601String(),
    'tags': tags,
  };
}