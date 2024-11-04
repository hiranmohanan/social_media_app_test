part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailureState extends AuthState {
  final String errorMessage;

  AuthFailureState({
    required this.errorMessage,
  });
}

class AuthLoginState extends AuthState {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isObsecure;

  AuthLoginState({
    required this.emailController,
    required this.passwordController,
    this.isObsecure = true,
  });
}
