import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/loader.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/updated-pages/authentication/email_verification_page.dart';

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

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
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
            body: Padding(
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
                      _buildEmailField(),
                      _buildPasswordField(),
                      _buildConfirmPasswordField(),
                      RaisedButton(
                          textColor: Colors.white,
                          color: Colors.pink[100],
                          child: Text('Sign Up'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              //   User user = await _firebaseAuth
                              //       .signUpWithEmailAndPassword(email, password);
                              //   if (user == null) {
                              //     setState(() {
                              //       isLoading = false;
                              //     });
                              //   }
                              // }
                              await _firebaseAuth.signUpWithEmailAndPassword(
                                  email, password);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EmailVerificationPage()));
                            }
                          }),
                      InkWell(
                        child: Text('Already have an account? Sign In'),
                        onTap: () {
                          widget.toggleBetweenForms();
                        },
                      )
                    ],
                  ),
                )),
          );
  }
}
