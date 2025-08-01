part of 'snackbar_bloc.dart';

@immutable
sealed class SnackbarEvent extends Equatable {
  const SnackbarEvent();

  @override
  List<Object?> get props => [];
}

final class ShowSnackbarEvent extends SnackbarEvent {
  final String? message;
  final SnackbarType? type;

  const ShowSnackbarEvent(this.message, [this.type]);

  @override
  List<Object?> get props => [message, type];
}
