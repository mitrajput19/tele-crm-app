import '../../app/app.dart';
import '../../modules/leads/bloc/lead_details_bloc.dart';
import '../../modules/leads/leads.dart' hide LeadsScreen;
import '../../modules/modules.dart' hide LeadsScreen;

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
        path: AppRoutes.dashboard,
        pageBuilder: defaultPageBuilder(const TeleCRMDashboard()),
      ),
      GoRoute(
        path: AppRoutes.leads,
        pageBuilder: defaultPageBuilder(const LeadsScreen()),
      ),
      GoRoute(
        path: AppRoutes.addLead,
        pageBuilder: (context, state) {
          final leadId = state.uri.queryParameters['leadId'];
          return MaterialPage(
            key: state.pageKey,
            name: state.name,
            child: AddLeadScreen(leadId: leadId),
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.leadDetails}/:leadId',
        pageBuilder: (context, state) {
          final leadId = state.pathParameters['leadId']!;
          return MaterialPage(
            key: state.pageKey,
            name: state.name,
            child: BlocProvider(
              create: (context) => LeadDetailsBloc(),
              child: LeadDetailsScreen(leadId: leadId),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.callRecording,
        pageBuilder: defaultPageBuilder(const CallRecordingScreen()),
      ),
      GoRoute(
        path: AppRoutes.callHistory,
        pageBuilder: defaultPageBuilder(const CallHistoryScreen()),
      ),
      GoRoute(
        path: AppRoutes.settings,
        pageBuilder: defaultPageBuilder(const SettingsScreen()),
      ),
    ],
  );
}