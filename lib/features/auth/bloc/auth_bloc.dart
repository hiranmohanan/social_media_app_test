import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/service/firebase_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthCallEvent>(_onInitial);
    on<AuthLoginEvent>(_onLogin);
    on<AuthLoginWithGoogle>(_onLoginWithGoogle);
    on<AuthLogout>(_onLogout);
    on<AuthSignUp>(_authSignup);
  }
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _onInitial(
    AuthCallEvent event,
    Emitter emit,
  ) async {
    final action = await FireAuthService().checkUser();
    if (action is String) {
      emit(AuthFailureState(errorMessage: action.toString()));
      return;
    } else if (action is User) {
      emit(AuthSuccessState());
      return;
    }

    _clearController();
    emit(AuthLoginState(
      emailController: emailController,
      passwordController: passwordController,
      isObsecure: event.isObsecure,
    ));
  }

  Future<void> _onLogin(
    AuthLoginEvent event,
    Emitter emit,
  ) async {
    emit(AuthLoadingState());
    debugPrint(
        'email: ${emailController.text} password: ${passwordController.text}');
    try {
      final responce = await FireAuthService().signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (responce is UserCredential) {
        emit(AuthSuccessState());
      } else if (responce is String) {
        emit(AuthFailureState(errorMessage: responce));
      } else {
        emit(AuthFailureState(errorMessage: 'Something went wrong'));
      }
    } on Exception catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
    _clearController();
  }

  Future<void> _onLoginWithGoogle(
    AuthLoginWithGoogle event,
    Emitter emit,
  ) async {
    _clearController();
    emit(AuthLoadingState());
    final responce = FireAuthService().signInWithGoogle();
    if (responce is UserCredential) {
      emit(AuthSuccessState());
    } else if (responce is String) {
      emit(AuthFailureState(errorMessage: responce.toString()));
    } else {
      emit(AuthFailureState(errorMessage: 'Something went wrong'));
    }
  }

  Future<void> _authSignup(AuthSignUp event, Emitter emit) async {
    emit(AuthLoadingState());
    debugPrint(
        'email: ${emailController.text} password: ${passwordController.text}');
    final responce = await FireAuthService().signUpWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (responce is UserCredential) {
      emit(AuthSuccessState());
    } else if (responce is String) {
      emit(AuthFailureState(errorMessage: responce));
    } else {
      emit(AuthFailureState(errorMessage: 'Something went wrong'));
    }
    _clearController();
  }

  Future<void> _onLogout(
    AuthLogout event,
    Emitter emit,
  ) async {
    await FireAuthService().logout();
    emit(AuthInitialState());
  }

  void _clearController() {
    emailController.clear();
    passwordController.clear();
  }
}
