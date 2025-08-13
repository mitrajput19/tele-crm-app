import '../../../app/app.dart';

class MaintenanceScreen extends StatefulWidget {
  final RemoteConfigAppStatusData? appStatusData;
  MaintenanceScreen({super.key, this.appStatusData});

  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 56),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CommonIcon(
              //   AppIcons.maintenance,
              //   size: 76,
              //   backgroundColor: AppColors.gray.withOpacity(.25),
              //   padding: EdgeInsets.all(24),
              // ),
              // SizedBox(height: 24),
              Text(
                widget.appStatusData?.maintenanceTitle?.tr(context) ?? 'system_under_maintenance'.tr(context),
                style: Theme.of(context).textTheme.tsMedium18,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                widget.appStatusData?.maintenanceDescription?.tr(context) ??
                    'the_system_will_be_online_shortly_thank_you_for_your_patience'.tr(context),
                style: Theme.of(context).textTheme.tsGrayRegular12,
                textAlign: TextAlign.center,
              ),
              // SizedBox(height: 24),
              // CommonOutlinedButton(
              //   width: 156,
              //   label: AppTrKeys.retry.tr(context),
              //   onPressed: () => AppRouter.router.go(AppRoutes.splash),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
