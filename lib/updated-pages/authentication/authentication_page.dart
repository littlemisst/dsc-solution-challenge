import 'package:flutter/material.dart';
import 'package:me_daily/updated-pages/authentication/sign_in_form.dart';
import 'package:me_daily/updated-pages/authentication/sign_up_form.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool showSignIn = true;
  void toggleBetweenForms() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  showSignIn ? SignIn(toggleBetweenForms: toggleBetweenForms,) : SignUp(toggleBetweenForms: toggleBetweenForms,);
  }
}
