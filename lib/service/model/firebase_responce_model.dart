import 'package:firebase_auth/firebase_auth.dart';

class FireAuthResponce {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  bool isLoggedin;
  final String? error;

  FireAuthResponce({
    this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    required this.isLoggedin,
    this.error,
  });

  factory FireAuthResponce.fromFirebase(User user) {
    return FireAuthResponce(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      isLoggedin: user.uid.isEmpty ? false : true,
    );
  }
}
