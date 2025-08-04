
part of 'leads_bloc.dart';

abstract class LeadsEvent extends Equatable {
  const LeadsEvent();

  @override
  List<Object?> get props => [];
}

class LoadLeads extends LeadsEvent {}

class CreateLead extends LeadsEvent {
  final Demo lead;

  const CreateLead({required this.lead});

  @override
  List<Object> get props => [lead];
}

class UpdateLead extends LeadsEvent {
  final String leadId;
  final Map<String, dynamic> updates;

  const UpdateLead({
    required this.leadId,
    required this.updates,
  });

  @override
  List<Object> get props => [leadId, updates];
}

class DeleteLead extends LeadsEvent {
  final String leadId;

  const DeleteLead({required this.leadId});

  @override
  List<Object> get props => [leadId];
}

class FilterLeads extends LeadsEvent {
  final String? status;
  final String? assignedTo;
  final String? priority;

  const FilterLeads({
    this.status,
    this.assignedTo,
    this.priority,
  });

  @override
  List<Object?> get props => [status, assignedTo, priority];
}

class SearchLeads extends LeadsEvent {
  final String query;

  const SearchLeads({required this.query});

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
