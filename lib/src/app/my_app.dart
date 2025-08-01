import 'dart:isolate';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart';

import 'app.dart';



GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'Main Navigator');

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Connectivity connectivity;
  late AppBloc appBloc;
  late AuthBloc authBloc;

  ThemeMode themeMode = ThemeMode.light;
  bool isConnected = true;

  bool? isRunning;
  Location location = Location();
  ReceivePort port = ReceivePort();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeConnectivity();
    initializeAppBloc();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void initializeAppBloc() async {
    appBloc = BlocProvider.of<AppBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    appBloc.add(AppThemeUpdateEvent());
    themeMode = appBloc.themeMode;
  }

  void initializeConnectivity() async {
    connectivity = Connectivity();
    updateInternetConnectionState(await connectivity.checkConnectivity());
    connectivity.onConnectivityChanged.listen(updateInternetConnectionState);
  }

  void updateInternetConnectionState(List<ConnectivityResult> resultList) {
    if (resultList.contains(ConnectivityResult.none)) {
      appBloc.add(UpdateAppConnectedStatusEvent(false));
    } else {
      appBloc.add(UpdateAppConnectedStatusEvent(true));
    }
  }

  Future<void> handleAppResumedState() async {
    try {
      
    } catch (e) {
      LogHelper.log('Error handling app resume: $e', tag: 'AppLifecycle');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        LogHelper.log(
          'app in resumed',
          tag: 'didChangeAppLifecycleState',
        );
        handleAppResumedState();
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

  void blocListener(BuildContext context, AppState state) {
    if (state is AppConnectedState) isConnected = state.isConnected;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        themeMode: themeMode,
        theme: AppTheme.themeData(context),
        darkTheme: AppTheme.themeData(context),
        builder: (context, child) {
          return BlocConsumer<SnackbarBloc, SnackbarState>(
            listener: (context, state) {
              if (state is ShowSnackbarState) {
                context.showSnackBar(
                  state.message?.tr(context),
                  type: state.type,
                );
              }
            },
            builder: (context, state) {
              return LoaderOverlay(
                overlayColor: AppColors.dark.withOpacity(.5),
                overlayWidgetBuilder: (_) => CommonLoader(),
                child: Column(
                  children: [
                    Expanded(child: child ?? SizedBox()),
                    AppConnectivityStatus(isConnected: !isConnected),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
