import 'package:flutter/material.dart';

class RecipientSelector extends StatefulWidget {
  String recipient;
  final onChangeRecipient;
  RecipientSelector({this.recipient, this.onChangeRecipient});
  @override
  _RecipientSelectorState createState() => _RecipientSelectorState();
}

class _RecipientSelectorState extends State<RecipientSelector> {
  //String _recipient;
  // List _recipients = [
  //   'Doctor 1',
  //   'Doctor 2',
  //   'Doctor 3',
  //   'Doctor 4',
  // ];

  @override
  Widget build(BuildContext context) {
    // List<DropdownMenuItem<String>> _listOfRecipients = [];

    // _recipients.forEach((recipient) {
    //   _listOfRecipients.add(
    //     DropdownMenuItem<String>(child: Text(recipient), value: recipient),
    //   );
    // });
    return Container(
        child: Center(
          child: TextFormField(onChanged: widget.onChangeRecipient,),
      //       child: DropdownButtonFormField<String>(
      // decoration: InputDecoration(
      //   enabledBorder:
      //       OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      // ),
      // items: _listOfRecipients,
      // onChanged: widget.onChangeRecipient,
      // hint: Text('Share to'),
      // value: widget.recipient,
    ));
  }
}
