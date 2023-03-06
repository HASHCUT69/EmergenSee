import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



class MyApp2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  late GoogleMapController _mapController;
  LocationData? _locationData;
  // LatLng? sourceLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(_locationData?.latitude ?? 0.0, _locationData?.longitude ?? 0.0),

        zoom: 14.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('EmergenSee'),
        ),
        body: Column(
            children: [
              // Start Text Box
              Container(
                height: 60,
                color: Colors.white38,
                alignment: Alignment.center,
                child: Text(
                  'Your Ambulance is on the way',
                  style: TextStyle(fontSize: 25, color: Colors.blue),
                ),
              ),
              Expanded (
                child :GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0.0, 0.0),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("source"),
                      position: LatLng(_locationData?.latitude ?? 17.4704313, _locationData?.longitude ?? 78.7232736),
                    ),
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
              // Container(
              //   child: ElevatedButton(
              //   onPressed: () => _getLocation(),
              //   child: Icon(Icons.location_searching),
              // ),
              // ),
              SizedBox(height:20),
              Container(
                  height:50,
                  child:
                  ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                // side: BorderSide(color: Colors.red)
                              )
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent)
                      ),
                      child:Text("Contact Driver",style: TextStyle(color: Colors.white),)
                  )
              ),
              SizedBox(height: 20,),
            ]
        ),
      ),
    );
  }
}
