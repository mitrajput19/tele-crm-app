part of 'app_bloc.dart';

@immutable
sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

final class AppInitialState extends AppState {
  const AppInitialState();
}

final class AppReloadState extends AppState {
  const AppReloadState();
}

final class AppConnectedState extends AppState {
  final bool isConnected;

  const AppConnectedState(this.isConnected);

  @override
  List<Object?> get props => [isConnected];
}

final class AppLoadingState extends AppState {
  final bool isLoading;

  const AppLoadingState(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

final class AppThemeToggleState extends AppState {
  final bool isDarkMode;

  const AppThemeToggleState(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}

final class AppLockToggleState extends AppState {
  final bool isAppLock;

  const AppLockToggleState(this.isAppLock);

  @override
  List<Object?> get props => [isAppLock];
}

final class AppSelectedLanguageState extends AppState {
  final TranslationLanguage selectedLanguage;

  const AppSelectedLanguageState(this.selectedLanguage);

  @override
  List<Object?> get props => [selectedLanguage];
}
