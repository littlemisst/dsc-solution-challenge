import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';

class RecipientSelector extends StatefulWidget {
  final onChangeRecipient;
  RecipientSelector({this.onChangeRecipient});
  @override
  _RecipientSelectorState createState() => _RecipientSelectorState();
}

void onChanged(value, listOfRecipients, onChangeRecipient) {
  User _recipient =
      listOfRecipients.firstWhere((recipient) => recipient.email == value);
  onChangeRecipient(_recipient);
}

class _RecipientSelectorState extends State<RecipientSelector> {
  @override
  Widget build(BuildContext context) {
    List<User> _listOfRecipients = Provider.of<List<User>>(context) ?? [];
    return ContentContainer(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.send),
                  labelText: 'Share to',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0))),
              onChanged: (value) =>
                  onChanged(value, _listOfRecipients, widget.onChangeRecipient),
            ),
          )),
    );
  }
}
