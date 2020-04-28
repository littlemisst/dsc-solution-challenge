import 'package:me_daily/base_view_model.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/services/firestore_service.dart';

class SignInViewModel extends BaseViewModel {
  FirebaseAuthentication firebaseAuth = FirebaseAuthentication();
  FirestoreService firestoreService = FirestoreService();

  Future signInWithEmailAndPassword(String email, String password) async {
    setIsLoading(true);
    await firebaseAuth.signInWithEmailAndPassword(email, password);
    setIsLoading(false);
  }

  Future signInWithGoogle() async {
    setIsLoading(true);
    User user = await firebaseAuth.signInWithGoogle();
    await firestoreService.addUser(user);
    setIsLoading(false);
  }

  String validateEmail(String value) => value.isEmpty ? 'field empty' : null;
  String validatePassword(String value) => value.isEmpty ? 'field empty' : null;
}
