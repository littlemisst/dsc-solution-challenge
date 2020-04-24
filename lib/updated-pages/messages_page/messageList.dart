
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
    List<UserSummary> messages = Provider.of<List<UserSummary>>(context);

    if (messages == null ) {
      messages = [];
    }

    Widget buildListOfmessages(context, document) {
      return  ListTile(
        leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
        title: Text(document.profile.name),
        subtitle: Text(document.sender.email),
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
      body: messages.isNotEmpty ? Container(
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return ContentContainer(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: buildListOfmessages(context, messages[index])
            );
          }
        )
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
        SizedBox(height: 80),
        Icon(Icons.message, color: Colors.blueGrey[200] ),
        Text('  No Messages Available', style: TextStyle(color: Colors.blueGrey[200]))
      ])
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:me_daily/common-widgets/widgetContainer.dart';
// import 'package:me_daily/model/profile.dart';
// import 'package:me_daily/model/user.dart';

// class MessagesListTileModel {
//   const MessagesListTileModel({
//     @required this.profile,
//     @required this.sender,
//     @required this.recepient});
//   final Profile profile;
//   final User sender;
//   final User recepient;
// }

// class MessagesListTile extends StatelessWidget {
//   const MessagesListTile({@required this.model});
//   final MessagesListTileModel model;

//   @override
//   Widget build(BuildContext context) {
//     const fontSize = 15.0;
//     return ContentContainer(
//       padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
//       child: ListTile(
//         title: Column(children: <Widget>[
//           Align(child: Text('${model.profile.name}', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)), alignment: Alignment.centerLeft),
//           Align(child: Text('${model.sender.email}', style: TextStyle(fontSize: fontSize)),alignment: Alignment.centerLeft), 
//           Align(child: Text('${model.recepient.email}', style: TextStyle(fontSize: fontSize)),alignment: Alignment.centerLeft), 
//         ])
//       )
//     );
//   }
// }



