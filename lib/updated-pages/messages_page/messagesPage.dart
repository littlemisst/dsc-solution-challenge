import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/model/summary.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<UserSummary>>(context) ?? [];
    Widget buildListOfmessages(context, document) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, Strings.viewMessage,
            arguments: document),
        child: Hero(
          tag: document.dateSent.toString(),
          child: ListTile(
            leading: document.profile == null
                ? CircleAvatar(
                    radius: 25,
                  )
                : CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(document.profile.downloadUrl, scale: 30),
                  ),
            title: Text(
                document.profile == null ? 'No name' : document.profile.name),
            subtitle: Text(document.sender.email),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          leading: FlatButton(
            child: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.popAndPushNamed(context, Strings.initialRoute),
          ),
          title: Text(
            'Messages',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Colors.white,
        ),
        body: messages.isNotEmpty
            ? Container(
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContentContainer(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: buildListOfmessages(context, messages[index]));
                    }))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    SizedBox(height: 80),
                    Icon(Icons.message, color: Colors.blueGrey[200]),
                    Text('  No Messages Available',
                        style: TextStyle(color: Colors.blueGrey[200]))
                  ]));
  }
}
