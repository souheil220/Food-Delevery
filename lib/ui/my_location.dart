import 'package:flutter/material.dart';
import 'package:hello_world/ui/my_map.dart';

class MyLocation extends StatefulWidget {
  var myLocation;
  var order;
  MyLocation(this.myLocation,this.order);
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {

  @override
  Widget build(BuildContext context) {
   
    return IconButton(
      icon: Icon(Icons.location_on),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MyMap(widget.order)));
      },
    );
  }
}
