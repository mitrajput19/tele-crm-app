part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardStats stats;
  final List<CallRequest> callRequests;
  final List<CallLog> callLogs;
  final List<Demo> leads;

  const DashboardLoaded({
    required this.stats,
    required this.callRequests,
    required this.callLogs,
    required this.leads,
  });

  @override
  List<Object?> get props => [stats, callRequests, callLogs, leads];

  DashboardLoaded copyWith({
    DashboardStats? stats,
    List<CallRequest>? callRequests,
    List<CallLog>? callLogs,
    List<Demo>? leads,
  }) {
    return DashboardLoaded(
      stats: stats ?? this.stats,
      callRequests: callRequests ?? this.callRequests,
      callLogs: callLogs ?? this.callLogs,
      leads: leads ?? this.leads,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CallInProgress extends DashboardState {
  final CallRequest callRequest;
  final CallLog callLog;
  final DateTime startTime;

  const CallInProgress({
    required this.callRequest,
    required this.callLog,
    required this.startTime,
  });

  @override
  List<Object?> get props => [callRequest, callLog, startTime];
}

class CallCompleted extends DashboardState {
  final CallLog completedCallLog;

  const CallCompleted({required this.completedCallLog});

  @override
  List<Object?> get props => [completedCallLog];
}

// New Direct Calling States
class DirectCallInitiated extends DashboardState {
  final String callId;
  final String leadId;
  final String phoneNumber;
  final String customerName;
  final DateTime startTime;

  const DirectCallInitiated({
    required this.callId,
    required this.leadId,
    required this.phoneNumber,
    required this.customerName,
    required this.startTime,
  });

  @override
  List<Object?> get props => [callId, leadId, phoneNumber, customerName, startTime];
}

class DirectCallConnected extends DashboardState {
  final String callId;
  final CallRequest callRequest;
  final CallLog callLog;
  final String phoneNumber;
  final String customerName;
  final DateTime startTime;

  const DirectCallConnected({
    required this.callId,
    required this.callRequest,
    required this.callLog,
    required this.phoneNumber,
    required this.customerName,
    required this.startTime,
  });

  @override
  List<Object?> get props => [callId, callRequest, callLog, phoneNumber, customerName, startTime];
}

class DirectCallFailed extends DashboardState {
  final String leadId;
  final String phoneNumber;
  final String customerName;
  final String error;

  const DirectCallFailed({
    required this.leadId,
    required this.phoneNumber,
    required this.customerName,
    required this.error,
  });

  @override
  List<Object?> get props => [leadId, phoneNumber, customerName, error];
}

class DialerCallInitiated extends DashboardState {
  final String leadId;
  final String phoneNumber;
  final String customerName;

  const DialerCallInitiated({
    required this.leadId,
    required this.phoneNumber,
    required this.customerName,
  });

  @override
  List<Object?> get props => [leadId, phoneNumber, customerName];
}

class BulkCallProcessing extends DashboardState {
  final int totalLeads;

  const BulkCallProcessing({required this.totalLeads});

  @override
  List<Object?> get props => [totalLeads];
}

class BulkCallCompleted extends DashboardState {
  final int totalLeads;
  final int successCount;
  final int failedCount;
  final List<String> errors;

  const BulkCallCompleted({
    required this.totalLeads,
    required this.successCount,
    required this.failedCount,
    required this.errors,
  });

  @override
  List<Object?> get props => [totalLeads, successCount, failedCount, errors];
}