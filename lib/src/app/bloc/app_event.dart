part of 'app_bloc.dart';

@immutable
sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

final class AppInitialEvent extends AppEvent {
  const AppInitialEvent();
}

final class AppReloadEvent extends AppEvent {
  const AppReloadEvent();
}

final class UpdateAppConnectedStatusEvent extends AppEvent {
  final bool isConnected;

  const UpdateAppConnectedStatusEvent(this.isConnected);

  @override
  List<Object?> get props => [isConnected];
}

final class AppThemeUpdateEvent extends AppEvent {
  const AppThemeUpdateEvent();
}

final class AppThemeToggleEvent extends AppEvent {
  final bool isDarkMode;

  const AppThemeToggleEvent(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}

final class AppLockToggleEvent extends AppEvent {
  final bool isAppLock;

  const AppLockToggleEvent(this.isAppLock);

  @override
  List<Object?> get props => [isAppLock];
}

final class AppSelectedLanguageEvent extends AppEvent {
  final TranslationLanguage selectedLanguage;

  const AppSelectedLanguageEvent(this.selectedLanguage);

  @override
  List<Object?> get props => [selectedLanguage];
}
