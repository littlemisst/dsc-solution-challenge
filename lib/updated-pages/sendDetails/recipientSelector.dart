import 'package:flutter/material.dart';
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
    return Container(
        child: Center(
      child: TextFormField(
        onChanged: (value) =>
            onChanged(value, _listOfRecipients, widget.onChangeRecipient),
      ),
    ));
  }
}
