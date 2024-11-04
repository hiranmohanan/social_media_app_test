part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class AuthCallEvent extends AuthEvent {
  final bool isObsecure;

  AuthCallEvent({
    this.isObsecure = true,
  });
}

class AuthLoginEvent extends AuthEvent {}

class AuthLoginWithGoogle extends AuthEvent {}

class AuthLogout extends AuthEvent {}

class AuthSignUp extends AuthEvent {}
