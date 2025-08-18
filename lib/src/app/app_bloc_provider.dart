import 'package:tele_crm_app/src/modules/leads/bloc/leads_bloc.dart';

import 'app.dart';

final List<BlocProvider> appProviders = [
  BlocProvider<AppBloc>(
    create: (context) => getIt<AppBloc>(),
  ),
  BlocProvider<AuthBloc>(
    create: (context) => getIt<AuthBloc>(),
  ),
  BlocProvider<SnackbarBloc>(
    create: (context) => getIt<SnackbarBloc>(),
  ),

   BlocProvider<LeadsBloc>(
    create: (context) => getIt<LeadsBloc>(),
  ),

  BlocProvider<CallHistoryBloc>(
    create: (context) => getIt<CallHistoryBloc>(),
  ),

  
];
