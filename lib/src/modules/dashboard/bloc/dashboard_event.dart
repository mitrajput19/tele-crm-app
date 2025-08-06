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

// New Direct Calling Events
class MakeDirectCall extends DashboardEvent {
  final String leadId;
  final String phoneNumber;
  final String customerName;
  final String? priority;
  final String? agentId;
  final String? agentName;

  const MakeDirectCall({
    required this.leadId,
    required this.phoneNumber,
    required this.customerName,
    this.priority,
    this.agentId,
    this.agentName,
  });

  @override
  List<Object?> get props => [leadId, phoneNumber, customerName, priority, agentId, agentName];
}

class MakeDialerCall extends DashboardEvent {
  final String leadId;
  final String phoneNumber;
  final String customerName;
  final String? agentId;
  final String? agentName;

  const MakeDialerCall({
    required this.leadId,
    required this.phoneNumber,
    required this.customerName,
    this.agentId,
    this.agentName,
  });

  @override
  List<Object?> get props => [leadId, phoneNumber, customerName, agentId, agentName];
}

class CallConnected extends DashboardEvent {
  final String callId;

  const CallConnected({required this.callId});

  @override
  List<Object?> get props => [callId];
}

class CallFailed extends DashboardEvent {
  final String callId;
  final String error;

  const CallFailed({required this.callId, required this.error});

  @override
  List<Object?> get props => [callId, error];
}

class CreateBulkCallRequests extends DashboardEvent {
  final List<Demo> leads;

  const CreateBulkCallRequests({required this.leads});

  @override
  List<Object?> get props => [leads];
}