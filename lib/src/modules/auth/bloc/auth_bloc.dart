import '../../../app/app.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitialState()) {
    on<AuthLoginEvent>(_loginEvent);
    on<AuthLogoutEvent>(_logoutEvent);
    
  }




  List<LoginLogDetails>? loginLogDetails;
  int lastLoaded = 0;



  FutureOr<void> _loginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState(true));

    emit(AuthLoadingState(false));
  }


  FutureOr<void> _logoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState(true));
    
  }

  }
