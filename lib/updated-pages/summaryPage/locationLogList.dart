import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/constants/strings.dart';


class LocationLogList extends StatefulWidget {
  @override
  _LocationLogListState createState() => _LocationLogListState();
}

class _LocationLogListState extends State<LocationLogList> {
  @override
  Widget build(BuildContext context) {
    List<LocationLog> locations = Provider.of<List<LocationLog>>(context);

    if (locations == null ) {
      locations = [];
    }

    Widget buildListOfLocations(context, document) {
      return  ListTile(
        leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
        title: Align(
        child: Text(document.locationName, style: TextStyle(fontSize: 12)),
        alignment: Alignment(-1.3, 0)),
        subtitle: Align(child: Text(document.dateAndTime.toString(), style: TextStyle(fontSize: 11)),
        alignment: Alignment(-1.3, 0)
        ),
      );
    }
    
    return Container(
        padding: EdgeInsets.all(3),
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (BuildContext context, int index) {
            return buildListOfLocations(context, locations[index]);
          }
        )
    );
  }
}

