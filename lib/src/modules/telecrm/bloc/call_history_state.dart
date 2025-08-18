part of 'call_history_bloc.dart';

abstract class CallHistoryState extends Equatable {
  const CallHistoryState();

  @override
  List<Object> get props => [];
}

class CallHistoryInitial extends CallHistoryState {}

class CallHistoryLoading extends CallHistoryState {}

class CallHistoryLoaded extends CallHistoryState {
  final List<CallLogEntry> callLogs;

  const CallHistoryLoaded(this.callLogs);

  @override
  List<Object> get props => [callLogs];
}

class CallHistoryError extends CallHistoryState {
  final String message;

  const CallHistoryError(this.message);

  @override
  List<Object> get props => [message];
}