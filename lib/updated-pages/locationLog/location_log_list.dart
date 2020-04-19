import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/widgetContainer.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/constants/strings.dart';


class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    List<LocationLog> locationLog = Provider.of<List<LocationLog>>(context);

    if (locationLog == null ) {
      locationLog = [];
    }

    Widget buildListOfLocations(context, document) {
      return  ListTile(
        leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
        title: Text(document.locationName),
        subtitle: Text(document.dateAndTime.toString()),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popAndPushNamed(context, Strings.initialRoute),
        ),
        title: Text(
          'Location log',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
      ),
      body: locationLog.isNotEmpty ? Container(
        child: ListView.builder(
          itemCount: locationLog.length,
          itemBuilder: (BuildContext context, int index) {
            return ContentContainer(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: buildListOfLocations(context, locationLog[index])
            );
          }
        )
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
        SizedBox(height: 80),
        Icon(Icons.not_listed_location, color: Colors.blueGrey[200] ),
        Text(' No Saved Location', style: TextStyle(color: Colors.blueGrey[200]))
      ])
    );
  }
}

