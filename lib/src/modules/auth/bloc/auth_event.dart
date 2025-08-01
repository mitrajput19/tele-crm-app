part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthLoggedInStatusEvent extends AuthEvent {}

final class AuthLogoutEvent extends AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

final class AuthForgotPasswordEvent extends AuthEvent {
  final Map<String, dynamic> data;

  AuthForgotPasswordEvent(this.data);

  @override
  List<Object?> get props => [data];
}

final class AuthResetPasswordEvent extends AuthEvent {
  final Map<String, dynamic> data;

  AuthResetPasswordEvent(this.data);

  @override
  List<Object?> get props => [data];
}

final class AuthChangePasswordEvent extends AuthEvent {
  final Map<String, dynamic> data;

  AuthChangePasswordEvent(this.data);

  @override
  List<Object?> get props => [data];
}

final class AuthTwoFactorOtpEvent extends AuthEvent {
  final TwoFactorAuthRequest data;

  AuthTwoFactorOtpEvent(this.data);

  @override
  List<Object?> get props => [data];
}

final class SendLocationDataEvent extends AuthEvent {
  final Map<String, dynamic> data;

  SendLocationDataEvent(this.data);

  @override
  List<Object?> get props => [data];
}

final class FetchLoginLogsDataEvent extends AuthEvent {
  final bool isMore;

  FetchLoginLogsDataEvent(this.isMore);

  @override
  List<Object?> get props => [isMore];
}
