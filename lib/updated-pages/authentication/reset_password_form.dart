import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/loader.dart';
import 'package:me_daily/common-widgets/submitButton.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuthentication();

  bool isLoading = false;

  String email;

  void _submit() async {
    setState(() {
      isLoading = true;
    });
    await _firebaseAuth.resetPassword(email);
    Navigator.pushNamed(context, Strings.resetPasswordRoute);
  }

  Widget _buildEmailField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty) {
            return 'is empty';
          }
          return null;
        },
        onChanged: (String value) {
          setState(() {
            email = value.trim();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loader()
        : Scaffold(
            appBar: AppBar(
              leading: FlatButton(
                child: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(50, 120, 50, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Forget Password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 25),
                    _buildEmailField(),
                    SizedBox(height: 15),
                    SubmitButton('Reset Password', () => _submit()),
                  ],
                ),
              ),
            )),
          );
  }
}
