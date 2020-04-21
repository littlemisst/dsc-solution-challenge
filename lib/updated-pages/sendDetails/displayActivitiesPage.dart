import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class DisplayActivitiesPage extends StatelessWidget {
  final activities;
  DisplayActivitiesPage({this.activities});
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
            Text('Activities'),
            Divider(),
            Container(
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: activities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildListOfActivities(context, activities[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildListOfActivities(context, document) {
  return ListTile(
      leading:
          Icon(Icons.directions_walk, color: Theme.of(context).primaryColor),
      title: Text(document));
}
