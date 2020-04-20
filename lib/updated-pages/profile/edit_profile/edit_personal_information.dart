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
  String _currentProfileName;
  String _currentProfileAddress;
  String _currentProfileCivilStatus;
  String _currentProfileBloodType;
  String _currentProfileGender;
  DateTime _currentProfileBirthdate;


 
  

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
             _name = value;
             _currentProfileName = _currentProfile.name;
            });
          })
          , SizedBox(height: 15.0),
          buildGender(context, _profile.gender, _currentProfile.gender, (String value) => {
              setState(() {
                _gender = _currentProfile.gender;
                _currentProfileGender = _currentProfile.gender;
          })}), SizedBox(height: 15.0),
          buildBloodType(context, _profile.bloodType,_currentProfile.bloodType, (String value) => {
            setState(() {
              _bloodType = value;  
              _currentProfileBloodType = _currentProfile.bloodType;
          })}),SizedBox(height: 15.0),
          buildTextFormField(context, 'Address', _currentProfile.address, (String value) {
            setState(() {
              _address = value;
              _currentProfileAddress = _currentProfile.address;
            });
          }),
          SizedBox(height: 15.0),
          buildDateTimePicker(context, _currentProfile.birthDate, (DateTime value) {
            setState(() {
            _birthDate = value;
            _currentProfileBirthdate = _currentProfile.birthDate;
            });
            
          }), SizedBox(height: 15.0),
          buildCivilStatus(context, _profile.civilStatus,_currentProfile.civilStatus, (String value) => {
              setState(() {
                _civilStatus = value;
                _currentProfileCivilStatus = _currentProfile.civilStatus;
          })}), SizedBox(height: 10.0),
          // RaisedButtonIcon(Icons.subdirectory_arrow_left, 'Submit', (){})
          ]),
         ),
        );
        }
        return Container();
      },
    );
  }
}
