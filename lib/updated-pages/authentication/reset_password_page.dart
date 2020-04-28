import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Strings.checkEmail,
                textAlign: TextAlign.center,
              ),
              InkWell(
                child: Text(
                  Strings.returnToSignIn,
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Strings.signInRoute);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
