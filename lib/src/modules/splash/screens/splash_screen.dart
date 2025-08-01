import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:location/location.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../main.dart';
import '../../../app/app.dart';
import '../../../core/helper/common_web_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc authBloc;
  Location location = Location();
  LocationData? locationData;
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    initializeDeviceConfiguration();
    // Enables Background Location Tracking
    // LocationTrackingManager.startLocationTracking();
  }

  void initializeDeviceConfiguration() async {
    await getDeviceInfo();
    await getAppVersionDetails();
    await Future.delayed(const Duration(seconds: 3), () {
      context.pushReplacement(AppRoutes.login);
    });
    
  }



  
 
  Future getAppVersionDetails() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      String build = packageInfo.buildNumber;
      appVersion = 'v $version+$build';
      setState(() {});
    } catch (e) {
      LogHelper.log(e);
    }
  }

  Future getDeviceInfo() async {
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
  }

  void blocListener(
    BuildContext context,
    AuthState state,
  ) async {

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
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(appVersion, textAlign: TextAlign.center,),
              Gap(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
