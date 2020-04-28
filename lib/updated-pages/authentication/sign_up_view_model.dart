import 'package:me_daily/base_view_model.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/services/firestore_service.dart';

class SignUpViewModel extends BaseViewModel {
  FirebaseAuthentication firebaseAuth = FirebaseAuthentication();
  FirestoreService firestoreService = FirestoreService();

  Future signUp(String email, String password) async {
    setIsLoading(true);

    User user = await firebaseAuth.signUpWithEmailAndPassword(email, password);
    await firestoreService.addUser(user);

    setIsLoading(false);
  }

  String validateEmail(String value) => value.isEmpty ? 'field empty' : null;
  String validatePassword(String value) =>
      value.length < 8 ? 'password should be atleast 8 characters' : null;
  String validateConfirmPassword(String value, String password) =>
      password != value ? 'password did not match' : null;
}
