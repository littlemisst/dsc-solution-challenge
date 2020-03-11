import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/api/share_details_api.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/api/profile_page_api.dart';
import 'package:provider/provider.dart';

class SendDetailsForm extends StatefulWidget {
  @override
  _SendDetailsState createState() => _SendDetailsState();
}

class _SendDetailsState extends State<SendDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  Profile _profile = Profile();

  String _ageValue;
  String _civilStatusValue;
  String _bloodTypeValue;

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
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        onChanged: (String value) => {_profile.name = value});
  }

  Widget _buildGender() {
    return Center(
        child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      items: [
        DropdownMenuItem<String>(child: Text('Male'), value: 'Male'),
        DropdownMenuItem<String>(child: Text('Female'), value: 'Female'),
      ],
      onChanged: (String value) => {
        setState(() {
          _ageValue = value;
          _profile.gender = value;
        })
      },
      hint: Text('Gender'),
      value: _ageValue,
    ));
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
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      onChanged: (String value) => {_profile.address = value},
    );
  }

  Widget _buildDatePicker() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          labelText: 'Birthdate',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
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
    return Center(
        child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      items: [
        DropdownMenuItem<String>(child: Text('Single'), value: 'Single'),
        DropdownMenuItem<String>(child: Text('Married'), value: 'Married'),
      ],
      onChanged: (String value) => {
        setState(() {
          _civilStatusValue = value;
          _profile.civilStatus = value;
        })
      },
      hint: Text('Civil Status'),
      value: _civilStatusValue,
    ));
  }

  Widget _buildBloodType() {
    return Container(
        width: 120.0,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
          items: [
            DropdownMenuItem<String>(child: Text('A+'), value: 'A+'),
            DropdownMenuItem<String>(child: Text('A-'), value: 'A-'),
            DropdownMenuItem<String>(child: Text('B+'), value: 'B+'),
            DropdownMenuItem<String>(child: Text('B-'), value: 'B-'),
            DropdownMenuItem<String>(child: Text('O+'), value: 'O+'),
            DropdownMenuItem<String>(child: Text('O-'), value: 'O-'),
            DropdownMenuItem<String>(child: Text('AB+'), value: 'AB+'),
            DropdownMenuItem<String>(child: Text('AB-'), value: 'AB-'),
          ],
          onChanged: (String value) => {
            setState(() {
              _bloodTypeValue = value;
              _profile.bloodType = value;
            })
          },
          hint: Text('Blood Type'),
          value: _bloodTypeValue,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Column(children: <Widget>[
              SizedBox(height: 15),
              _buildNameField(),
              SizedBox(height: 5),
              _buildGender(),
              SizedBox(height: 5),
              _buildAddressField(),
              SizedBox(height: 5),
              _buildDatePicker(),
              SizedBox(height: 5),
              _buildCivilStatus(),
              SizedBox(height: 5),
              _buildBloodType(),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                      color: Colors.pink[100],
                      onPressed: () => submitDetails(_profile),
                      child: Text('Submit Details',
                          style: TextStyle(color: Colors.white)))),
            ])));
  }
}

class SendDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Submit Details', style: TextStyle(color: Colors.pink[100])),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10), child: SendDetailsForm()));
  }
}
