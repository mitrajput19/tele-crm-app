import 'package:get_it/get_it.dart';
import 'package:tele_crm_app/src/modules/leads/bloc/leads_bloc.dart';

import '../app/app.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> initialize() async {
    getIt.registerLazySingleton<StorageServices>(
      () => StorageServices(),
    );
    getIt.registerLazySingleton<NetworkServices>(
      () => NetworkServices(),
    );
    // getIt.registerLazySingleton<NotificationServices>(
    //   () => NotificationServices(),
    // );
    getIt.registerLazySingleton<SocketServices>(
      () => SocketServices(),
    );

    getIt.registerLazySingleton<AuthApiServices>(
      () => AuthApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<SupabaseService>(
      () => SupabaseService(),
    );
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apis: getIt<AuthApiServices>(), supabaseService: getIt<SupabaseService>()),
    );

    


    getIt.registerLazySingleton<CallService>(
      () => CallService(),
    );

    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(supabaseService: getIt<SupabaseService>()),
    );

    getIt.registerLazySingleton<BugReportApiServices>(
      () => BugReportApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<BugReportRepository>(
      () => BugReportRepositoryImpl(apis: getIt<BugReportApiServices>()),
    );
   

    getIt.registerLazySingleton<ShiftsApiServices>(
      () => ShiftsApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<ShiftsRepository>(
      () => ShiftsRepositoryImpl(apis: getIt<ShiftsApiServices>()),
    );
  

    getIt.registerLazySingleton<LeavesApiServices>(
      () => LeavesApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<LeavesRepository>(
      () => LeavesRepositoryImpl(apis: getIt<LeavesApiServices>()),
    );
  

    getIt.registerLazySingleton<ProfileApiServices>(
      () => ProfileApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(apis: getIt<ProfileApiServices>()),
    );


    getIt.registerLazySingleton<HelpAndSupportApiServices>(
      () => HelpAndSupportApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<HelpAndSupportRepository>(
      () => HelpAndSupportRepositoryImpl(apis: getIt<HelpAndSupportApiServices>()),
    );
 

    getIt.registerLazySingleton<FrontDeskApiServices>(
      () => FrontDeskApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<FrontDeskRepository>(
      () => FrontDeskRepositoryImpl(apis: getIt<FrontDeskApiServices>()),
    );
 

    getIt.registerLazySingleton<ContactsApiServices>(
      () => ContactsApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<ContactsRepository>(
      () => ContactsRepositoryImpl(apis: getIt<ContactsApiServices>()),
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

    

    getIt.registerLazySingleton<TasksApiServices>(
      () => TasksApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<TasksRepository>(
      () => TasksRepositoryImpl(apis: getIt<TasksApiServices>()),
    );
   

    getIt.registerLazySingleton<ExpenseApiServices>(
      () => ExpenseApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<ExpenseRepository>(
      () => ExpenseRepositoryImpl(apis: getIt<ExpenseApiServices>()),
    );
   
    getIt.registerLazySingleton<MakeRequestApiServices>(
      () => MakeRequestApiServices(networkService: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<MakeRequestRepository>(
      () => MakeRequestRepositoryImpl(apiService: getIt<MakeRequestApiServices>()),
    );

    getIt.registerLazySingleton<RestaurantApiServices>(
      () => RestaurantApiServices(services: getIt<NetworkServices>()),
    );
    getIt.registerLazySingleton<RestaurantRepository>(
      () => RestaurantRepositoryImpl(apis: getIt<RestaurantApiServices>()),
    );
    
  }
}
