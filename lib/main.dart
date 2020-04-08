import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/routes/first_installation_wrapper.dart';
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
          primaryColor: Colors.pink[100],
          accentColor: Colors.pink[100],
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: Strings.initialRoute,
      ),
    );
  }
}
