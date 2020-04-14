import 'package:flutter/material.dart';
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
        title: Text('Profile'),
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
