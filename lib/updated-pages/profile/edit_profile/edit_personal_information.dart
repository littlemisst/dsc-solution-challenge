import 'package:flutter/material.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/widgets/edit_profile_widgets.dart';

class EditBasicInformationPage extends StatefulWidget {
  final Profile profile;
  EditBasicInformationPage({Key key, @required this.profile}) : super(key: key);

  @override
  _EditBasicInformationPageState createState() => _EditBasicInformationPageState();
}

class _EditBasicInformationPageState extends State<EditBasicInformationPage> {
  Profile _profile = Profile();
  Profile profile;
  String _name;
  String _gender;
  String _bloodType;
  String _civilStatus;
  String _address;
  DateTime _birthDate;


  Profile _profileFromState() {
    return Profile(
      name: _name,
      address: _address,
      gender: _gender,
      civilStatus: _civilStatus,
      bloodType: _bloodType,
      birthDate: _birthDate,
    );
  }

  Future<void> _addLog(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final _firestoreService = FirestoreService(uid: user.uid);
    final profile = _profileFromState();
    await _firestoreService.submitProfile(profile);
  }

  void _submit() {
    _addLog(context);
  } 


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
            setState(() {
              value = _currentProfile.name;
             _name = value;
            });
          })
          , SizedBox(height: 15.0),
          buildGender(context, _profile.gender, _currentProfile.gender, (String value) => {
              setState(() {
                value = _currentProfile.gender;
              _gender = value;
          })}), SizedBox(height: 15.0),
          buildBloodType(context, _profile.bloodType,_currentProfile.bloodType, (String value) => {
            setState(() {
              value = _currentProfile.bloodType;
              _bloodType = value;   
          })}),SizedBox(height: 15.0),
          buildTextFormField(context, 'Address', _currentProfile.address, (String value) {
            setState(() {
              value = _currentProfile.address;
              _address = value;
            });
          }),
          SizedBox(height: 15.0),
          buildDateTimePicker(context, _currentProfile.birthDate, (DateTime value) {
            setState(() {
              value = _currentProfile.birthDate;
            _birthDate = value;
            });
            
          }), SizedBox(height: 15.0),
          buildCivilStatus(context, _profile.civilStatus,_currentProfile.civilStatus, (String value) => {
              setState(() {
                value = _currentProfile.civilStatus;
                _civilStatus = value;
          })}), SizedBox(height: 10.0),
          RaisedButtonIcon(Icons.subdirectory_arrow_left, 'Submit', () async {_submit();})
          ]),
         ),
        );
        }
        return Container();
      },
    );
  }
}
