import 'package:flutter/material.dart';

Widget buildEmailField(context, user) {
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
        user.email = value;
      });
}

Widget buildPasswordField(context, user, passwordController) {
  return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      controller: passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'is empty';
        }
        return null;
      },
      onChanged: (String value) {
        user.password = value;
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
