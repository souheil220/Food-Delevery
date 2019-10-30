import 'package:flutter/material.dart';

class RestaurantsMenu extends StatefulWidget {
  RestaurantsMenu({Key key}) : super(key: key);

  @override
  _RestaurantsMenuState createState() => _RestaurantsMenuState();
}

class _RestaurantsMenuState extends State<RestaurantsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Text('hello'),
      ),
    );
  }
}
