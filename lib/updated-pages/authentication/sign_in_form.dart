import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/loader.dart';
import 'package:me_daily/common-widgets/submitButton.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';

class SignIn extends StatefulWidget {
  final toggleBetweenForms;

  SignIn({this.toggleBetweenForms});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
      User _user =
          await _firebaseAuth.signInWithEmailAndPassword(email, password);

      if (_user == null) {
        setState(() {
          isLoading = false;
        });
      }
    }
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

  Widget _buildPasswordField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
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
            password = value.trim();
          });
        });
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
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 25),
                    _buildEmailField(),
                    SizedBox(height: 15),
                    _buildPasswordField(),
                    SizedBox(height: 15),
                    SubmitButton('Sign in', () => _submit()),
                    SizedBox(height: 15),
                    InkWell(
                      child: Text('Create an Account'),
                      onTap: () {
                        widget.toggleBetweenForms();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Text('Forget Password'),
                      onTap: () {
                        Navigator.pushNamed(
                            context, Strings.resetPasswordFormRoute);
                      },
                    ),
                    SubmitButton('Sign in with Google',
                        () async => await _firebaseAuth.signInWithGoogle()),
                  ],
                ),
              ),
            )),
          );
  }
}
