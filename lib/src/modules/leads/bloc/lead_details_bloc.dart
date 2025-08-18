import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../app/app.dart';

part 'lead_details_event.dart';
part 'lead_details_state.dart';

class LeadDetailsBloc extends Bloc<LeadDetailsEvent, LeadDetailsState> {
  final SupabaseService _supabaseService = getIt<SupabaseService>();

  LeadDetailsBloc() : super(LeadDetailsInitial()) {
    on<LoadLeadDetails>(_onLoadLeadDetails);
  }

  Future<void> _onLoadLeadDetails(LoadLeadDetails event, Emitter<LeadDetailsState> emit) async {
    emit(LeadDetailsLoading());
    
    try {
      // Load lead details
      final leadResponse = await _supabaseService.client
          .from('demos')
          .select()
          .eq('id', event.leadId)
          .single();
      
      final lead = Demo.fromJson(leadResponse);
      log(  'Loaded lead: ${lead.toJson()}');

      // Load audit logs from activity_logs table
      List<AuditLog> auditLogs = [];
      try {
        final auditResponse = await _supabaseService.client
            .from('audit_logs')
            .select()
            .eq('record_id', event.leadId);
            log('Audit response: $auditResponse');
            
        
        auditLogs = auditResponse.map((json) => AuditLog.fromJson({
          'id': json['id'],
          'tableName': json['table_name'],
          'recordId': json['record_id'],
          'action': json['action_type'],
          'oldValues': json['old_values'],
          'newValues': json['new_values'],
          'userId': json['user_id'],
          'userName': json['user_name'],
          'createdAt': json['created_at'],
          'description': json['additional_data']?['operation'] ?? json['action_type'],
        })).toList();
      } catch (e) {
        log('Error loading audit logs: $e');
        auditLogs = [];
      }

      // Load call recordings from call_recordings table using demo_id
      List<CallRecording> callRecordings = [];
      try {
        final recordingsResponse = await _supabaseService.client
            .from('call_logs')
            .select()
            .eq('lead_id', event.leadId);
            
        
        callRecordings = recordingsResponse.map((json) {
          final recording = CallRecording.fromJson({
            'id': json['id'],
            'leadId': json['lead_id'],
            'customerName': lead.studentName ?? '',
            'phoneNumber': json['phone_number'],
            'filePath': json['recording_url'],
            'fileName': json['file_name'] ?? '',
            'duration': json['duration'],
            'callDate': json['start_time'],
            'callType': json['call_type'] ?? '',
            'notes': json['call_notes'],
            'createdAt': json['created_at'],
            
          });
          log('Call recording file path: ${recording.filePath}');
          return recording;
        }).toList();
      } catch (e) {
        log('Error loading call recordings: $e');
        callRecordings = [];
      }

      emit(LeadDetailsLoaded(
        lead: lead,
        auditLogs: auditLogs,
        callRecordings: callRecordings,
      ));
    } catch (e) {
      emit(LeadDetailsError('Failed to load lead details: ${e.toString()}'));
    }
  }
}