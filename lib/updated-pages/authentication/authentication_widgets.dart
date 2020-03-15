import 'package:flutter/material.dart';

Widget buildEmailField(context, email) {
  return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'is empty';
        }
        return null;
      },
      onChanged: (String value) {
        email = value;
      });
}

Widget buildPasswordField(context, password) {
  return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      //controller: passwordController,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'is empty';
        }
        return null;
      },
      onChanged: (String value) {
        password = value;
      });
}

Widget buildConfirmPasswordField(context, passwordController) {
  return TextFormField(
    decoration: InputDecoration(labelText: 'Password'),
    obscureText: true,
    validator: (String value) {
      if (passwordController.text != value) {
        return 'Password did not match';
      }
      return null;
    },
  );
}

Widget buildButton(context, child, onPressed) {
  return RaisedButton(
    textColor: Colors.white,
    color: Colors.pink[100],
    child: Text(child),
    padding: EdgeInsets.all(10),
    onPressed: onPressed,
  );
}
