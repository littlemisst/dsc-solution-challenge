import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_daily/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User _userFromFirebase(FirebaseUser user) {
    if (user != null) {
      return User(uid: user.uid, email: user.email);
    }
    return null;
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(authResult.user);
    } catch (error) {
      return null;
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuth =
          await googleSignInAccount.authentication;
      AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuth.idToken,
          accessToken: googleSignInAuth.accessToken);
      AuthResult authResult =
          await _firebaseAuth.signInWithCredential(authCredential);
      return _userFromFirebase(authResult.user);
    } catch (error) {
      return null;
    }
  }

  Future googleSignOut() async {
    try {
      return await _googleSignIn.signOut();
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

  Future<User> getCurrentUser() async {
    return await _firebaseAuth.currentUser().then(_userFromFirebase);
  }

  Future<String> getProviderId() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    return _user.providerData[1].providerId;
  }
}
