import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/constants/constants.dart';

import '../../../widgets/widgets.dart';
import '../bloc/auth_bloc.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth View'),
      ),
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login success'),
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
              return const Text('Login success');
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
                      controller: (state as AuthLoginState).emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else if (!value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    vSizedBox0,
                    passwordField(
                      controller: state.passwordController,
                      obscureText: state.isObsecure,
                      context: context,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthLoginEvent(),
                              );
                        }
                      },
                      child: const Text('Login'),
                    ),
                    const Text('Or '),
                    TextButton.icon(
                        label: const Text('Login with Google'),
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthLoginWithGoogle());
                        },
                        icon: const FaIcon(FontAwesomeIcons.google)),
                    RichText(
                        text: TextSpan(
                      text: "If You Don't have an acoount then ",
                      style: const TextStyle(color: Colors.blue),
                      children: [
                        TextSpan(
                            text: "Create One",
                            style: const TextStyle(color: Colors.grey),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/register');
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
