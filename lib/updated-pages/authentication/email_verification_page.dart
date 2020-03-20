import 'package:flutter/material.dart';
import 'package:me_daily/routes/authentication_wrapper.dart';

class EmailVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 200, 50, 0),
              child: Column(
          children: <Widget>[
            Text('We have sent you a verification'),
            InkWell(
              child: Text('Return to sign in'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthenticationWrapper()));
              },
            )
          ],
        ),
      ),
    );
  }
}
