import '../app.dart';

part 'snackbar_event.dart';
part 'snackbar_state.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  SnackbarBloc() : super(SnackbarInitialState()) {
    on<ShowSnackbarEvent>(_showSnackbarEvent);
  }

  FutureOr<void> _showSnackbarEvent(
    ShowSnackbarEvent event,
    Emitter<SnackbarState> emit,
  ) {
    emit(ShowSnackbarState(event.message, event.type));
  }
}
