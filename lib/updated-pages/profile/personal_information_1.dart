import 'package:flutter/material.dart';
import 'package:me_daily/widgets/profile_widgets.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/common-widgets/datePicker.dart';

class PersonalInformation1 extends StatefulWidget {
  @override
  _PersonalInformation1State createState() => _PersonalInformation1State();
}

class _PersonalInformation1State extends State<PersonalInformation1> {
  Profile _profile = Profile();
  String _ageValue;
  String _civilStatusValue;

  @override
  Widget _personalInformationForm1() {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        buildNameField(context, _profile.name, (String value) {
          _profile.name = value;
        }),
        SizedBox(height: 30.0),
        buildGender(context, _profile.gender, _ageValue, (String value) => {
            setState(() {
              _ageValue = value;
              _profile.gender = value;
            })
          },
        ), 
        SizedBox(height: 30.0),
        buildAddressField(context, _profile.address, (String value) {
          _profile.address = value;
        }),
        SizedBox(height: 30.0),
        DatePicker('Birthdate', (DateTime value) {
          _profile.birthDate = value;
        }),
        SizedBox(height: 30.0),
        buildCivilStatus(context, _profile.civilStatus, _civilStatusValue, (String value) => {
            setState(() {
              _civilStatusValue = value;
              _profile.civilStatus = value;
            })
          },
        ),
      ]),
    );
  }
  Widget build(BuildContext context) {
    return Container(
      child: _personalInformationForm1(),
    );
  }
}
