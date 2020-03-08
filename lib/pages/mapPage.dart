
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

final Map<String, Marker> _markers = {};

class _MapPageState extends State<MapPage> {
  MapType _currentMapType = MapType.normal;

  // static const String _API_KEY = 'AIzaSyDB45n30I-A2OXGDbYhTDh1xLsrmNTCxkk';
  List<Marker> markers = <Marker>[];

  // void getNearbyPlaces(double latitude, double longitude) async {
  //   String baseUrl = 'http://maps.googleapis.com';
  //   String keyword = 'hospital';
  //   String url =
  //       '${baseUrl}/maps/api/place/nearbysearch/json?location=${latitude},${longitude}&radius=5000&keyword=${keyword}&key=${_API_KEY}';
  //   final response = await http.get(url);
  // }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    // getNearbyPlaces(currentLocation.latitude, currentLocation.longitude);
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
            SizedBox(
              height: 15.0,
            ),
            FloatingActionButton(
                child: Icon(Icons.local_hospital),
                backgroundColor: Colors.pink[100],
                onPressed: () {
                }),
          ],
        ),
      ),
    );
  }
}
