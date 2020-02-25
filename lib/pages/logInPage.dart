import 'package:me_daily/model/user.dart';
import 'package:flutter/material.dart';

enum AuthMode { SignUp, LogIn }

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.LogIn;

  User _user = User();

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    if (_authMode == AuthMode.LogIn) {
    } else {

    }
  }

  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Display Name"),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 26),
      validator: (String value) {
        if (value.isEmpty) {
          return 'is empty';
        }

        if (value.length < 5) {
          return 'should be higher than five characters';
        }
        return null;
      },
      onSaved: (String value) {
        _user.name = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 26),
      validator: (String value) {
        if (value.isEmpty) {
          return 'is empty';
        }

        if (value.length < 5) {
          return 'should be higher than five characters';
        }
        return null;
      },
      onSaved: (String value) {
        _user.email = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
      style: TextStyle(fontSize: 26),
      obscureText: true,
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'required';
        }

        if (value.length < 5) {
          return 'should be higher than five characters';
        }
        return null;
      },
    );
  }

    Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Confirm Password"),
      style: TextStyle(fontSize: 26),
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'does not match';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidate: true,
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
            child: Column(
              children: <Widget>[
                Text(
                  "Please Sign In",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36),
                ),
                SizedBox(
                  height: 32,
                ),
                _authMode == AuthMode.SignUp
                    ? _buildDisplayNameField()
                    : Container(),
                _buildEmailField(),
                _buildPasswordField(),
                _authMode == AuthMode.SignUp
                    ? _buildConfirmPasswordField()
                    : Container(),
                SizedBox(
                  height: 32,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Switch to ${_authMode == AuthMode.LogIn ? 'SignUp' : 'Login'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      _authMode = _authMode == AuthMode.LogIn
                          ? AuthMode.SignUp
                          : AuthMode.LogIn;
                    });
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => _submitForm(),
                    child: Text(
                      _authMode == AuthMode.LogIn ? 'LogIn' : 'SignUp',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
