import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tele_crm_app/src/data/services/supabase_services.dart';

import '../../../app/app.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseService supabaseService;

  AuthBloc({required this.supabaseService}) : super(AuthInitialState()) {
    on<AuthLoginEvent>(_loginEvent);
    on<AuthLogoutEvent>(_logoutEvent);
    on<AuthSignUpEvent>(_signUpEvent);
    on<AuthResetPasswordEvent>(_resetPasswordEvent);
  }

  List<LoginLogDetails>? loginLogDetails;
  int lastLoaded = 0;
  User? user;

  FutureOr<void> _loginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoginLoadingState(true));

    try {
      final response = await supabaseService.signIn(event.email, event.password);
      if (response != null) {
        user = response;
        emit(AuthLoginLoadedState());
      } else {
        emit(AuthErrorState(message: 'Login failed. Please check your credentials.'));
      }
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState(message: e.toString()));
    }

    emit(AuthLoginLoadingState(false));
  }

  FutureOr<void> _logoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState(true));
    
    try {
      await supabaseService.signOut();
      user = null;
      emit(AuthLogoutState());
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState(message: 'Logout failed: ${e.toString()}'));
    }
    
    emit(AuthLoadingState(false));
  }

  FutureOr<void> _signUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSignUpLoadingState(true));

    try {
      final response = await supabaseService.signUp(
        event.email, 
        event.password,
        data: {'name': event.name}
      );
      
      if (response != null) {
        emit(AuthSignUpLoadedState());
      } else {
        emit(AuthErrorState(message: 'Sign up failed. Please try again.'));
      }
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState(message: e.toString()));
    }

    emit(AuthSignUpLoadingState(false));
  }

  FutureOr<void> _resetPasswordEvent(
    AuthResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthResetPasswordLoadingState(true));

    try {
      await supabaseService.resetPassword(event.email);
      emit(AuthResetPasswordSuccessState('Password reset email sent successfully'));
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState(message: e.toString()));
    }

    emit(AuthResetPasswordLoadingState(false));
  }
}
