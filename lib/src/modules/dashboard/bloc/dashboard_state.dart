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