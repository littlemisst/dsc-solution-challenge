import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/alertDialog.dart';
import 'package:me_daily/common-widgets/appBarTextFormat.dart';
import 'package:me_daily/common-widgets/datePicker.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:me_daily/widgets/dropDownWidget.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/widgets/textFormField_widget.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/widgets/edit_profile_widgets.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final metersController = TextEditingController();
  final kilogramController = TextEditingController();

  @override
  void initState() {
    super.initState();
  
  }

  @override
  void dispose() {
    metersController.dispose();
    kilogramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: _user.uid);
    final _currentProfile = Provider.of<Profile>(context) ?? Profile();

    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popAndPushNamed(context, Strings.profilePageRoute),
        ),
        title: TextFormat('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(children: <Widget>[
              SizedBox(height: 10.0),
              TextFormFieldWidget(label: 'Full Name', initialValue: _currentProfile.name, 
              onChanged: (String value) {
                _currentProfile.name = value;
              }),
              SizedBox(height: 15.0),
              Row(children: <Widget>[
              Expanded(child: DatePicker(initialValue: _currentProfile.birthDate, text: 'Birthdate', onChanged: (DateTime value) => _currentProfile.birthDate = value)),
              SizedBox(width: 20),
              Expanded(
                child: DropDownWidget(label: 'Civil Status', items: Strings.civilStatusList, 
                  onChanged: (value) {
                    setState(() =>
                      _currentProfile.civilStatus = value);
                  },
                initialValue: _currentProfile.civilStatus,
              )),
            ]),
            SizedBox(height: 15.0),
            Row(children: <Widget>[
              Expanded(child: DropDownWidget(label: 'Gender', items: Strings.genderList,
              onChanged: (value) {
                setState(() =>  _currentProfile.gender = value);
              },
              initialValue:  _currentProfile.gender,
              )),
              SizedBox(width: 20),
              Expanded(child: DropDownWidget(label: 'Blood Type', items: Strings.bloodTypeList,
                onChanged: (value) {
                  setState(() =>  _currentProfile.bloodType);
                },
                initialValue:  _currentProfile.bloodType
              )),
            ]),
            SizedBox(height: 15.0),
            TextFormFieldWidget(initialValue: _currentProfile.address, label: 'Complete Address', onChanged: (String value) => _currentProfile.address = value),
            SizedBox(height: 15.0),
            Row(children: <Widget>[
              Expanded(child: Column(children: <Widget>[
                Text('Height'),
                SizedBox(height: 5),
                buildHeightWeightField(context, metersController,
                  _currentProfile.height.toString(), 'm', (value) =>  _currentProfile.height = double.parse(value))
              ,
              ])),
              Expanded(child: Column(children: <Widget>[
                 Text('Weight'),
                SizedBox(height: 5),
                buildHeightWeightField(context, kilogramController,
                  _currentProfile.weight.toString(), 'kg', (value) =>  _currentProfile.weight = double.parse(value)),
              ]))
             
            ]),
            
            SizedBox(height: 10.0),
            FlatButtonIcon(Icons.edit, 'Submit Edited Profile', 
              () async {
                final action = await Dialogs.showDialogBox(context, Strings.confirmChanges);
                if (action == DialogAction.yes) {
                  await _firestoreService.submitProfile(_currentProfile);
                  Navigator.popAndPushNamed(context, Strings.profilePageRoute);
                }
              })
            ]),
          ),
        ),
      ),
    );
  }
}
