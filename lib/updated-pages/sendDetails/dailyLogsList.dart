import 'package:flutter/material.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class DailyLogsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      child: StreamBuilder(
        stream: FirestoreService(uid: user.uid).logs,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshots.data.length,
              itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.check),
                title: Text(snapshots.data[index].feeling.toString()),
                subtitle: Text(snapshots.data[index].logCreated.toString()),
              );
            });
          }
          return Container(
            child: Text(snapshots.data.length.toString()),
          );
        },
      ),
    );
  }
}
