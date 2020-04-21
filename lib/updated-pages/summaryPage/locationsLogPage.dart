import 'package:flutter/material.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/locationLogList.dart';
import 'package:provider/provider.dart';

class LocationLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
      return StreamProvider<List<LocationLog>>.value(
      value: FirestoreService(uid: user.uid).locationLog,
      child: Container(
        child: LocationLogList(),
      ),
    );
  }
}