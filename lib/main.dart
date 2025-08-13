


import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app/app.dart';

// TODO: Change this to true when building for production
bool isProd = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.initialize();
  await StorageServices.initializeHive();
  
await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  // Update device info on app start
  try {
    await getIt<DeviceInfoService>().updateUserDeviceInfo();
  } catch (e) {
    // Handle silently
  }

  
  runApp(
    MultiBlocProvider(
      providers: appProviders,
      child: MyApp(),
    ),
  );
}
