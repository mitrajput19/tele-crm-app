import 'package:get_it/get_it.dart';
import 'package:tele_crm_app/src/modules/leads/bloc/leads_bloc.dart';

import '../app/app.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> initialize() async {
    getIt.registerLazySingleton<StorageServices>(
      () => StorageServices(),
    );
    getIt.registerLazySingleton<SupabaseService>(
      () => SupabaseService(),
    );

    


    getIt.registerLazySingleton<CallService>(
      () => CallService(),
    );

    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(supabaseService: getIt<SupabaseService>()),
    );

    getIt.registerLazySingleton<SnackbarBloc>(
      () => SnackbarBloc(),
    );

    getIt.registerLazySingleton<AppBloc>(
      () => AppBloc(),
    );

    getIt.registerLazySingleton<LeadsBloc>(
      () => LeadsBloc(supabaseService: getIt<SupabaseService>()),
    );

    getIt.registerLazySingleton<DeviceInfoService>(
      () => DeviceInfoService(),
    );
    
  }
}
