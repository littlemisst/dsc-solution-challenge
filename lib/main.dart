import 'package:flutter/material.dart';
import 'package:me_daily/notifier/authentication_notifier.dart';
import 'package:me_daily/pages/homePage.dart';
import 'package:me_daily/pages/logInPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        )
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.pink[100],
        ),
        home: Consumer<AuthNotifier>(
          builder: (context, notifier, child) {
            return notifier.user != null ? HomePage() : LogIn();
          },
        ));
  }
}
