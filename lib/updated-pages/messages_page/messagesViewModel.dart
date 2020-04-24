// import 'package:flutter/material.dart';
// import 'package:me_daily/messages_page/messageList.dart';
// import 'package:me_daily/model/summary.dart';
// import 'package:me_daily/services/firestore_service.dart';

// class MessagesViewModel {
//   MessagesViewModel({@required this.database});
//   final FirestoreService database;

//   Stream<List<UserSummary>> get _allMessages => database.messages;

//   Stream<List<MessagesListTileModel>> get messagesTileModelStream => _allMessages.map(_createModels);

//   static List<MessagesListTileModel> _createModels(List<UserSummary> messages) {
//     if (messages.isEmpty) {
//       return [];
//     }
//     return  <MessagesListTileModel>[
//       for (UserSummary msg in messages) ...[
//        MessagesListTileModel(profile: msg.profile, sender: msg.sender, recepient: msg.recipient)
//       ]
//     ];
//   }
// }