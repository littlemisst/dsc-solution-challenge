import 'package:flutter/material.dart';
class BuildRadioListView extends StatefulWidget {
  BuildRadioListView(this.itemsList, this.groupValue, this.onChanged);
  final List itemsList;
  final String groupValue;
  final ValueChanged<dynamic> onChanged;
  @override
  _BuildRadioListViewState createState() => _BuildRadioListViewState();
}

class _BuildRadioListViewState extends State<BuildRadioListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.itemsList.length,
      itemBuilder: (context, index) {
        final item = widget.itemsList[index];
        return ListTile(
          contentPadding: EdgeInsets.all(0),
            title: Text(item, style: TextStyle(fontSize: 13)),
            leading: Radio(
              activeColor: Theme.of(context).primaryColor,
              value: item,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged
            )
        );
      });
  }
}
