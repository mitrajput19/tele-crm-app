part of 'lead_details_bloc.dart';

abstract class LeadDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeadDetailsInitial extends LeadDetailsState {}

class LeadDetailsLoading extends LeadDetailsState {}

class LeadDetailsLoaded extends LeadDetailsState {
  final Demo lead;
  final List<AuditLog> auditLogs;
  final List<CallRecording> callRecordings;

  LeadDetailsLoaded({
    required this.lead,
    required this.auditLogs,
    required this.callRecordings,
  });

  @override
  List<Object?> get props => [lead, auditLogs, callRecordings];
}

class LeadDetailsError extends LeadDetailsState {
  final String message;
  LeadDetailsError(this.message);
  @override
  List<Object?> get props => [message];
}