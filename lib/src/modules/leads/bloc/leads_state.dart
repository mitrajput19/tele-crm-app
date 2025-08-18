
part of 'leads_bloc.dart';

abstract class LeadsState extends Equatable {
  const LeadsState();

  @override
  List<Object?> get props => [];
}

class LeadsInitial extends LeadsState {}

class LeadsLoading extends LeadsState {}

class CreatedLeadSuccess extends LeadsState {
  final Demo lead;

  const CreatedLeadSuccess({required this.lead});

  @override
  List<Object> get props => [lead];
}

class UpdatedLeadSuccess extends LeadsState {
  final Demo lead;

  const UpdatedLeadSuccess({required this.lead});

  @override
  List<Object> get props => [lead];
}

class LeadsLoaded extends LeadsState {
  final List<Demo> leads;
  final List<Demo>? filteredLeads;
  final String? searchQuery;
  final LeadsFilter? currentFilter;

  const LeadsLoaded({
    required this.leads,
    this.filteredLeads,
    this.searchQuery,
    this.currentFilter,
  });

  List<Demo> get displayLeads => filteredLeads ?? leads;

  LeadsLoaded copyWith({
    List<Demo>? leads,
    List<Demo>? filteredLeads,
    String? searchQuery,
    LeadsFilter? currentFilter,
  }) {
    return LeadsLoaded(
      leads: leads ?? this.leads,
      filteredLeads: filteredLeads ?? this.filteredLeads,
      searchQuery: searchQuery ?? this.searchQuery,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }

  @override
  List<Object?> get props => [leads, filteredLeads, searchQuery, currentFilter];
}

class LeadsError extends LeadsState {
  final String message;

  const LeadsError({required this.message});

  @override
  List<Object> get props => [message];
}

class LeadsFilter {
  final String? status;
  final String? assignedTo;
  final String? priority;

  const LeadsFilter({
    this.status,
    this.assignedTo,
    this.priority,
  });
}
