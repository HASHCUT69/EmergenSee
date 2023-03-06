import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class driver extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<driver> {
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
        target: LatLng(
            _locationData?.latitude ?? 0.0, _locationData?.longitude ?? 0.0),
        zoom: 14.0,
      ),
    ));
  }

  //bool? status = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('EmergenSee'),
        ),
        body: Column(children: [
          Container(
            height: 40,
            color: Colors.white38,
            alignment: Alignment.center,
            child: Text(
              'Good Morning',
              style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  color: Colors.black),
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text("Available"),
              onPressed: () {},
              style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: ElevatedButton(
              child: Text(
                "Off Work",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey)),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: CameraPosition(
                target: LatLng(0.0, 0.0),
                zoom: 14.0,
              ),
              // markers: {
              //   Marker(
              //     markerId: MarkerId("source"),
              //     position: LatLng(_locationData?.latitude ?? 17.4704313,
              //         _locationData?.longitude ?? 78.7232736),
              //   ),
              // },
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
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.white54,
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Accept Request",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          // side: BorderSide(color: Colors.red)
                        )),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue))
              // style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Container(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            // side: BorderSide(color: Colors.red)
                          )),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pinkAccent)),
                  child: Text(
                    "Inform the Hospital about patient vitals",
                    style: TextStyle(color: Colors.white),
                  ))),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}