import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/routes/user_profile_wrapper.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class MainProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Profile>.value(
      value: FirestoreService().profile,
     child: Container(
       child: UserProfileWrapper(),
     ),
    );   
  }
}