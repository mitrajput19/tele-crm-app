import '../../app/app.dart';
import '../../modules/telecrm/telecrm.dart';

final myRouteObserver = MyRouteObserver();

class MyRouteObserver extends NavigatorObserver {
  static final MyRouteObserver instance = MyRouteObserver._internal();
  MyRouteObserver._internal();

  factory MyRouteObserver() => instance;

  String? previousRoute;

  @override
  void didPush(Route<dynamic> route, Route? previousRoute) {
    this.previousRoute = previousRoute?.settings.name;
    super.didPush(route, previousRoute);
  }
}

class AppRouter {
  static Page<dynamic> buildPageWithDefaultTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return MaterialPage(
      key: state.pageKey,
      name: state.name,
      child: child,
    );
  }

  static Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder(Widget child) {
    return (context, state) {
      return MaterialPage(
        key: state.pageKey,
        name: state.name,
        child: child,
      );
    };
  }

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    observers: [myRouteObserver],
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: defaultPageBuilder(const SplashScreen()),
      ),
     GoRoute(
        path: AppRoutes.login,
        pageBuilder: defaultPageBuilder(const LoginScreen()),
      ),
      GoRoute(
        path: AppRoutes.attendance,
        pageBuilder: defaultPageBuilder(const AttendanceScreen()),
      ),
      GoRoute(
        path: AppRoutes.loginActivity,
        pageBuilder: defaultPageBuilder(const LoginActivityScreen()),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        pageBuilder: defaultPageBuilder(const TeleCRMDashboard()),
      ),

      GoRoute(
        path: AppRoutes.signature,
        pageBuilder: defaultPageBuilder(const SignatureScreen()),
      ),



      GoRoute(
        path: AppRoutes.locationPermission,
        pageBuilder: defaultPageBuilder(const LocationPermissionScreen()),
      ),

      GoRoute(
        path: AppRoutes.maintenance,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: MaintenanceScreen(
              appStatusData: state.extra as RemoteConfigAppStatusData?,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.myActivities,
        pageBuilder: defaultPageBuilder(const MyActivitiesScreen()),
      ),
      GoRoute(
        path: AppRoutes.leaderboard,
        pageBuilder: defaultPageBuilder(const LeaderboardScreen()),
      ),
      GoRoute(
        path: AppRoutes.callRecording,
        pageBuilder: defaultPageBuilder(const CallRecordingScreen()),
      ),

      GoRoute(
        path: AppRoutes.leads,
        pageBuilder: defaultPageBuilder(const LeadsScreen()),
      ),
      GoRoute(
        path: AppRoutes.teleCRM,
        pageBuilder: defaultPageBuilder(const TeleCRMDashboard()),
      ),
      GoRoute(
        path: AppRoutes.addLead,
        pageBuilder: defaultPageBuilder(const AddLeadScreen()),
      ),

    ],
  );
}