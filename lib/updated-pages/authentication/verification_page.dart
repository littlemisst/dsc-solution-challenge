import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_daily/main.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/routes/authentication_wrapper.dart';
import 'package:me_daily/updated-pages/authentication/sign_in_form.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Waiting for your email to be verified',
                textAlign: TextAlign.center,
              ),
              InkWell(
                child: Text(
                  'Return to sign in',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignIn()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
