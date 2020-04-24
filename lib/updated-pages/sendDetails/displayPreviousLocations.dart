import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';

class DisplayPreviousLocations extends StatelessWidget {
  final previousLocations;
  DisplayPreviousLocations({this.previousLocations});
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
            Text('Track Previous Locations'),
            Divider(),
            previousLocations.isEmpty
                ? Container(
                    child: Text('No record of previous locations'),
                  )
                : Container(
                    height: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: previousLocations.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildListOfLocations(
                              context, previousLocations[index]);
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}

Widget buildListOfLocations(context, document) {
  return ListTile(
    leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
    title: Text(document.locationName),
    subtitle: Text(document.dateAndTime.toString()),
  );
}
