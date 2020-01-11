import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  static const String id = "my-map";
  var myLocation;
  MyMap(this.myLocation);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController _controller;
  var _long;
  var _lat;
  @override
  void initState() {
    print(widget.myLocation);
    super.initState();
  }

  /* @override
  void initState() {
    var curr = BrewList.currentLocation;

    curr.then((value) {
      print(value);
      _long = value['Long'];
      _lat = value['Lat'];
    });
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition:
            CameraPosition(target: LatLng(40.6782, -73.9442), zoom: 14.0),
        mapType: MapType.normal,
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }
}
