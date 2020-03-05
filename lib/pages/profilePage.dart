import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/api/home_page_api.dart';
import 'package:me_daily/api/profile_page_api.dart';
import 'package:me_daily/notifier/authentication_notifier.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/model/profile.dart';
import 'dart:io';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  Profile _profile = Profile();

  Widget _buildNameField() {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
        onChanged: (String value) => {_profile.name = value});
  }

  Widget _buildAddressField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Address',
      ),
      onChanged: (String value) => {_profile.address = value},
    );
  }

  Widget _buildDatePicker() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(labelText: 'Birthdate'),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        onChanged: (DateTime value) => {_profile.birthDate = value},
      ),
    ]);
  }

  Widget _buildCivilStatus() {
    String _value;
    return Center (
      child: DropdownButtonFormField<String> (
        items: [
          DropdownMenuItem<String> (
            child: Text('Single'),
            value: 'Single'
          ),
          DropdownMenuItem<String> (
            child: Text('Married'),
            value: 'Married'
          ),
        ],
        onChanged: (String value) => {
            setState((){
              _value = value;
              _profile.civilStatus = value;
            })
        },
        hint: Text('Civil Status'),
        value: _value,
      ) 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
            child: Column(children: <Widget>[
              _buildNameField(),
              _buildAddressField(),
              _buildDatePicker(),
              _buildCivilStatus(),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                      onPressed: () => submitProfile(_profile),
                      child: Text('Submit')))
            ])));
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      body: Column(children: <Widget>[
        ProfileForm(),
        RaisedButton(
          child: Text('Sign Out'),
          onPressed: () => signOut(authNotifier),
        ),
      ]),
    );
  }
}
