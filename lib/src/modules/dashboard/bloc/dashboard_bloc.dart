
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app.dart';
import '../../../data/services/supabase_services.dart';
import '../../../domain/entities/call_request.dart';
import '../../../domain/entities/call_log.dart';
import '../../../domain/entities/dashboard_stats.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final SupabaseService _supabaseServices;
  final CallService _callService = CallService();
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
    
    // New direct calling events
    on<MakeDirectCall>(_onMakeDirectCall);
    on<MakeDialerCall>(_onMakeDialerCall);
    on<CallConnected>(_onCallConnected);
    on<CallFailed>(_onCallFailed);
    on<CreateBulkCallRequests>(_onCreateBulkCallRequests);

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

  // New Direct Call Implementation
  Future<void> _onMakeDirectCall(
    MakeDirectCall event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      log('Making direct call to ${event.phoneNumber}');
      // Validate phone number
      if (!_callService.isValidPhoneNumber(event.phoneNumber)) {
        emit(DirectCallFailed(
          leadId: event.leadId,
          phoneNumber: event.phoneNumber,
          customerName: event.customerName,
          error: 'Invalid phone number format',
        ));
        return;
      }


      // Emit calling state
      emit(DirectCallInitiated(
        callId: Uuid().v4(),
        leadId: event.leadId,
        phoneNumber: event.phoneNumber,
        customerName: event.customerName,
        startTime: DateTime.now(),
      ));

      // Create call request if it doesn't exist
      final callRequest = CallRequest(
        id: Uuid().v4(),
        status: 'in_progress',
        leadId: event.leadId,
        customerName: event.customerName,
        phoneNumber: event.phoneNumber,
        priority: event.priority ?? 'medium',
        requestedAt: DateTime.now(),
        source: 'mobile',
        metadata: {
          'lead_id': event.leadId,
          'customer_name': event.customerName,
          'phone_number': event.phoneNumber,
          'call_type': 'direct',
          'initiated_from': 'dashboard',
        },
      );

      // Save call request to database
      await _supabaseServices.createCallRequest(callRequest);

      // Create call log
      final callLog = CallLog(
        id: Uuid().v4(),
        callRequestId: callRequest.id,
        leadId: event.leadId,
        customerName: event.customerName,
        phoneNumber: event.phoneNumber,
        callType: 'outbound',
        status: 'connecting',
        startTime: DateTime.now(),
        agentId: event.agentId ?? 'current_user_id',
        agentName: event.agentName ?? 'Current User',
      );

      final createdCallLog = await _supabaseServices.createCallLog(callLog);

      // Make the actual phone call
      bool callSuccess = await _callService.makeDirectCall(event.phoneNumber);

      if (callSuccess) {
        // Update call log to connected
        await _supabaseServices.updateCallLog(
          callLog.id,
          {
            'status': 'connected',
            'connected_at': DateTime.now().toIso8601String(),
          },
        );

        emit(DirectCallConnected(
          callId: callLog.id,
          callRequest: callRequest,
          callLog: createdCallLog,
          phoneNumber: event.phoneNumber,
          customerName: event.customerName,
          startTime: DateTime.now(),
        ));

        // Auto-transition to CallInProgress after a brief moment
        await Future.delayed(const Duration(seconds: 1));
        emit(CallInProgress(
          callRequest: callRequest,
          callLog: createdCallLog,
          startTime: DateTime.now(),
        ));

      } else {
        // Update call log to failed
        await _supabaseServices.updateCallLog(
          callLog.id,
          {
            'status': 'failed',
            'end_time': DateTime.now().toIso8601String(),
            'outcome': 'failed',
            'notes': 'Failed to initiate direct call',
          },
        );

        emit(DirectCallFailed(
          leadId: event.leadId,
          phoneNumber: event.phoneNumber,
          customerName: event.customerName,
          error: 'Failed to initiate call',
        ));
      }

    } catch (e) {
      log('Error making direct call: $e');
      emit(DirectCallFailed(
        leadId: event.leadId,
        phoneNumber: event.phoneNumber,
        customerName: event.customerName,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onMakeDialerCall(
    MakeDialerCall event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      // Validate phone number
      if (!_callService.isValidPhoneNumber(event.phoneNumber)) {
        emit(DirectCallFailed(
          leadId: event.leadId,
          phoneNumber: event.phoneNumber,
          customerName: event.customerName,
          error: 'Invalid phone number format',
        ));
        return;
      }

      // Make call with system dialer
      bool success = await _callService.makeCallWithDialer(event.phoneNumber);

      if (success) {
        // Create call log for tracking
        final callId = DateTime.now().millisecondsSinceEpoch.toString();
        final callLog = CallLog(
          id: callId,
          callRequestId: event.leadId,
          leadId: event.leadId,
          customerName: event.customerName,
          phoneNumber: event.phoneNumber,
          callType: 'outbound',
          status: 'dialer_opened',
          startTime: DateTime.now(),
          agentId: event.agentId ?? 'current_user_id',
          agentName: event.agentName ?? 'Current User',
          notes: 'Call initiated through system dialer',
        );

        await _supabaseServices.createCallLog(callLog);
        
        emit(DialerCallInitiated(
          leadId: event.leadId,
          phoneNumber: event.phoneNumber,
          customerName: event.customerName,
        ));

        // Auto-refresh dashboard after a delay
        await Future.delayed(const Duration(seconds: 2));
        add(RefreshDashboard());

      } else {
        emit(DirectCallFailed(
          leadId: event.leadId,
          phoneNumber: event.phoneNumber,
          customerName: event.customerName,
          error: 'Failed to open system dialer',
        ));
      }

    } catch (e) {
      emit(DirectCallFailed(
        leadId: event.leadId,
        phoneNumber: event.phoneNumber,
        customerName: event.customerName,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onCallConnected(
    CallConnected event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await _supabaseServices.updateCallLog(
        event.callId,
        {
          'status': 'connected',
          'connected_at': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      // Handle error silently or emit error state if needed
    }
  }

  Future<void> _onCallFailed(
    CallFailed event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await _supabaseServices.updateCallLog(
        event.callId,
        {
          'status': 'failed',
          'end_time': DateTime.now().toIso8601String(),
          'outcome': 'failed',
          'notes': event.error,
        },
      );

      emit(DirectCallFailed(
        leadId: event.callId,
        phoneNumber: '',
        customerName: '',
        error: event.error,
      ));

    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  Future<void> _onCreateBulkCallRequests(
    CreateBulkCallRequests event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(BulkCallProcessing(totalLeads: event.leads.length));

      int successCount = 0;
      int failedCount = 0;
      List<String> errors = [];

      for (final lead in event.leads) {
        try {
          if (lead.contactNo == null || 
              lead.contactNo!.isEmpty ||
              !_callService.isValidPhoneNumber(lead.contactNo!)) {
            failedCount++;
            errors.add('${lead.studentName}: Invalid phone number');
            continue;
          }

          final callRequest = CallRequest(
            id: '${DateTime.now().millisecondsSinceEpoch}_${lead.id}',
            status: 'pending',
            leadId: lead.id,
            customerName: lead.studentName ?? 'Unknown',
            phoneNumber: lead.contactNo!,
            priority: 'medium',
            requestedAt: DateTime.now(),
            source: 'bulk_creation',
            metadata: {
              'lead_id': lead.id,
              'student_name': lead.studentName,
              'contact_no': lead.contactNo,
              'source_of_lead': lead.sourceOfLead,
              'call_type': 'bulk',
              'created_from': 'dashboard_bulk_action',
            },
          );

          await _supabaseServices.createCallRequest(callRequest);
          successCount++;

        } catch (e) {
          failedCount++;
          errors.add('${lead.studentName}: ${e.toString()}');
        }
      }

      emit(BulkCallCompleted(
        totalLeads: event.leads.length,
        successCount: successCount,
        failedCount: failedCount,
        errors: errors,
      ));

      // Refresh dashboard after bulk creation
      await Future.delayed(const Duration(seconds: 1));
      add(RefreshDashboard());

    } catch (e) {
      emit(DashboardError(message: 'Bulk call creation failed: ${e.toString()}'));
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
      } else if (state is DirectCallConnected) {
        startTime = (state as DirectCallConnected).startTime;
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

      // Update call request status to completed
      if (state is CallInProgress) {
        final callInProgress = state as CallInProgress;
        await _supabaseServices.updateCallRequestStatus(
          callInProgress.callRequest.id,
          'completed',
        );
      }

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