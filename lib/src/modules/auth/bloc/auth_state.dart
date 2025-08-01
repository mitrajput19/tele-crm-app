part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthLogoutState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String? message;
  final int? code;

  const AuthErrorState({this.message, this.code = 0});

  @override
  List<Object?> get props => [message, code];
}

final class AuthForgotPasswordSuccessState extends AuthState {
  final String message;

  const AuthForgotPasswordSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthResetPasswordSuccessState extends AuthState {
  final String message;

  const AuthResetPasswordSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthChangePasswordSuccessState extends AuthState {
  final String message;

  const AuthChangePasswordSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthLoadingState extends AuthState {
  final bool isLoading;

  const AuthLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class AuthForgotPasswordLoadingState extends AuthState {
  final bool isLoading;

  const AuthForgotPasswordLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class AuthResetPasswordLoadingState extends AuthState {
  final bool isLoading;

  const AuthResetPasswordLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class AuthChangePasswordLoadingState extends AuthState {
  final bool isLoading;

  const AuthChangePasswordLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class LoginLogsLoadingState extends AuthState {
  final bool isLoading;

  const LoginLogsLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class AuthLoggedInStatusState extends AuthState {
  final bool isLoggedIn;

  const AuthLoggedInStatusState(this.isLoggedIn);

  @override
  List<Object> get props => [isLoggedIn];
}

final class LoginLogsLoadedState extends AuthState {
  final List<LoginLogDetails>? loginLogsDetailsList;

  const LoginLogsLoadedState(this.loginLogsDetailsList);

  @override
  List<Object?> get props => [loginLogsDetailsList];
}

final class LoginLogsLoadingMoreState extends AuthState {
  final bool isLoadingMore;

  const LoginLogsLoadingMoreState(this.isLoadingMore);

  @override
  List<Object> get props => [isLoadingMore];
}
