import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/routes/routes.dart';
import 'package:me_daily/service_locator.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:provider/provider.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: FirebaseAuthentication().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.cyan,
          accentColor: Colors.cyan,
          scaffoldBackgroundColor: Colors.blueGrey[50],
          buttonColor: Colors.cyan,
          backgroundColor: Colors.white,
          fontFamily: 'Roboto',
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: Strings.initialRoute,
      ),
    );
  }
}
