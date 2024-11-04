import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/widgets/widgets.dart';

import '../bloc/auth_bloc.dart';

class AuthRegister extends StatelessWidget {
  const AuthRegister({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signup success'),
                ),
              );
              Navigator.pushNamed(context, '/home');
            } else if (state is AuthFailureState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.errorMessage),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthCallEvent());
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  });
            } else if (state is AuthInitialState) {
              context.read<AuthBloc>().add(AuthCallEvent());
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is AuthSuccessState) {
              return const Text('Signup success');
            } else if (state is AuthFailureState) {
              return Text(state.errorMessage);
            } else if (state is AuthInitialState) {
              return const CircularProgressIndicator();
            }
            return SafeArea(
              minimum: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    commonTextField(
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      controller: (state as AuthLoginState).emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        } else if (value.contains('@') || value.contains('.')) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    vSizedBox0,
                    passwordField(
                      context: context,
                      controller: state.passwordController,
                      labelText: 'Password',
                    ),
                    vSizedBox1,
                    ElevatedButton(
                      onPressed: () {
                        debugPrint(
                            'Register credentials email: ${state.emailController.text} password: ${state.passwordController.text}');
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignUp());
                        }
                      },
                      child: const Text('Register'),
                    ),
                    vSizedBox1,
                    RichText(
                        text: TextSpan(
                      text: "If You Already have an acoount then ",
                      style: const TextStyle(color: Colors.blue),
                      children: [
                        TextSpan(
                            text: "Login",
                            style: const TextStyle(color: Colors.grey),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              })
                      ],
                    ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
