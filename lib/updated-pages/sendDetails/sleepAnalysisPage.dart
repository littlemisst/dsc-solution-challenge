import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class SleepAnalysis extends StatelessWidget {
  final averageHoursSlept;
  SleepAnalysis({this.averageHoursSlept});
  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text('Sleep Analysis'),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                averageHoursSlept == null
                    ? Text('No record of hours slept')
                    : Text(
                        averageHoursSlept.toStringAsFixed(2),
                        style: TextStyle(fontSize: 16),
                      ),
                Text(
                  'Average Sleeping hours',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
