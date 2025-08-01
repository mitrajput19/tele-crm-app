


import 'src/app/app.dart';

// TODO: Change this to true when building for production
bool isProd = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.initialize();
  await StorageServices.initializeHive();


  
  runApp(
    MultiBlocProvider(
      providers: appProviders,
      child: MyApp(),
    ),
  );
}
