import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'brew_list.dart';

class MyMap extends StatefulWidget {
  static const String id = "my-map";

  var order;
  MyMap(this.order);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final Set<Polyline> polyline = {};
  GoogleMapController _controller;
  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: 'AIzaSyAYpSEI59t0PhfjvcWgI3MkXl3P36Xqsbs');

  getSomePoints() async {
    print(BrewList.lat);
    print(BrewList.long);
    print(((widget.order)['location']['Latitude']));
    print(((widget.order)['location']['Longitude']));
    routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(BrewList.lat, BrewList.long),
        destination: LatLng(((widget.order)['location']['Latitude']),
            ((widget.order)['location']['Longitude'])),
        mode: RouteMode.driving);
  }

  @override
  void initState() {
    getSomePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: onMapCreated,
        polylines: polyline,
        initialCameraPosition: CameraPosition(
            target: LatLng(BrewList.lat, BrewList.long), zoom: 14.0),
        mapType: MapType.normal,
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }
}
