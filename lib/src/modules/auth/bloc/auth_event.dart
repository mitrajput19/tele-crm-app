part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}



final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

final class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpEvent(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}


final class AuthResetPasswordEvent extends AuthEvent {
  final String email;

  AuthResetPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}

final class AuthLogoutEvent extends AuthEvent {}
