import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({Key key, this.label, this.items, this.onChanged, this.initialValue}) : super(key:key);
  final String label;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String> onChanged;
  final String initialValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: Text(label)),
        SizedBox(height: 5),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          items: items,
          onChanged: onChanged,
          value: initialValue,
        )
      ])
    );
  }
}

