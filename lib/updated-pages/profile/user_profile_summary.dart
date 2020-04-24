import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:me_daily/updated-pages/profile/edit_profile/bmiConversion.dart';
import 'package:me_daily/widgets/indicatorText.dart';
import 'package:me_daily/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/constants/strings.dart';

class UserProfileSummary extends StatefulWidget {
  @override
  _UserProfileSummaryState createState() => _UserProfileSummaryState();
}

class _UserProfileSummaryState extends State<UserProfileSummary> {

  Widget _buildNameProfile(url, name, email) {
    return  Container(
      padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      child: Column(children: <Widget>[
        Row(children: <Widget>[ url == null
          ? CircleAvatar(
              radius: 45.0, backgroundColor: Colors.grey)
          : CircleAvatar(
              radius: 45.0,
              backgroundImage: NetworkImage(url, scale: 50.0),
            ),
          IconButton(
            tooltip: 'Change Profile Photo',
            icon: Icon(Icons.camera_alt, color: Theme.of(context).buttonColor),
            iconSize: 20,
            onPressed: () {
              Navigator.popAndPushNamed(context, Strings.editProfilePhotoPageRoute);
            },
          ),
        ],
      ),
      SizedBox(height: 15),
      Row(children: <Widget>[
        Expanded(child: 
          Column(children: <Widget>[
            Align(alignment: Alignment.centerLeft, child: Text(name,
              style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.bold))),
            Align(alignment: Alignment.centerLeft, child: Text(email,
              style: TextStyle(color: Colors.grey)))
            ])
          ),
        FlatButton(
          child: Text('Edit Profile'),
          shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).accentColor), borderRadius: BorderRadius.circular(45)),
          onPressed: () => Navigator.popAndPushNamed(context, Strings.editProfilePageRoute),
          ),
        ]),
      ])
    );
  }


  Widget _buildGender(gender) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Row(children: <Widget>[
        Expanded(child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Gender')),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child: Text(gender, style: TextStyle(fontSize: 15.0)))
        ])),
      ])
    );
  }

  Widget _buildBirthday(birthday) {
    String formatBirthDate = DateFormat.yMMMMd().format(birthday);
    var difference =  DateTime.now().difference(birthday).inDays;
    var age = (difference / 365).floor().toString();

    if (difference < 0) {
      age = '0';
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(children: <Widget>[
        Expanded(child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Birthdate')),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child:Text(formatBirthDate, style: TextStyle(fontSize: 15.0))),
        ])),
        Expanded(child: Column(children: <Widget>[
          TextWidget(text: 'Age'),
          Text(age, style: TextStyle(fontSize: 15.0)),
        ]))
      ])
    );
  }

  Widget _buildAddress(address) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(children: <Widget>[
        Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Address')),
        SizedBox(height: 5),
        Align(alignment: Alignment.centerLeft, child: Text(address, style: TextStyle(fontSize: 15.0)))
    ]));
  }

  Widget _buildCivilStatusAndBloodType(civilStatus, bloodType) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(children: <Widget>[
        Expanded(child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Civil Status')),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child: Text(civilStatus, style: TextStyle(fontSize: 15.0))),
        ])),
        Expanded(child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Blood Type')),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child:  Text(bloodType, style: TextStyle(fontSize: 15.0))),
        ])),
      ])
    );  
  }

  Widget _buildPhysicalMeasurements(height, weight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(children: <Widget>[
        Expanded(child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Height')),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child: Text('$height m', style: TextStyle(fontSize: 15.0))),
        ])),
         Expanded(child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Weight')),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child: Text('$weight kg', style: TextStyle(fontSize: 15.0))),
        ])),
      ])
    );
  }

  Widget _buildBodyMassIndex(height, weight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(children: <Widget>[
        Expanded(child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Body Mass Index')),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child: Text('${BMIConversion(weight, height).bmi.toStringAsFixed(2)}', style: TextStyle(fontSize: 15.0))),
        ])),
         Expanded(child: Column(children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: TextWidget(text: 'Category')),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child: Text('${BMIConversion(weight, height).bmiCategory}', style: TextStyle(fontSize: 15.0))),
        ])),
      ])
    );
  }

  Widget _buildMedicalHistory() {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Column(children: <Widget>[
        IndicatorText('MEDICAL HISTORY'),
        FlatButton(child: Text('add'), onPressed: () => Navigator.popAndPushNamed(
          context, Strings.medicalHistoryPage),)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Profile _currentProfile = Provider.of<Profile>(context);
    User _user = Provider.of<User>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(children: <Widget>[
            SizedBox(height: 5),
            _buildNameProfile(_currentProfile.downloadUrl, _currentProfile.name, _user.email),
            SizedBox(height: 5),
            Expanded(child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              color: Theme.of(context).backgroundColor,
              child: Column(children: <Widget>[
              _buildGender(_currentProfile.gender),
              Divider(),
              _buildBirthday(_currentProfile.birthDate),
              Divider(),
              _buildAddress(_currentProfile.address),
              Divider(),
              _buildCivilStatusAndBloodType(_currentProfile.civilStatus, _currentProfile.bloodType),
              Divider(),
              _buildPhysicalMeasurements(_currentProfile.height, _currentProfile.weight),
              Divider(),
              _buildBodyMassIndex(_currentProfile.height, _currentProfile.weight),
            ]))),
            SizedBox(height: 5),
            _buildMedicalHistory()
          ]),
        )
      ),
    );
  }
}
