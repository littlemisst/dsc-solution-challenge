import 'package:flutter/material.dart';
import 'package:me_daily/model/logs.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class DailyLogsPage extends StatefulWidget {
  @override
  _DailyLogsPageState createState() => _DailyLogsPageState();
}

class _DailyLogsPageState extends State<DailyLogsPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      child: StreamBuilder<List<DailyLog>>(
        stream: FirestoreService(uid: user.uid).logs,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
                itemCount: snapshots.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: TextFormField(
                        initialValue: snapshots.data[index].feeling.toString(),
                      ),
                      subtitle:
                          Text(snapshots.data[index].logCreated.toString()),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
