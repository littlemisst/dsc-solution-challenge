import 'package:flutter/material.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/constants/strings.dart';

class ResetPasswordPage extends StatelessWidget {
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
                'Check your email for details',
                textAlign: TextAlign.center,
              ),
              InkWell(
                child: Text(
                  'Return to sign in',
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
