import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/routes/user_profile_wrapper.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class MainProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popAndPushNamed(context, Strings.initialRoute),
        ),
        title: TextFormat('Profile',Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
      ),
      body: StreamProvider<Profile>.value(
        value: FirestoreService(uid: user.uid).profile,
        child: Container(
          child: UserProfileWrapper(),
        ),
      ),
    );
  }
}
