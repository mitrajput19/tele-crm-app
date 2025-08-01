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
    
  }




  List<LoginLogDetails>? loginLogDetails;
  int lastLoaded = 0;

  User? user;

  FutureOr<void> _loginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoginLoadingState(true));

    try{
      final response = await supabaseService.signIn(event.email, event.password);
      if(response != null){
        user = response;
        emit(AuthLoginLoadedState());
      }else{
        // emit(AuthErrorState(message: response.error?.message ?? ''));
      }

    }catch(e){
      log(e.toString());
    }

    emit(AuthLoginLoadingState(false));
  }


  FutureOr<void> _logoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState(true));
    
  }

  }
