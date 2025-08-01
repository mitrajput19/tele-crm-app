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
  
];
