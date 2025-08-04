
class CallLog {
  final String id;
  final String callRequestId;
  final String? leadId;
  final String customerName;
  final String phoneNumber;
  final String callType; // 'outbound', 'inbound'
  final String status; // 'connected', 'no_answer', 'busy', 'failed'
  final DateTime startTime;
  final DateTime? endTime;
  final int? duration; // in seconds
  final String? recordingUrl;
  final String? notes;
  final String? outcome; // 'interested', 'not_interested', 'callback', 'converted'
  final String? nextAction;
  final DateTime? followUpDate;
  final String agentId;
  final String agentName;
  final Map<String, dynamic>? metadata;

  CallLog({
    required this.id,
    required this.callRequestId,
    this.leadId,
    required this.customerName,
    required this.phoneNumber,
    required this.callType,
    required this.status,
    required this.startTime,
    this.endTime,
    this.duration,
    this.recordingUrl,
    this.notes,
    this.outcome,
    this.nextAction,
    this.followUpDate,
    required this.agentId,
    required this.agentName,
    this.metadata,
  });

  factory CallLog.fromJson(Map<String, dynamic> json) => CallLog(
    id: json['id'],
    callRequestId: json['call_request_id'],
    leadId: json['lead_id'],
    customerName: json['customer_name'],
    phoneNumber: json['phone_number'],
    callType: json['call_type'],
    status: json['status'],
    startTime: DateTime.parse(json['start_time']),
    endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
    duration: json['duration'],
    recordingUrl: json['recording_url'],
    notes: json['notes'],
    outcome: json['outcome'],
    nextAction: json['next_action'],
    followUpDate: json['follow_up_date'] != null ? DateTime.parse(json['follow_up_date']) : null,
    agentId: json['agent_id'],
    agentName: json['agent_name'],
    metadata: json['metadata'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'call_request_id': callRequestId,
    'lead_id': leadId,
    'customer_name': customerName,
    'phone_number': phoneNumber,
    'call_type': callType,
    'status': status,
    'start_time': startTime.toIso8601String(),
    'end_time': endTime?.toIso8601String(),
    'duration': duration,
    'recording_url': recordingUrl,
    'notes': notes,
    'outcome': outcome,
    'next_action': nextAction,
    'follow_up_date': followUpDate?.toIso8601String(),
    'agent_id': agentId,
    'agent_name': agentName,
    'metadata': metadata,
  };
}
