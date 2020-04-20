import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/widgets/raisedButton_widget.dart';
import 'package:me_daily/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/constants/strings.dart';

class UserProfileSummary extends StatefulWidget {
  @override
  _UserProfileSummaryState createState() => _UserProfileSummaryState();
}

class _UserProfileSummaryState extends State<UserProfileSummary> {

  @override
  Widget build(BuildContext context) {
    Profile _currentProfile = Provider.of<Profile>(context);
    final bmi = _currentProfile.weight / (_currentProfile.height * _currentProfile.height) ;
    var formatter = new DateFormat('MM-dd-yyyy');
    String formatBirthDate = formatter.format(_currentProfile.birthDate);
    var difference = DateTime.now().difference(_currentProfile.birthDate).inDays;
    var age = (difference/365).floor().toString();

    if (difference < 0) {
      age = '0';
    }

    String bmiCategory;
    
    if (bmi <= 0) {
      bmiCategory = 'Invalid';
    } else if (bmi < 18.5) {
      bmiCategory = 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9 ){
      bmiCategory = 'Normal';
    } else if (bmi >= 25 && bmi <= 29.9){
      bmiCategory = 'Overweight';
    } else if (bmi >= 30) {
      bmiCategory = 'Obese';
    }
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        Container(
          width: 1000,
          height: 175,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 50),
                  _currentProfile.downloadUrl == null
                      ? CircleAvatar(
                          radius: 45.0, backgroundColor: Colors.grey[350])
                      : CircleAvatar(
                          radius: 45.0,
                          backgroundImage: NetworkImage(_currentProfile.downloadUrl, scale: 50.0),
                      ),
                      IconButton(tooltip: 'Change Profile Photo' , icon: Icon(Icons.edit, color: Colors.white), iconSize: 20,
                      onPressed: () {Navigator.popAndPushNamed(context, Strings.editProfilePhotoPageRoute);},
                  ),   
                ],
              ),
              SizedBox(height: 12.0),
              Text(_currentProfile.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
              ],
          )),
        SizedBox(height: 20.0),
        TextWidget(text: 'Address: '),
        Text(_currentProfile.address, style: TextStyle(fontSize: 18.0)),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(text: 'Age: '),
            Text(age, style: TextStyle(fontSize: 18.0)),
            SizedBox(width: 20.0),
            TextWidget(text: 'Birthdate: '),
            Text(formatBirthDate, style: TextStyle(fontSize: 18.0)),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(text: 'Gender :'),
            SizedBox(width: 5.0),
            Text(_currentProfile.gender, style: TextStyle(fontSize: 18.0)),
            SizedBox(width: 20.0),
           TextWidget(text: 'Civil Status:'),
            SizedBox(width: 5.0),
            Text(_currentProfile.civilStatus, style: TextStyle(fontSize: 18.0)),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          TextWidget(text: 'Blood Type:'),
          SizedBox(width: 5.0),
          Text(_currentProfile.bloodType, style: TextStyle(fontSize: 18.0)),
        ]),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          TextWidget(text: 'Height:'),
          SizedBox(width: 5.0),
          Text(_currentProfile.height.toString() + ' m', style: TextStyle(fontSize: 18.0)),
           SizedBox(width: 20.0),
          TextWidget(text: 'Weight:'),
          SizedBox(width: 5.0),
          Text(_currentProfile.weight.toString() + ' kg',style: TextStyle(fontSize: 18.0)),
        ]),
        Divider(),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          TextWidget(text: 'Body Mass Index: '),
          SizedBox(width: 5.0),
          Text(bmi.toStringAsFixed(3), style: TextStyle(fontSize: 18.0)),
        ]),
          Divider(),
          TextWidget(text: 'Category: '),
          SizedBox(width: 5.0),
          Text(bmiCategory, style: TextStyle(fontSize: 18.0)),
          SizedBox(height:50),
          RaisedButtonIcon(Icons.edit, 'Edit Profile', () {Navigator.popAndPushNamed(context, Strings.editProfilePageRoute);})
      ]),
    );
  }
}
