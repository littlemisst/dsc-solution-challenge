import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/summary.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/updated-pages/sendDetails/displayBasicInformationPage.dart';
import 'package:me_daily/updated-pages/sendDetails/recipientSelector.dart';
import 'package:provider/provider.dart';

class ShareDetailsPage extends StatefulWidget {
  @override
  _ShareDetailsPageState createState() => _ShareDetailsPageState();
}

class _ShareDetailsPageState extends State<ShareDetailsPage> {
  FirestoreService _firestoreService = FirestoreService();
  UserSummary userSummary = UserSummary();

  void onChangeRecipient(value) {
    setState(() {
      userSummary.recipient = value;
    });
  }

  void onSend(profile, user) async {
    setState(() {
      userSummary.profile = profile;
      userSummary.sender = user;
    });
    await _firestoreService.sendSummary(userSummary);
    Navigator.popAndPushNamed(context, Strings.initialRoute);
  }

  void onPressed(recipient, profile, user) {
    recipient != null
        ? showDialog(
            context: context,
            builder: (_) => _confirmSendDialog(context, profile, user))
        : showDialog(
            context: context, builder: (_) => _checkRecipientDialog(context));
  }

  Widget _confirmSendDialog(context, profile, user) {
    return AlertDialog(
      title: Text('Continue?'),
      content: Text(
          'You are about to share your information to ${userSummary.recipient.email}'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => onSend(profile, user),
          child: Text('Continue'),
        ),
        FlatButton(
          onPressed: () {},
          child: Text('Cancel'),
        )
      ],
    );
  }

  Widget _checkRecipientDialog(context) {
    return AlertDialog(
        title: Text('Recipient no match'),
        content: Text('Please enter a valid email'));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final profile = Provider.of<Profile>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              RecipientSelector(onChangeRecipient: onChangeRecipient),
              DisplayBasicInformation(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onPressed(userSummary.recipient, profile, user),
        child: Icon(Icons.share, color: Colors.white),
      ),
    );
  }
}
