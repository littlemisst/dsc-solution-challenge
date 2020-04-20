import 'package:flutter/material.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/updated-pages/profile/edit_profile/edit_height_weight.dart';
import 'package:me_daily/updated-pages/profile/edit_profile/edit_personal_information.dart';
import 'package:me_daily/updated-pages/profile/edit_profile/edit_profile_photo.dart';
import 'package:me_daily/widgets/flatButton_widget.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

int _currentStep = 0;

List<Step> _steps = [
  Step(
    isActive: _currentStep >= 0,
    title: Text('Basic Information'),
    content: EditBasicInformationPage(),
  ),
  Step(
    isActive: _currentStep >= 0,
    title: Text('Basic Information'),
    content: EditHeightAndWeightPage(),
  ),
  Step(
    isActive: _currentStep >= 0,
    title: Text('Basic Information'),
    content: EditProfilePhoto(),
  ),
];

class _EditProfileState extends State<EditProfile> {

  //  Profile _profileFromState() {
  //   return Profile(
  //     name:  _name ?? '_name' ,
  //     address:  _address ?? '_address',
  //     gender:  _gender ?? '_gender',
  //     civilStatus: _civilStatus ?? '_civilStatus',
  //     bloodType:  _bloodType ?? '_bloodType',
  //     birthDate:  _birthDate ?? DateTime.now(),
  //     weight:  20 ?? 121,
  //     height:  212 ?? 2121,
  //     profilePhotoFileName:  '21212121' ?? '_birthDate',
  //     downloadUrl:  '21212121' ?? '_birthDate',
  //   );
  // }

  // Future<void> _editProfile(BuildContext context) async {
  //   final user = Provider.of<User>(context, listen: false);
  //   final _firestoreService = FirestoreService(uid: user.uid);
  //   final profile = _profileFromState();
  //   await _firestoreService.submitProfile(profile);
  // }

  // void _submit() {
  //   _editProfile(context);
  // } 

  next() {
    if (_currentStep >= _steps.length - 1) return;
        setState(() {
          _currentStep++;
    });
  }

  cancel() {
    if (_currentStep <= 0) return;
    setState(() {
      _currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popAndPushNamed(context, Strings.profilePageRoute),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stepper(
        currentStep: _currentStep,
         controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
            return Container(
              child: Row (children: <Widget>[
                FlatButtonWidget(
                  color: Colors.white,
                  child: Text('Back'),
                  onPressed: _currentStep == 0 ? null : onStepCancel
                ), SizedBox(width: 10),
                FlatButtonWidget(
                  color: Theme.of(context).primaryColor,
                  child: _currentStep == _steps.length - 1 ? Text('Next') : Text('Next', style: TextStyle(color: Colors.white)),
                  onPressed: _currentStep == _steps.length - 1 ? null : onStepContinue
                )
              ]) 
            );
          },
        onStepContinue: next,
        onStepCancel: cancel,
        steps: _steps,
      ),
    );
  }
}
