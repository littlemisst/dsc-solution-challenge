import 'package:flutter/material.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/pages/homePage.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user == null? HomePage() : HomePage();
    //return HomePage();
  }
}
