import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/widgets/edit_profile_widgets.dart';

class EditBasicInformationPage extends StatefulWidget {
  @override
  _EditBasicInformationPageState createState() => _EditBasicInformationPageState();
}

class _EditBasicInformationPageState extends State<EditBasicInformationPage> {
  Profile _profile = Profile();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
      return StreamBuilder<Profile>(
      stream: FirestoreService(uid: user.uid).profile,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          Profile _currentProfile = snapshots.data;

          return ContentContainer(
      width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(children: <Widget>[
          SizedBox(height: 10.0),
          buildTextFormField(context, 'Name', _currentProfile.name, (String value) {
            _profile.name = _currentProfile.name;
          })
          , SizedBox(height: 15.0),
          buildGender(context, _profile.gender, _currentProfile.gender, (String value) => {
              setState(() {
                _profile.gender = _currentProfile.gender;
          })}), SizedBox(height: 15.0),
          buildBloodType(context, _profile.bloodType,_currentProfile.bloodType, (String value) => {
                  setState(() {
                    _currentProfile.bloodType =_currentProfile.bloodType;
                    _profile.bloodType = value;
          })}),SizedBox(height: 15.0),
          buildTextFormField(context, 'Address', _currentProfile.address, (String value) {
            _profile.address = value;
          }),
          SizedBox(height: 15.0),
          buildDateTimePicker(context, _currentProfile.birthDate, (DateTime value) {
            _profile.birthDate = _currentProfile.birthDate;
          }), SizedBox(height: 15.0),
          buildCivilStatus(context, _profile.civilStatus,_currentProfile.civilStatus, (String value) => {
              setState(() {
                _currentProfile.civilStatus = value;
                _profile.civilStatus = _currentProfile.civilStatus;
          })}), SizedBox(height: 10.0),
          ]),
         ),
        );
        }
        return Container();
      },
    );
  }
}
