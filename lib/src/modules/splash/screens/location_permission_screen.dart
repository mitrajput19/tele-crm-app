import 'package:permission_handler/permission_handler.dart' as permission_handler;

import '../../../app/app.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        LogHelper.log(
          'app in resumed',
          tag: 'didChangeAppLifecycleState',
        );
        LocationServices.requestLocationPermission(context, isErrorScreen: true);
        break;
      case AppLifecycleState.inactive:
        LogHelper.log(
          'app in inactive',
          tag: 'didChangeAppLifecycleState',
        );
        break;
      case AppLifecycleState.paused:
        LogHelper.log(
          'app in paused',
          tag: 'didChangeAppLifecycleState',
        );
        break;
      case AppLifecycleState.detached:
        LogHelper.log(
          'app in detached',
          tag: 'didChangeAppLifecycleState',
        );
        break;
      case AppLifecycleState.hidden:
        LogHelper.log(
          'app in hidden',
          tag: 'didChangeAppLifecycleState',
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonIcon(
                padding: EdgeInsets.all(12),
                Icons.location_off_rounded,
                size: 32,
                color: AppColors.warningDark,
                backgroundColor: AppColors.warningLight,
              ),
              SizedBox(height: 36),
              Text(
                AppTrKeys.locationPermissionRequired.tr(context),
                style: Theme.of(context).textTheme.tsMedium16,
              ),
              SizedBox(height: 12),
              Text(
                AppTrKeys.pleaseEnableLocation.tr(context),
                style: Theme.of(context).textTheme.tsGrayRegular14,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  // Expanded(
                  //   child: CommonOutlinedButton(
                  //     label: AppTrKeys.retry.tr(context),
                  //     onPressed: () => context.go(AppRoutes.splash),
                  //   ),
                  // ),
                  // SizedBox(width: 8),
                  Expanded(
                    child: CommonOutlinedButton(
                      label: AppTrKeys.settings.tr(context),
                      onPressed: () => permission_handler.openAppSettings(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
