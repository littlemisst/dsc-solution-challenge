import 'package:flutter/material.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/routes/authentication_wrapper.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: FirebaseAuthentication().user,
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Colors.pink[100],
            ),
            home: AuthenticationWrapper()));
  }
}
