import 'package:me_daily/base_view_model.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';

class ResetPasswordViewModel extends BaseViewModel {
  FirebaseAuthentication firebaseAuth = FirebaseAuthentication();

  Future resetPassword(String email) async {
    setIsLoading(true);
    await firebaseAuth.resetPassword(email);
    setIsLoading(false);
  }

    String validateEmail(String value) => value.isEmpty ? 'field empty' : null;
}
