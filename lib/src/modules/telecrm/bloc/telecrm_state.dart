part of 'telecrm_bloc.dart';

abstract class TeleCrmState extends Equatable {
  const TeleCrmState();

  @override
  List<Object?> get props => [];
}

class TeleCrmInitial extends TeleCrmState {}

class TeleCrmLoading extends TeleCrmState {}

class TeleCrmLoaded extends TeleCrmState {
  final List<Demo> leads;
  final List<CallLogModel> calls;
  final Map<String, dynamic> stats;

  const TeleCrmLoaded({
    required this.leads,
    required this.calls,
    required this.stats,
  });

  @override
  List<Object?> get props => [leads, calls, stats];
}

class TeleCrmError extends TeleCrmState {
  final String message;

  const TeleCrmError({required this.message});

  @override
  List<Object?> get props => [message];
}