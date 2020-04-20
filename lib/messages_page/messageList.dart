import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/model/summary.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/constants/strings.dart';

class MessagesList extends StatefulWidget {
  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {

  @override
  Widget build(BuildContext context) {
    List<UserSummary> userMessages = Provider.of<List<UserSummary>>(context);

    if (userMessages == null ) {
      userMessages = [];
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
      body: userMessages.isNotEmpty ? Container(
        child: ListView.builder(
            itemCount: userMessages.length,
            itemBuilder: (BuildContext context, int index) {
              return ContentContainer(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: _buildMessagesList(context, userMessages[index])
              );
            }
          ),
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
        SizedBox(height: 80),
        Icon(Icons.message, color: Colors.blueGrey[200] ),
        Text(' No Messages Available', style: TextStyle(color: Colors.blueGrey[200]))
      ])
    );
  }
  Widget _buildMessagesList(context, document) {
    return  ListTile(
      leading: Icon(Icons.person, color: Theme.of(context).primaryColor),
      title: Text(document.length.toString()), 
    );
  }
}