import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'UserDataService.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  bool _newUserFlag = false;

  AuthenticationService(this._firebaseAuth);

  //for authentication changes
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  //Sign out functionality
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signInWithGoogle() async {
    try {
      User? user;
      // Trigger the authentication flow
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        user = userCredential.user;

        UserDataService(userId: user!.uid).checkUserExisted(user.uid).then((value) {
          if (value == false) {
            UserDataService(userId: user!.uid).addUser(
              userId: user.uid,
              userName: user.displayName!,
              userEmail: user.email!,
            );
            _newUserFlag = true;
          } else {
            return "Signed in using google";
          }
        });
      }
      if (user != null) {
        return "Signed up using google";
      }
      return "Please sign in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  String? userIdGetter() {
    return _firebaseAuth.currentUser?.uid;
  }

  String? userEmailGetter() {
    return _firebaseAuth.currentUser?.email;
  }

  bool newUserStatusGetter() {
    return _newUserFlag;
  }

  void userWelcomed() {
    _newUserFlag = false;
  }
}
