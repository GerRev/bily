import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:wellspingapp/auth_provider.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> signInWithGoogleAcc();
  Future<FirebaseUser> createUserWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> currentUser();
  Future<bool> resetPassword(String email);
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _gSignIn = new GoogleSignIn();


  Future<bool> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    print('email sent');
    return true;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user;
  }

//  Future<String> signInWithGoogleAcc() async {
  Future<FirebaseUser> signInWithGoogleAcc() async {
    GoogleSignInAccount googleUser = await _gSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }

  Future<FirebaseUser> createUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}