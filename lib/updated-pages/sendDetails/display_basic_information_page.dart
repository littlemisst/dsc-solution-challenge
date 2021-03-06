import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/dateFormatter.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/model/user.dart';
import 'package:provider/provider.dart';

class DisplayBasicInformation extends StatelessWidget {
  final profile;
  final bmi;
  final age;
  DisplayBasicInformation({this.profile, this.age, this.bmi});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return ContentContainer(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: profile != null
                ? Column(
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
                                  backgroundImage:
                                      NetworkImage(profile.downloadUrl),
                                ),
                          Column(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                profile.name,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor),
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
                                DateTimeFormatter(date: profile.birthDate).dateFormat,
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
                          _buildBasicInfo(context, age, 'Age'), 
                          _buildBasicInfo(context, profile.height, 'Height'),
                          _buildBasicInfo(context, profile.weight, 'Weight'),
                          _buildBasicInfo(context, bmi.toStringAsFixed(2), 'BMI'),
                          _buildBasicInfo(
                              context, profile.bloodType, 'Blood Type'),
                        ],
                      )
                    ],
                  )
                : Container(
                    child: Text('Basic Information not recorded'),
                  )));
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
