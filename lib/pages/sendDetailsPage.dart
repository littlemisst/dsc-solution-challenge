import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/api/share_details_api.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/api/profile_page_api.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
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
  String _gender;

  Widget _buildNameField(context, initialValue) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        initialValue: initialValue,
        decoration: const InputDecoration(
          labelText: 'Name',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        onChanged: (String value) => {_profile.name = value});
  }

  Widget _buildGender(context, initialValue) {
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
          _gender = value;
          _profile.gender = value;
        })
      },
      hint: Text('Gender'),
      value: initialValue,
    ));
  }

  Widget _buildAddressField(context, initialValue) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      initialValue: initialValue,
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

  Widget _buildCivilStatus(context, inititalValue) {
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
      value: _civilStatusValue ?? inititalValue,
    ));
  }

  Widget _buildBloodType(context, initialValue) {
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
          value: _bloodTypeValue ?? initialValue,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Profile>(
      stream: FirestoreService(uid: user.uid).profile,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          Profile _currentProfile = snapshots.data;

          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Column(children: <Widget>[
                SizedBox(height: 15),
                _buildNameField(context, _currentProfile.name),
                SizedBox(height: 5),
                _buildGender(context, _currentProfile.gender),
                SizedBox(height: 5),
                _buildAddressField(context, _currentProfile.address),
                SizedBox(height: 5),
                _buildDatePicker(),
                SizedBox(height: 5),
                _buildCivilStatus(context, _currentProfile.civilStatus),
                SizedBox(height: 5),
                _buildBloodType(context, _currentProfile.bloodType),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                        color: Colors.pink[100],
                        onPressed: () => submitDetails(_profile),
                        child: Text('Submit Details',
                            style: TextStyle(color: Colors.white)))),
              ]),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class SendDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Submit Details', style: TextStyle(color: Colors.pink[100])),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10), child: SendDetailsForm()));
  }
}