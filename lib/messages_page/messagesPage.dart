import 'package:flutter/material.dart';
import 'package:me_daily/messages_page/messageList.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    //   return StreamProvider<List<UserSummary>>.value(
    //   value: FirestoreService(uid: user.uid).messages,
    //   child: Container(
    //     child: MessagesList(),
    //   ),
    // );
    return Container();
  }
}