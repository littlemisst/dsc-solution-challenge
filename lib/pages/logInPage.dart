import 'package:me_daily/model/user.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/notifier/authentication_notifier.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/api/home_page_api.dart';
import 'package:me_daily/updated-pages/authentication/authentication_widgets.dart';

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

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.LogIn) {
      login(_user, authNotifier);
    } else {
      signup(_user, authNotifier);
    }
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
                buildEmailField(context, _user),
                buildPasswordField(context, _user, _passwordController),
                _authMode == AuthMode.SignUp
                    ? buildConfirmPasswordField(context, _passwordController)
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
