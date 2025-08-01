import '../app.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitialState()) {
    on<UpdateAppConnectedStatusEvent>(_updateAppConnectedStatusEvent);
    on<AppThemeUpdateEvent>(_themeUpdateEvent);
    on<AppThemeToggleEvent>(_themeToggleEvent);
    on<AppLockToggleEvent>(_appLockToggleEvent);
    on<AppSelectedLanguageEvent>(_updateSelectedLanguageEvent);
  }

  ValueNotifier translationNotifier = ValueNotifier<int>(0);


  List<TranslationLanguage>? translationLanguageList;
  RemoteConfigData? remoteConfigData;

  TranslationLanguage? selectedLanguage = TranslationLanguage(
    translationLanguageId: 1,
  );

  bool isDarkMode = false;
  bool isAppLock = false;
  bool isConnected = false;
  ThemeMode themeMode = ThemeMode.light;

  void notifyTranslationChange() {
    translationNotifier.value++;
  }

  @override
  Future<void> close() {
    translationNotifier.dispose();
    return super.close();
  }

  Future loadInitialAppData() async {
    isDarkMode = await getIt<StorageServices>().getDarkMode();
    isAppLock = await getIt<StorageServices>().getAppLock();
    selectedLanguage = await getIt<StorageServices>().getLanguageDetails();
    remoteConfigData = await getIt<StorageServices>().getRemoteConfigData();
    await getTranslationLanguageList();
    await getAllTranslationsList();
  }

  FutureOr<void> _updateAppConnectedStatusEvent(
    UpdateAppConnectedStatusEvent event,
    Emitter<AppState> emit,
  ) {
    isConnected = event.isConnected;
    emit(AppConnectedState(event.isConnected));
  }

  FutureOr<void> _themeUpdateEvent(
    AppThemeUpdateEvent event,
    Emitter<AppState> emit,
  ) async {
    isDarkMode = await getIt<StorageServices>().getDarkMode();
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    emit(AppThemeToggleState(isDarkMode));
  }

  FutureOr<void> _themeToggleEvent(
    AppThemeToggleEvent event,
    Emitter<AppState> emit,
  ) async {
    isDarkMode = event.isDarkMode;
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    await getIt<StorageServices>().setDarkMode(isDarkMode);
    emit(AppThemeToggleState(isDarkMode));
  }

  FutureOr<void> _appLockToggleEvent(
    AppLockToggleEvent event,
    Emitter<AppState> emit,
  ) async {
    isAppLock = event.isAppLock;
    await getIt<StorageServices>().setAppLock(isAppLock);
    emit(AppLockToggleState(isAppLock));
  }

  FutureOr<void> _updateSelectedLanguageEvent(
    AppSelectedLanguageEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(AppLoadingState(true));
    selectedLanguage = event.selectedLanguage;
    emit(AppSelectedLanguageState(event.selectedLanguage));
    await getIt<StorageServices>().setLanguageDetails(selectedLanguage?.toJson());
    await getAllTranslationsList(langUpdated: true);
    emit(AppLoadingState(false));
  }

  Future getTranslationLanguageList() async {
    try {
      bool isConnected = getIt<NetworkServices>().getNetworkStatus();

      if (isConnected) {
        var data = {'api_key': remoteConfigData?.apiKeyMaster ?? AppUrls.masterApiKey};

        var response = await getIt<NetworkServices>().post(
          path: '${remoteConfigData?.baseUrlMaster ?? AppUrls.baseUrlMaster}${AppUrls.getTranslationLanguageList}',
          data: data,
        );

        if (response != null) {
          translationLanguageList = TranslationLanguage.listFromJson(response);
        }
        LogHelper.log('getTranslationLanguageList : ${translationLanguageList?.length}');
      }
    } catch (e) {
      LogHelper.log('getTranslationLanguageList : Error : $e');
    }
  }

  Future getAllTranslationsList({bool langUpdated = false}) async {
   
  }
}
