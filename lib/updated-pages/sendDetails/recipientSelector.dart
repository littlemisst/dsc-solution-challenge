import 'package:flutter/material.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';

class RecipientSelector extends StatefulWidget {
  final User recipient;
  final onChangeRecipient;
  RecipientSelector({this.recipient, this.onChangeRecipient});
  @override
  _RecipientSelectorState createState() => _RecipientSelectorState();
}

class _RecipientSelectorState extends State<RecipientSelector> {
  @override
  Widget build(BuildContext context) {
    List<User> _listOfRecipients = Provider.of<List<User>>(context) ?? [];
    return Container(child: Center(
      child: TextFormField(
        onChanged: (value) {
          User _recipient = _listOfRecipients
              .firstWhere((recipient) => recipient.email == value);
          widget.onChangeRecipient(_recipient);
        },
      ),
    ));
  }
}
