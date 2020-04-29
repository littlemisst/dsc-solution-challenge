import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/dateFormatter.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class DisplayTemperatureHistory extends StatelessWidget {
  final temperatureHistory;
  DisplayTemperatureHistory({this.temperatureHistory});
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
            Text('Temperature History'),
            Divider(),
            temperatureHistory.isEmpty
                ? Container(
                    child: Text('No record of temperature'),
                  )
                : Container(
                    height: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: temperatureHistory.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildTemperatureHistory(
                              context, temperatureHistory[index]);
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}

Widget buildTemperatureHistory(context, document) {
  return ListTile(
    leading: Icon(Icons.healing, color: Theme.of(context).primaryColor),
    title: Text(document.temperature.toString()),
    subtitle: Text(DateTimeFormatter(date: document.logCreated).dateTimeFormat),
  );
}
