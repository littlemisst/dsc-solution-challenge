import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

final Map<String, Marker> _markers = {};

class _MapPageState extends State<MapPage> {

    void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _markers.clear();
      final marker = Marker(
          markerId: MarkerId("curr_loc"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(40.688841, -74.044015),
          zoom: 11.0,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 275.0),
        child: FloatingActionButton(
          onPressed: _getLocation,
          tooltip: 'Get Location',
          child: Icon(Icons.flag),
          backgroundColor: Colors.pink[100],
        ),
      ),
    );
  }
}
