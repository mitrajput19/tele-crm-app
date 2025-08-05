import 'package:device_info_plus/device_info_plus.dart';
import 'package:location/location.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../app/app.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc authBloc;
  final PermissionHandlerService _permissionService = PermissionHandlerService();
  Location location = Location();
  LocationData? locationData;
  String appVersion = '';
  String _statusMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    initializeDeviceConfiguration();
  }

  void initializeDeviceConfiguration() async {
    try {
      await _updateStatus('Getting device information...');
      await getDeviceInfo();
      
      await _updateStatus('Getting app version...');
      await getAppVersionDetails();
      
      await _updateStatus('Checking permissions...');
      await _handlePermissions();
      
      await _updateStatus('Loading dashboard...');
      await Future.delayed(const Duration(seconds: 1));
      
      // Navigate based on authentication status
      if (getIt<SupabaseService>().currentUser != null) {
        context.pushReplacement(AppRoutes.dashboard);
      } else {
        context.pushReplacement(AppRoutes.login);
      }
    } catch (e) {
      LogHelper.log('Error in initialization: $e');
      await _updateStatus('Error occurred, continuing...');
      await Future.delayed(const Duration(seconds: 2));
      
      // Still navigate even if there's an error
      if (getIt<SupabaseService>().currentUser != null) {
        context.pushReplacement(AppRoutes.dashboard);
      } else {
        context.pushReplacement(AppRoutes.login);
      }
    }
  }

  Future<void> _updateStatus(String message) async {
    if (mounted) {
      setState(() {
        _statusMessage = message;
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> _handlePermissions() async {
    try {
      // Check if all required permissions are already granted
      final allGranted = await _permissionService.areAllRequiredPermissionsGranted();
      
      if (allGranted) {
        await _updateStatus('All permissions granted!');
        return;
      }

      // Request permissions in background without showing rationale dialog
      await _updateStatus('Requesting permissions...');
      
      final requiredPermissions = [
        AppPermission.callLogs,
        AppPermission.contacts,
        AppPermission.phone,
        AppPermission.systemAlertWindow,
      ];

      final results = await _permissionService.requestPermissions(requiredPermissions);
      
      // Check results
      final grantedCount = results.values.where((status) => 
        status == PermissionStatus.granted).length;
      final totalCount = results.length;
      
      if (grantedCount == totalCount) {
        await _updateStatus('All permissions granted!');
      } else {
        await _updateStatus('Some permissions denied ($grantedCount/$totalCount granted)');
        // Log which permissions were denied for debugging
        results.forEach((permission, status) {
          if (status != PermissionStatus.granted) {
            LogHelper.log('Permission ${permission.name} was denied with status: $status');
          }
        });
      }

      // Continue regardless of permission status
      // The app can handle missing permissions gracefully in specific features
      
    } catch (e) {
      LogHelper.log('Error handling permissions: $e');
      await _updateStatus('Permission check completed');
    }
  }

  Future getAppVersionDetails() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      String build = packageInfo.buildNumber;
      appVersion = 'v $version+$build';
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      LogHelper.log(e);
    }
  }

  Future getDeviceInfo() async {
    try {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      DeviceInfo deviceInfo = DeviceInfo();

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceInfo = DeviceInfo(
          deviceName: androidInfo.brand,
          deviceModel: androidInfo.device,
          deviceVersion: androidInfo.version.release,
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceInfo = DeviceInfo(
          deviceName: iosInfo.name,
          deviceModel: iosInfo.model,
          deviceVersion: iosInfo.systemVersion,
        );
      }

      await getIt<StorageServices>().setDeviceInfo(deviceInfo.toJson());
    } catch (e) {
      LogHelper.log('Error getting device info: $e');
    }
  }

  void blocListener(
    BuildContext context,
    AuthState state,
  ) async {
    // Your existing BLoC listener implementation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppLogo(),
              Gap(16),
              SizedBox(
                width: 80,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(8),
                  backgroundColor: AppColors.lightPrimary.shade100.withOpacity(.25),
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              Gap(16),
              // Status message
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  appVersion,
                  textAlign: TextAlign.center,
                ),
                Gap(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}