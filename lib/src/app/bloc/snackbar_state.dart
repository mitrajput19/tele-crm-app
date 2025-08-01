part of 'snackbar_bloc.dart';

@immutable
sealed class SnackbarState extends Equatable {
  const SnackbarState();

  @override
  List<Object?> get props => [];
}

final class SnackbarInitialState extends SnackbarState {
  const SnackbarInitialState();
}

final class ShowSnackbarState extends SnackbarState {
  final String? message;
  final SnackbarType? type;

  const ShowSnackbarState(this.message, this.type);

  @override
  List<Object?> get props => [message, type];
}
