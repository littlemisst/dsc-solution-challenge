import 'package:flutter/material.dart';
import 'package:me_daily/api/home_page_api.dart';
import 'package:me_daily/notifier/authentication_notifier.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    return Scaffold(
        body: RaisedButton(
      child: Text('Sign Out'),
      onPressed: ()=>signOut(authNotifier),
    ));
  }
}
