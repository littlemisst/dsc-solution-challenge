import 'package:flutter/cupertino.dart';
import 'package:me_daily/model/sleep.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/summaryPage/sleepChart.dart';
import 'package:provider/provider.dart';

class SleepChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Sleep>>.value(
      value: FirestoreService(uid: user.uid).sleep,
      child: SleepChart(),
    );
  }
}
