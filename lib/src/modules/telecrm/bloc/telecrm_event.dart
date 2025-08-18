part of 'telecrm_bloc.dart';

abstract class TeleCrmEvent extends Equatable {
  const TeleCrmEvent();

  @override
  List<Object?> get props => [];
}

class LoadTeleCrmData extends TeleCrmEvent {}

class LoadLeads extends TeleCrmEvent {
  final String? status;
  final String? assignedTo;

  const LoadLeads({this.status, this.assignedTo});

  @override
  List<Object?> get props => [status, assignedTo];
}

class LoadCalls extends TeleCrmEvent {
  final String? status;
  final DateTime? date;

  const LoadCalls({this.status, this.date});

  @override
  List<Object?> get props => [status, date];
}

class SearchLeads extends TeleCrmEvent {
  final String query;

  const SearchLeads({required this.query});

  @override
  List<Object?> get props => [query];
}