
part of 'leads_bloc.dart';

abstract class LeadsEvent extends Equatable {
  const LeadsEvent();

  @override
  List<Object?> get props => [];
}

class LoadLeadsEvent extends LeadsEvent {}

class CreateLeadEvent extends LeadsEvent {
  final Demo lead;

  const CreateLeadEvent({required this.lead});

  @override
  List<Object> get props => [lead];
}

class UpdateLeadEvent extends LeadsEvent {
  final String leadId;
  final Demo lead;

  const UpdateLeadEvent({
    required this.leadId,
    required this.lead,
  });

  @override
  List<Object> get props => [leadId, lead];
}

class DeleteLeadEvent extends LeadsEvent {
  final String leadId;

  const DeleteLeadEvent({required this.leadId});

  @override
  List<Object> get props => [leadId];
}

class FilterLeadsEvent extends LeadsEvent {
  final String? status;
  final String? assignedTo;
  final String? priority;

  const FilterLeadsEvent({
    this.status,
    this.assignedTo,
    this.priority,
  });

  @override
  List<Object?> get props => [status, assignedTo, priority];
}

class SearchLeadsEvent extends LeadsEvent {
  final String query;

  const SearchLeadsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class CreateCallRequestFromLead extends LeadsEvent {
  final Demo lead;
  final String? priority;

  const CreateCallRequestFromLead({
    required this.lead,
    this.priority,
  });

  @override
  List<Object?> get props => [lead, priority];
}

class UpdateLeadStatus extends LeadsEvent {
  final String leadId;
  final String status;
  final Map<String, dynamic>? additionalData;

  const UpdateLeadStatus({
    required this.leadId,
    required this.status,
    this.additionalData,
  });

  @override
  List<Object?> get props => [leadId, status, additionalData];
}

class AssignLead extends LeadsEvent {
  final String leadId;
  final String agentId;

  const AssignLead({
    required this.leadId,
    required this.agentId,
  });

  @override
  List<Object> get props => [leadId, agentId];
}

class BulkUpdateLeads extends LeadsEvent {
  final List<String> leadIds;
  final Map<String, dynamic> updates;

  const BulkUpdateLeads({
    required this.leadIds,
    required this.updates,
  });

  @override
  List<Object> get props => [leadIds, updates];
}
