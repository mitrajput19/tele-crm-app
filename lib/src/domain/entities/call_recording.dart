class CallRecording {
  final String? id;
  final String? leadId;
  final String? phoneNumber;
  final String? filePath;
  final String? fileName;
  final DateTime? callDate;
  final int? duration;
  final String? callType;
  final String? notes;
  final DateTime? createdAt;

  const CallRecording({
     this.id,
     this.leadId,
     this.phoneNumber,
     this.filePath,
     this.fileName,
     this.callDate,
     this.duration,
     this.callType,
    this.notes,
     this.createdAt,
  });

  factory CallRecording.fromJson(Map<String, dynamic> json) {
    try {
      return CallRecording(
        id: json['id']?.toString(),
        leadId: json['leadId']?.toString() ?? json['lead_id']?.toString() ?? json['demo_id']?.toString(),
        phoneNumber: json['phoneNumber']?.toString() ?? json['phone_number']?.toString(),
        filePath: json['filePath']?.toString() ?? json['file_path']?.toString() ?? json['recording_file_url']?.toString(),
        fileName: json['fileName']?.toString() ?? json['file_name']?.toString(),
        callDate: json['callDate'] != null ? DateTime.parse(json['callDate'].toString()) : 
                  json['call_date'] != null ? DateTime.parse(json['call_date'].toString()) :
                  json['start_time'] != null ? DateTime.parse(json['start_time'].toString()) : DateTime.now(),
        duration: int.tryParse(json['duration']?.toString() ?? json['duration_seconds']?.toString() ?? '0') ?? 0,
        callType: json['callType']?.toString() ?? json['call_type']?.toString() ?? json['call_direction']?.toString() ?? 'outgoing',
        notes: json['notes']?.toString() ?? json['call_notes']?.toString(),
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'].toString()) :
                   json['created_at'] != null ? DateTime.parse(json['created_at'].toString()) : DateTime.now(),
      );
    } catch (e) {
      return CallRecording();
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'lead_id': leadId,
    'demo_id': leadId,
    'phone_number': phoneNumber,
    'recording_file_url': filePath,
    'file_path': filePath,
    'file_name': fileName,
    'start_time': callDate?.toIso8601String(),
    'call_date': callDate?.toIso8601String(),
    'duration_seconds': duration,
    'call_type': callType,
    'call_direction': callType,
    'call_notes': notes,
    'notes': notes,
    'created_at': createdAt?.toIso8601String(),
    'call_status': 'completed',
    'caller_id': null,
    'contact_id': null,
    'demo_request_id': leadId,
    'end_time': callDate != null && duration != null ? 
                callDate!.add(Duration(seconds: duration!)).toIso8601String() : null,
    'recording_file_path': filePath,
    'file_size_bytes': null,
    'audio_format': filePath?.split('.').last ?? 'mp3',
    'transcription_text': null,
    'transcription_status': 'pending',
    'call_outcome': null,
    'call_quality_rating': null,
    'follow_up_required': false,
    'follow_up_date': null,
    'tags': <String>[],
    'metadata': <String, dynamic>{},
    'consent_recorded': false,
    'is_archived': false,
    'updated_at': DateTime.now().toIso8601String(),
  };
}