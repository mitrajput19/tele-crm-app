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
final class AuthResetPasswordSuccessState extends AuthState {
  final String message;

  const AuthResetPasswordSuccessState(this.message);

  @override
  List<Object> get props => [message];
}


final class AuthLoadingState extends AuthState {
  final bool isLoading;

  const AuthLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class AuthLoginLoadingState extends AuthState {
  final bool isLoading;

  const AuthLoginLoadingState(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

final class AuthLoginLoadedState extends AuthState {

}

final class AuthSignUpLoadingState extends AuthState {
  final bool isLoading;

  const AuthSignUpLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class AuthSignUpLoadedState extends AuthState {
}

final class AuthResetPasswordLoadingState extends AuthState {
  final bool isLoading;

  const AuthResetPasswordLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class AuthResetPasswordLoadedState extends AuthState {  }