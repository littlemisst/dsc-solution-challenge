import 'package:flutter/material.dart';

class EmailTextFormField extends StatefulWidget {
  final String email;
  EmailTextFormField({this.email});
  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty) {
            return 'is empty';
          }
          return null;
        },
        onChanged: (String value) {
          setState(() {
            email = value.trim();
          });
        });
  }
}
