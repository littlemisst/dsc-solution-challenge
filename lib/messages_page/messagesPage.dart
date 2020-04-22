import 'package:flutter/material.dart';
import 'package:me_daily/messages_page/messageList.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/locationLog/location_log_list.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
      return StreamProvider<List<UserSummary>>.value(
      value: FirestoreService(uid: user.uid).messages,
      child: Container(
        child: MessagesList(),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:me_daily/common-widgets/appBarTextFormat.dart';
// import 'package:me_daily/common-widgets/itemBuilder.dart';
// import 'package:me_daily/messages_page/messageList.dart';
// import 'package:me_daily/messages_page/messagesViewModel.dart';
// import 'package:me_daily/model/user.dart';
// import 'package:me_daily/services/firestore_service.dart';
// import 'package:provider/provider.dart';


// class MessagesPage extends StatelessWidget {
//   static Widget create(BuildContext context) {
//     final _user = Provider.of<User>(context);
//     final database = FirestoreService(uid: _user.uid);
//     return Provider<MessagesViewModel>(
//       create: (_) => MessagesViewModel(database: database),
//       child: MessagesPage(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: TextFormat('Messages'),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top: 10),
//         child: _buildContents(context)),
//     );
//   }

//   Widget _buildContents(BuildContext context) {
//     final vm = Provider.of<MessagesViewModel>(context);
//     return StreamBuilder<List<MessagesListTileModel>>(
//       stream: vm.messagesTileModelStream,
//       builder: (context, snapshot) {
//         return ListItemsBuilder<MessagesListTileModel>(
//           snapshot: snapshot,
//           itemBuilder: (context, model) => MessagesListTile(model: model),
//         );
//       },
//     );
//   }
// }
