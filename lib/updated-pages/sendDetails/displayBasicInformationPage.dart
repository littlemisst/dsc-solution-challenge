import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/model/profile.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';

class DisplayBasicInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    final user = Provider.of<User>(context);
    return ContentContainer(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text('Basic Information'),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                profile.downloadUrl == null
                    ? CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey,
                      )
                    : CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(profile.downloadUrl),
                      ),
                Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      profile.name,
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      profile.address,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      profile.civilStatus,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      profile.birthDate.toLocal().toString(),
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildBasicInfo(context, '20', 'Age'), //to be fix
                _buildBasicInfo(context, profile.height, 'Height'),
                _buildBasicInfo(context, profile.weight, 'Weight'),
                _buildBasicInfo(context, '25', 'BMI'), //to be fix
                _buildBasicInfo(context, profile.bloodType, 'Blood Type'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildBasicInfo(context, info, text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(info.toString()), //to be fix,
      Text(
        text,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );
}
