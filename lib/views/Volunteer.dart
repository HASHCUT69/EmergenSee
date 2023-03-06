import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



class volunteerView extends StatefulWidget {
  @override
  State<volunteerView> createState() => _MyAppState();
}

class _MyAppState extends State<volunteerView> {
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
                height: 40,
                color: Colors.white38,
                alignment: Alignment.center,
                child: Text(
                  'Welcome Volunteer',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),

              ),
              Container(
                height: 40,

                color: Colors.pink,
                alignment: Alignment.center,
                child: Text(
                  "Ambulance is arriving on your route"
                  ,style: TextStyle(color:Colors.white),
                ),
              ),
              Expanded (
                child :GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0.0, 0.0),
                    zoom: 14.0,
                  ),
                  // markers: {
                  //   Marker(
                  //     markerId: MarkerId("source"),
                  //     position: LatLng(_locationData?.latitude ?? 17.4704313, _locationData?.longitude ?? 78.7232736),
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
              SizedBox(height:20),
              Container(
                height: 40,
                color: Colors.white38,
                alignment: Alignment.center,
                child:
                Row(mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () {
                          // Handle like button press
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.thumb_down),
                        onPressed: () {
                          // Handle dislike button press
                        },
                      ),
                      Text("Recommend this route or not?")
                    ]),
              )


              ,
              SizedBox(height: 20,),
              Container(
                  height: 60,
                  color: Colors.red,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child:ElevatedButton(
                    onPressed: (){},
                    child: Text("Alert the Driver")
                    ,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)
                    ),
                  )
              ),
            ]
        ),
      ),
    );
  }
}