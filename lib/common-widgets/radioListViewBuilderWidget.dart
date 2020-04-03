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
            title: Text(item),
            leading: Radio(
              activeColor: Colors.pink[100],
              value: item,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged
            )
        );
      });
  }
}
