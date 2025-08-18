import 'package:call_log/call_log.dart' hide CallLogEntry;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../app/app.dart';
import '../../../domain/entities/call_log_entry.dart' hide CallLogEntry;

part 'call_history_event.dart';
part 'call_history_state.dart';

class CallHistoryBloc extends Bloc<CallHistoryEvent, CallHistoryState> {
  final SupabaseService _supabaseService;
  
  CallHistoryBloc({required SupabaseService supabaseService}) 
      : _supabaseService = supabaseService,
        super(CallHistoryInitial()) {
    on<LoadCallHistory>(_onLoadCallHistory);
    on<SyncCallLogs>(_onSyncCallLogs);
  }

  Future<void> _onSyncCallLogs(
    SyncCallLogs event,
    Emitter<CallHistoryState> emit,
  ) async {
    try {
      final callService = getIt<CallService>();
      final deviceCallLogs = await callService.getDeviceCallLogs();
      final leads = await _supabaseService.getLeadsForCalling();
      
      final callLogs = deviceCallLogs
          .map((log) => CallLogEntry.fromMap({
            'id': log['id'],
            'number': log['number'],
            'timestamp': log['timestamp'],
            'duration': log['duration'],
            'type': log['type'] == CallType.outgoing ? 'outgoing' : log['type'] == CallType.incoming ? 'incoming' : log['type'] == CallType.missed ? 'missed' : log['type'] == CallType.rejected ? 'rejected' : 'unknown',
            'name': log['name'] ?? '',
          }))
          .toList();
      
      await _supabaseService.syncCallLogsToDatabase(callLogs, leads);
    } catch (e) {
      log('Error syncing call logs: $e');
    }
  }

  Future<void> _onLoadCallHistory(
    LoadCallHistory event,
    Emitter<CallHistoryState> emit,
  ) async {
    emit(CallHistoryLoading());
    
    try {
      final callService = getIt<CallService>();
      final deviceCallLogs = await callService.getDeviceCallLogs();
      
      // Get leads to match phone numbers
      final leads = await _supabaseService.getLeadsForCalling();
      
      // Create a set of lead phone numbers for efficient lookup
      final leadPhones = <String>{};
      for (final lead in leads) {
        if (lead.contactNo?.isNotEmpty == true) {
          leadPhones.add(_normalizePhoneNumber(lead.contactNo!));
        }
        if (lead.alternateContactNo?.isNotEmpty == true) {
          leadPhones.add(_normalizePhoneNumber(lead.alternateContactNo!));
        }
      }
      
      final callLogs = deviceCallLogs
          .map((log) => CallLogEntry.fromMap({
            'id': log['id'],
            'number': log['number'],
            'timestamp': log['timestamp'],
            'duration': log['duration'],
            'type': log['type'] == CallType.outgoing ? 'outgoing' : log['type'] == CallType.incoming ? 'incoming' : log['type'] == CallType.missed ? 'missed' : log['type'] == CallType.rejected ? 'rejected' : 'unknown',
            'name': log['name'] ?? '',
          }))
          .where((callLog) {
            if (callLog.number?.isNotEmpty != true) return false;
            final normalizedNumber = _normalizePhoneNumber(callLog.number!);
            return leadPhones.contains(normalizedNumber);
          })
          .toList()
        ..sort((a, b) => (b.timestamp ?? 0).compareTo(a.timestamp ?? 0));
      
      // Sync matched call logs to database
      try {
        await _supabaseService.syncCallLogsToDatabase(callLogs, leads);
      } catch (e) {
        log('Error syncing call logs to database: $e');
      }
      
      emit(CallHistoryLoaded(callLogs));
    } catch (e) {
      log('Error loading call history: $e');
      emit(CallHistoryError(e.toString()));
    }
  }
  
  String _normalizePhoneNumber(String phone) {
    // Remove all non-digit characters and get last 10 digits
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10 ? digits.substring(digits.length - 10) : digits;
  }
}