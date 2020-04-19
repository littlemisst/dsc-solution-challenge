import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';

class BasicInformationPage extends StatefulWidget {
  final Profile profile;
  final onChangeProfile;
  BasicInformationPage({this.profile, this.onChangeProfile});
  @override
  _BasicInformationPageState createState() => _BasicInformationPageState();
}

class _BasicInformationPageState extends State<BasicInformationPage> {
  final _formKey = GlobalKey<FormState>();

  Profile _profile = Profile();

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
      onChanged: (String value) => {
        _profile.name = value,
        widget.onChangeProfile(_profile),
      },
    );
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
          _profile.gender = value;
        }),
        widget.onChangeProfile(_profile)
      },
      hint: Text('Gender'),
      value: _profile.gender ?? initialValue,
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
      onChanged: (String value) => {
        _profile.address = value,
        widget.onChangeProfile(_profile),
      },
    );
  }

  Widget _buildDatePicker(context, initialValue) {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          labelText: 'Birthdate',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        format: format,
        initialValue: initialValue,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        onChanged: (DateTime value) => {
          _profile.birthDate = value,
          widget.onChangeProfile(_profile),
        },
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
          _profile.civilStatus = value;
        }),
        widget.onChangeProfile(_profile)
      },
      hint: Text('Civil Status'),
      value: _profile.civilStatus ?? inititalValue,
    ));
  }

  Widget _buildBloodType(context, initialValue) {
    return Container(
        width: 150.0,
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
              _profile.bloodType = value;
            }),
            widget.onChangeProfile(_profile)
          },
          hint: Text('Blood Type'),
          value: _profile.bloodType ?? initialValue,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Profile>(
      stream: FirestoreService(uid: user.uid).profile,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          _profile = snapshots.data;
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Column(children: <Widget>[
                  Text('Basic Information'),
                  SizedBox(height: 15),
                  _buildNameField(context, _profile.name),
                  SizedBox(height: 5),
                  _buildGender(context, _profile.gender),
                  SizedBox(height: 5),
                  _buildAddressField(context, _profile.address),
                  SizedBox(height: 5),
                  _buildDatePicker(context, _profile.birthDate),
                  SizedBox(height: 5),
                  _buildCivilStatus(context, _profile.civilStatus),
                  SizedBox(height: 5),
                  _buildBloodType(context, _profile.bloodType),
                ]),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
