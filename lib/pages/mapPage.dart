import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:me_daily/model/locationLog.dart';
import 'package:me_daily/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:me_daily/model/user.dart';
import 'dart:async';
import 'package:me_daily/widgets/button_widget.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

final Map<String, Marker> _markers = {};

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  LocationLog _locationLog = LocationLog();
  MapType _currentMapType = MapType.normal;
  List<Marker> markers = <Marker>[];
  String _currentLocation = ''; 
  static Position userLocation; 

  Future<String> _getAddress(Position position) async {
    List<Placemark> placemarks = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark position = placemarks[0];
      return position.thoroughfare + ', ' + position.locality;
    }
    return "";
  }
  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    var currentAddress = await _getAddress(currentLocation);
    _currentLocation = currentAddress;    
    setState(() {
      userLocation = currentLocation;
      _markers.clear();
      _goToTheUser();
      final marker = Marker(
        markerId: MarkerId("current_location"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: currentAddress),
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

 static final CameraPosition _userCurrentLocation = CameraPosition(
      bearing: 0,
      target: LatLng(userLocation.latitude, userLocation.longitude),
      tilt: 90,
      zoom: 18);

  Future<void> _goToTheUser() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userCurrentLocation));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _firestoreService = FirestoreService(uid: user.uid);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 3,
        ),
        mapType: _currentMapType,
        markers: _markers.values.toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 275.0, top: 40.0),
        child: Column(
          children: <Widget>[
            _currentLocation == '' 
            ? Text('Click Flag to Enter Current Location')
            : Column(
            children: <Widget>[
              Text(_currentLocation, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800])),
              SizedBox(height: 15.0),
              button(() {
                  setState(() {
                    _locationLog.locationName = _currentLocation;
                    _locationLog.dateAndTime = DateTime.now();
                    _firestoreService.saveLocation(_locationLog);
                  });
                }, Icons.save_alt, 'Save Location'),
            ],
          ),
            SizedBox(height: 15.0),
            button(_getLocation, Icons.flag, 'Get Location'),
            SizedBox(height: 15.0,),
            button(_onMapTypeButtonPressed, Icons.map, 'Change Map Type'),
            SizedBox(height: 15.0,),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(5),
        color: Colors.pink[100],
        child: _currentLocation == '' ? Text('Click Flag Button to View Current Location and Save', style: TextStyle(fontSize: 9, color: Colors.white))
        : Text('You can click the marker and may choose options at the lower right.', style: TextStyle(fontSize: 9, color: Colors.white))
      ),
    );
  }
}
