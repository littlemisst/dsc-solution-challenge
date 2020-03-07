import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';
import 'package:location/location.dart' as l;
import 'package:flutter/services.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

final Map<String, Marker> _markers = {};

class _MapPageState extends State<MapPage> {
  var currentNearestLocation;
  var location = new l.Location();
  List<dynamic> _nearbyPlaces = [];
  MapType _currentMapType = MapType.normal;

  void _getNearbyPlaces() async {
    var currentNearestLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    HereMaps(apiKey: "AIzaSyDB45n30I-A2OXGDbYhTDh1xLsrmNTCxkk")
        .exploreNearbyPlaces(
            lat: currentNearestLocation.latitude,
            lon: currentNearestLocation.longitude,
            offset: 1000)
        .then((response) {
      setState(() {
        _nearbyPlaces.addAll(response['results']['items']);
      });
    });
  }

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
      print(_nearbyPlaces);
    });
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
        onPressed: function,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: Colors.pink[100],
        child: Icon(icon, size: 36.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(10.720321, 122.562019),
          zoom: 11.0,
        ),
        mapType: _currentMapType,
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 275.0, top: 40.0),
        child: Column(
          children: <Widget>[
            FloatingActionButton(
              onPressed: _getLocation,
              tooltip: 'Get Location',
              child: Icon(Icons.flag),
              backgroundColor: Colors.pink[100],
            ),
            SizedBox(
              height: 15.0,
            ),
            button(_onMapTypeButtonPressed, Icons.map),
          ],
        ),
      ),
    );
  }
}
