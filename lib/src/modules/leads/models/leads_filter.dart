
class LeadsFilter {
  final String? status;
  final String? assignedTo;
  final String? priority;
  final String? stage;
  final DateTime? startDate;
  final DateTime? endDate;

  const LeadsFilter({
    this.status,
    this.assignedTo,
    this.priority,
    this.stage,
    this.startDate,
    this.endDate,
  });

  LeadsFilter copyWith({
    String? status,
    String? assignedTo,
    String? priority,
    String? stage,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return LeadsFilter(
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
      priority: priority ?? this.priority,
      stage: stage ?? this.stage,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  String toString() {
    return 'LeadsFilter(status: $status, assignedTo: $assignedTo, priority: $priority, stage: $stage, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeadsFilter &&
        other.status == status &&
        other.assignedTo == assignedTo &&
        other.priority == priority &&
        other.stage == stage &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        assignedTo.hashCode ^
        priority.hashCode ^
        stage.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
