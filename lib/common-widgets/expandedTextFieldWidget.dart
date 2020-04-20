import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpandedTextField extends StatelessWidget {
  const ExpandedTextField(this.text, this.onChanged);
  final String text;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
      Container(child:
        TextFormField(
          style: TextStyle(fontSize: 15, height: 1),
          decoration: InputDecoration(
            labelText: text,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: onChanged,
        ),
      )
    );
  }
}