import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_daily/model/profile.dart';
import 'package:provider/provider.dart';

class UserProfileSummary extends StatefulWidget {
  @override
  _UserProfileSummaryState createState() => _UserProfileSummaryState();
}

class _UserProfileSummaryState extends State<UserProfileSummary> {

  @override
  Widget build(BuildContext context) {
    Profile _currentProfile = Provider.of<Profile>(context);
    final bmi = _currentProfile.weight / (_currentProfile.height * _currentProfile.height) ;
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatBirthDate = formatter.format(_currentProfile.birthDate);

    String bmiCategory;

    if (bmi < 18.5) {
      bmiCategory = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25 ){
      bmiCategory = 'Normal';
    } else if (bmi >= 25 && bmi < 30){
      bmiCategory = 'Obese';
    } else {
      bmiCategory = 'Overweight';
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
                _currentProfile.downloadUrl == null
                    ? CircleAvatar(
                        radius: 45.0, backgroundColor: Colors.grey[350])
                    : CircleAvatar(
                        radius: 45.0,
                        backgroundImage: NetworkImage(_currentProfile.downloadUrl, scale: 50.0),
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
        Text('Address:', style: TextStyle(color: Colors.grey[400])),
        Text(_currentProfile.address, style: TextStyle(fontSize: 18.0)),
        Divider(),
        Text('Birthdate:', style: TextStyle(color: Colors.grey[400])),
        Text(formatBirthDate, style: TextStyle(fontSize: 18.0)),
         Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Gender:', style: TextStyle(color: Colors.grey[400])),
            SizedBox(width: 5.0),
            Text(_currentProfile.gender, style: TextStyle(fontSize: 18.0)),
            SizedBox(width: 20.0),
            Text('Civil Status:', style: TextStyle(color: Colors.grey[400])),
            SizedBox(width: 5.0),
            Text(_currentProfile.civilStatus, style: TextStyle(fontSize: 18.0)),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Blood Type:', style: TextStyle(color: Colors.grey[400])),
          SizedBox(width: 5.0),
          Text(_currentProfile.bloodType, style: TextStyle(fontSize: 18.0)),
        ]),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Height:', style: TextStyle(color: Colors.grey[400])),
          SizedBox(width: 5.0),
          Text(_currentProfile.height.toString() + ' m', style: TextStyle(fontSize: 18.0)),
           SizedBox(width: 20.0),
          Text('Weight:', style: TextStyle(color: Colors.grey[400])),
          SizedBox(width: 5.0),
          Text(_currentProfile.weight.toString() + ' kg',style: TextStyle(fontSize: 18.0)),
        ]),
        Divider(),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Body Mass Index:', style: TextStyle(color: Colors.grey[400])),
          SizedBox(width: 5.0),
          Text(bmi.toStringAsFixed(3), style: TextStyle(fontSize: 18.0)),
        ]),
          Divider(),
          Text('Category:', style: TextStyle(color: Colors.grey[400])),
          SizedBox(width: 5.0),
          Text(bmiCategory, style: TextStyle(fontSize: 18.0)),
      ]),
    );
  }
}
