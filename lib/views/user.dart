import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:responsive_login_ui/views/Confirm.dart';


class MyApp3 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp3> {
  late GoogleMapController _mapController;
  LocationData? _locationData;
  // LatLng? sourceLocation;
  // BitmapDescriptor? sourceIcon;
  // BitmapDescriptor? destinationIcon;

  @override
  void initState() {
    super.initState();
    _getLocation();
    // setSourceAndDestinationIcons();
  }
  // void setSourceAndDestinationIcons() async {
  //   sourceIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(size: Size(48,48)), 'assets/pic1.jpg');
  //
  //   destinationIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(size: Size(48,48)), 'assets/logo.png');
  // }

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
                  'Welcome User',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),

              ),
              Container(
                height: 40,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text(
                  "Nearest ambulance 10 min Away"
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
                  //     // icon: sourceIcon!,
                  //   ),
                  //   Marker(
                  //     markerId: MarkerId("destination"),
                  //     position: LatLng(_locationData?.latitude ?? 18.4704313, _locationData?.longitude ?? 79.7232736),
                  //     // icon: destinationIcon!,
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
                  height:40,

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
                      child:Text("Specify any requirement",style: TextStyle(color: Colors.white),)
                  )
              ),
              SizedBox(height: 20,),
              Container(
                height: 80,
                color: Colors.blue,
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp2()));
                      },
                    child: Text("Book Nearest Ambulance"),
                    style : ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red)
                            )
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red))
                  // style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
