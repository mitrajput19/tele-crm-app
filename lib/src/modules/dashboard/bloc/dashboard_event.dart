part of 'dashboard_bloc.dart';


abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {}

class RefreshDashboard extends DashboardEvent {}

class LoadCallRequests extends DashboardEvent {
  final String? status;
  final String? priority;

  const LoadCallRequests({this.status, this.priority});

  @override
  List<Object?> get props => [status, priority];
}

class LoadCallLogs extends DashboardEvent {
  final String? agentId;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadCallLogs({this.agentId, this.startDate, this.endDate});

  @override
  List<Object?> get props => [agentId, startDate, endDate];
}

class LoadLeadsForCalling extends DashboardEvent {
  final String? status;
  final String? assignedTo;

  const LoadLeadsForCalling({this.status, this.assignedTo});

  @override
  List<Object?> get props => [status, assignedTo];
}

class UpdateCallRequestStatus extends DashboardEvent {
  final String requestId;
  final String status;

  const UpdateCallRequestStatus({required this.requestId, required this.status});

  @override
  List<Object?> get props => [requestId, status];
}

class CreateCallLog extends DashboardEvent {
  final CallLog callLog;

  const CreateCallLog({required this.callLog});

  @override
  List<Object?> get props => [callLog];
}

class MakeCall extends DashboardEvent {
  final CallRequest callRequest;

  const MakeCall({required this.callRequest});

  @override
  List<Object?> get props => [callRequest];
}

class EndCall extends DashboardEvent {
  final String callLogId;
  final String outcome;
  final String? notes;
  final DateTime? followUpDate;

  const EndCall({
    required this.callLogId,
    required this.outcome,
    this.notes,
    this.followUpDate,
  });

  @override
  List<Object?> get props => [callLogId, outcome, notes, followUpDate];
}