import 'package:flutter/material.dart';

class ExpandedTextField extends StatelessWidget {
  const ExpandedTextField(this.text, this.controller, this.onChanged);
  final String text;
  final TextEditingController controller;
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
          controller: controller,
          onChanged: onChanged,
        ),
      )
    );
  }
}