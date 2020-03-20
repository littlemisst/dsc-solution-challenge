import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/loader.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/updated-pages/authentication/reset_password_page.dart';
import 'package:me_daily/updated-pages/authentication/verification_page.dart';

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

  Widget _buildEmailField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
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
        decoration: InputDecoration(labelText: 'Password'),
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loader()
        : Scaffold(
            body: Padding(
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
                      _buildEmailField(),
                      _buildPasswordField(),
                      RaisedButton(
                          textColor: Colors.white,
                          color: Colors.pink[100],
                          child: Text('Sign In'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              User _user = await _firebaseAuth
                                  .signInWithEmailAndPassword(email, password);

                              if (_user == null) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          }),
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
                        onTap: () async {
                          await _firebaseAuth.resetPassword(email);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPasswordPage()));
                        },
                      )
                    ],
                  ),
                )),
          );
  }
}
