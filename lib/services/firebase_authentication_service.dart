import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_daily/model/user.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null || !user.isEmailVerified) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await authResult.user.sendEmailVerification();
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user.isEmailVerified) {
        return _userFromFirebase(authResult.user);
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
