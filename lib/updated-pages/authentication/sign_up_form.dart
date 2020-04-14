import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/loader.dart';
import 'package:me_daily/common-widgets/submitButton.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/updated-pages/authentication/verification_page.dart';

class SignUp extends StatefulWidget {
  final toggleBetweenForms;

  SignUp({this.toggleBetweenForms});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuthentication();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  String email;
  String password;

  void _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      User user = await _firebaseAuth
        .signUpWithEmailAndPassword(email, password);
      if (user == null) {
        setState(() {
          isLoading = false;
        });
      }
      Navigator.pushReplacementNamed(
        context, Strings.verificationRoute);
    }
  }
  

  Widget _buildEmailField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty) {
            return 'is empty';
          }
          return null;
        },
        onChanged: (String value) {
          setState(() {
            email = value;
          });
        });
  }

  Widget _buildPasswordField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        controller: _passwordController,
        obscureText: true,
        validator: (String value) {
          if (value.isEmpty) {
            return 'is empty';
          }
          return null;
        },
        onChanged: (String value) {
          setState(() {
            password = value;
          });
        });
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Password did not match';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loader()
        : Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(50, 120, 50, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 25),
                      _buildEmailField(),
                      SizedBox(height: 15),
                      _buildPasswordField(),
                      SizedBox(height: 15),
                      _buildConfirmPasswordField(),
                      SizedBox(height: 15),
                      SubmitButton('Sign Up', () => _submit()),
                      SizedBox(height: 15),
                      InkWell(
                        child: Text('Already have an account? Sign In'),
                        onTap: () {
                          widget.toggleBetweenForms();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
