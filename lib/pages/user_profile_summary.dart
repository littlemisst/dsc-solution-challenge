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
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        Container(
            width: 1000,
            height: 175,
            color: Colors.pink[100],
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                _currentProfile.downloadUrl == null
                    ? CircleAvatar(
                        radius: 50.0, backgroundColor: Colors.grey[350])
                    : CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            _currentProfile.downloadUrl,
                            scale: 50)),
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
        Text(_currentProfile.birthDate.toString(), style: TextStyle(fontSize: 18.0)),
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
          Text(_currentProfile.height.toString() + ' cm', style: TextStyle(fontSize: 18.0)),
           SizedBox(width: 20.0),
          Text('Weight:', style: TextStyle(color: Colors.grey[400])),
          SizedBox(width: 5.0),
          Text(_currentProfile.height.toString() + ' kg',style: TextStyle(fontSize: 18.0)),
        ]),
        Divider()
      ]),
    );
  }
}
