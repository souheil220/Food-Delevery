import 'package:flutter/material.dart';
const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class MyMap extends StatefulWidget {
  static const String id = "my-map";

  var order;
  var myLocation;
  MyMap(this.order, this.myLocation);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
 

 
  @override
  void initState() {

    super.initState();
  }


 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
    );
  }

}
