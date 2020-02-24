import 'package:flutter/material.dart';
import 'package:me_daily/pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pink[100],
      ),
      home: HomePage(),
    );
  }
}