import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/api/profile_page_api.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/pages/update_profile.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class UserProfileSummary extends StatefulWidget {
  @override
  _UserProfileSummaryState createState() => _UserProfileSummaryState();
}

class _UserProfileSummaryState extends State<UserProfileSummary> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Profile>(
        stream: FirestoreService(uid: user.uid).profile,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            Profile _currentProfile = snapshots.data;

            return Column(children: <Widget>[
              Text(_currentProfile.name),
              Text(_currentProfile.address),
              Text(_currentProfile.gender),
              Text(_currentProfile.civilStatus),
              Text(_currentProfile.bloodType),
              Text(_currentProfile.height),
              Text(_currentProfile.weight),
            ]);
          }
          return Container();
        });
  }
}
