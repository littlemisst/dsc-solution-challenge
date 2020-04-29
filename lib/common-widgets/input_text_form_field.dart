import 'package:flutter/material.dart';

class InputTextFormField extends StatefulWidget {
  final String labelText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool isPassword;
  final Function(String) validator;

  InputTextFormField(
      {this.labelText,
      this.textEditingController,
      this.textInputType,
      this.validator,
      this.isPassword = false});

  @override
  _InputTextFormFieldState createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
          labelText: widget.labelText,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      keyboardType: TextInputType.emailAddress,
      validator: widget.validator,
    );
  }
}
