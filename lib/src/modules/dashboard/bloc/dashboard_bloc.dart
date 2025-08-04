
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../app/app.dart';
import '../../../data/services/supabase_services.dart';
import '../../../domain/entities/call_request.dart';
import '../../../domain/entities/call_log.dart';
import '../../../domain/entities/dashboard_stats.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';


// Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final SupabaseService _supabaseServices;
  RealtimeChannel? _callRequestsSubscription;

  DashboardBloc({required SupabaseService supabaseServices})
      : _supabaseServices = supabaseServices,
        super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
    on<LoadCallRequests>(_onLoadCallRequests);
    on<LoadCallLogs>(_onLoadCallLogs);
    on<LoadLeadsForCalling>(_onLoadLeadsForCalling);
    on<UpdateCallRequestStatus>(_onUpdateCallRequestStatus);
    on<CreateCallLog>(_onCreateCallLog);
    on<MakeCall>(_onMakeCall);
    on<EndCall>(_onEndCall);

    _setupRealtimeSubscription();
  }

  void _setupRealtimeSubscription() {
    _callRequestsSubscription = _supabaseServices.subscribeToCallRequests(
      onInsert: (data) {
        add(RefreshDashboard());
      },
      onUpdate: (data) {
        add(RefreshDashboard());
      },
      onDelete: (data) {
        add(RefreshDashboard());
      },
    );
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final stats = await _supabaseServices.getDashboardStats();
      final callRequests = await _supabaseServices.getCallRequests(limit: 20);
      final callLogs = await _supabaseServices.getCallLogs(limit: 20);
      final leads = await _supabaseServices.getLeadsForCalling(limit: 20);

      emit(DashboardLoaded(
        stats: stats,
        callRequests: callRequests,
        callLogs: callLogs,
        leads: leads,
      ));
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      try {
        final stats = await _supabaseServices.getDashboardStats();
        final callRequests = await _supabaseServices.getCallRequests(limit: 20);
        final callLogs = await _supabaseServices.getCallLogs(limit: 20);
        final leads = await _supabaseServices.getLeadsForCalling(limit: 20);

        emit((state as DashboardLoaded).copyWith(
          stats: stats,
          callRequests: callRequests,
          callLogs: callLogs,
          leads: leads,
        ));
      } catch (e) {
        emit(DashboardError(message: e.toString()));
      }
    } else {
      add(LoadDashboard());
    }
  }

  Future<void> _onLoadCallRequests(
    LoadCallRequests event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      try {
        final callRequests = await _supabaseServices.getCallRequests(
          status: event.status,
          priority: event.priority,
          limit: 50,
        );

        emit((state as DashboardLoaded).copyWith(callRequests: callRequests));
      } catch (e) {
        emit(DashboardError(message: e.toString()));
      }
    }
  }

  Future<void> _onLoadCallLogs(
    LoadCallLogs event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      try {
        final callLogs = await _supabaseServices.getCallLogs(
          agentId: event.agentId,
          startDate: event.startDate,
          endDate: event.endDate,
          limit: 50,
        );

        emit((state as DashboardLoaded).copyWith(callLogs: callLogs));
      } catch (e) {
        emit(DashboardError(message: e.toString()));
      }
    }
  }

  Future<void> _onLoadLeadsForCalling(
    LoadLeadsForCalling event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      try {
        final leads = await _supabaseServices.getLeadsForCalling(
          status: event.status,
          assignedTo: event.assignedTo,
          limit: 50,
        );

        emit((state as DashboardLoaded).copyWith(leads: leads));
      } catch (e) {
        emit(DashboardError(message: e.toString()));
      }
    }
  }

  Future<void> _onUpdateCallRequestStatus(
    UpdateCallRequestStatus event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await _supabaseServices.updateCallRequestStatus(
        event.requestId,
        event.status,
      );
      add(RefreshDashboard());
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  Future<void> _onCreateCallLog(
    CreateCallLog event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await _supabaseServices.createCallLog(event.callLog);
      add(RefreshDashboard());
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  Future<void> _onMakeCall(
    MakeCall event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      // Update call request status to in_progress
      await _supabaseServices.updateCallRequestStatus(
        event.callRequest.id,
        'in_progress',
      );

      // Create a new call log
      final callLog = CallLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        callRequestId: event.callRequest.id,
        leadId: event.callRequest.leadId,
        customerName: event.callRequest.customerName,
        phoneNumber: event.callRequest.phoneNumber,
        callType: 'outbound',
        status: 'connecting',
        startTime: DateTime.now(),
        agentId: 'current_user_id',
        agentName: 'Current User',
      );

      final createdCallLog = await _supabaseServices.createCallLog(callLog);

      emit(CallInProgress(
        callRequest: event.callRequest,
        callLog: createdCallLog,
        startTime: DateTime.now(),
      ));
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  Future<void> _onEndCall(
    EndCall event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final endTime = DateTime.now();
      DateTime? startTime;
      
      if (state is CallInProgress) {
        startTime = (state as CallInProgress).startTime;
      }

      final duration = startTime != null 
          ? endTime.difference(startTime).inSeconds 
          : null;

      final updatedCallLog = await _supabaseServices.updateCallLog(
        event.callLogId,
        {
          'end_time': endTime.toIso8601String(),
          'duration': duration,
          'outcome': event.outcome,
          'notes': event.notes,
          'follow_up_date': event.followUpDate?.toIso8601String(),
          'status': 'completed',
        },
      );

      emit(CallCompleted(completedCallLog: updatedCallLog));
      
      // Refresh dashboard after a short delay
      await Future.delayed(const Duration(seconds: 2));
      add(RefreshDashboard());
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _callRequestsSubscription?.unsubscribe();
    return super.close();
  }
}
