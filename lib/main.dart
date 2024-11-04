import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app/features/home/view/home_view.dart';
import 'package:social_media_app/features/post/view/post_view.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/view/auth_register.dart';
import 'features/auth/view/auth_view.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/post/bloc/post_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // fcmTokenCheck(analytics);
  runApp(const MyApp());
}

Future<void> fcmTokenCheck(FirebaseAnalytics analytics) async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint('APNs token: $apnsToken');
  debugPrint('FCM token: $fcmToken');
  if (fcmToken != null) {
    await analytics.logEvent(
      name: 'fcm_token_generated',
      parameters: {'fcm_token': fcmToken},
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthCallEvent()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(HomeScreenApiCallEvent()),
        ),
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
          ),
          routes: {
            '/': (context) => const AuthView(),
            '/register': (context) => const AuthRegister(),
            '/home': (context) => const HomeView(),
            '/post': (context) => PostView(),
          },
          initialRoute: '/',
        );
      }),
    );
  }
}
