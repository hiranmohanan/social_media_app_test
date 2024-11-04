part of 'firebase_service.dart';

class FireAuthService {
  Future checkUser() async {
    try {
      User? user = await FirebaseAuth.instance.authStateChanges().first;
      if (user == null) {
        return "User not found";
      } else {
        return user;
      }
    } catch (e) {
      return "firebase check user error $e";
    }
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final responce = FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return responce;
    } catch (e) {
      return "firebase login error $e";
    }
  }

  Future signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final responce = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return responce;
    } catch (e) {
      return 'firebse signup error $e';
    }
  }

  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // If the user cancels the sign-in process
        throw Exception('Sign in aborted by user');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // if (userCredential.user == null) {
      //   throw Exception('Sign in failed');
      // }

      return userCredential;
    } catch (e) {
      // Handle the error accordingly
      debugPrint(e.toString());
      return Exception('Error during Google sign-in: ${e.toString()}');
    }
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return FireAuthResponce(isLoggedin: false);
    } catch (e) {
      return FireAuthResponce(isLoggedin: true, error: e.toString());
    }
  }
}
