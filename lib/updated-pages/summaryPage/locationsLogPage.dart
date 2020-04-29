import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/dateFormatter.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:provider/provider.dart';

class LocationLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<LocationLog> locations = Provider.of<List<LocationLog>>(context) ?? [];

    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'Last Recorded Location',
                ),
              ),
            ),
            locations.isEmpty
                ? Expanded(
                    child: Text(
                      'No recorded location',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : Expanded(
                    child: ListTile(
                    leading: Icon(Icons.location_on,
                        color: Theme.of(context).primaryColor),
                    title: Column(
                      children: <Widget>[
                        Align(
                            child: Text(locations[0].locationName,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            alignment: Alignment.centerLeft),
                        SizedBox(height: 3),
                        Align(
                            child: Text(DateTimeFormatter(date: locations[0].dateAndTime).dateTimeFormat,
                                style: TextStyle(fontSize: 12)),
                            alignment: Alignment.centerLeft)
                      ],
                    ),
                  )),
          ]),
    );
  }
}
