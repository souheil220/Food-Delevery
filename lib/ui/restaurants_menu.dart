import 'package:flutter/material.dart';

class RestaurantsMenu extends StatefulWidget {
  var result;

  RestaurantsMenu({this.result});

  @override
  _RestaurantsMenuState createState() => _RestaurantsMenuState(result);
}

class _RestaurantsMenuState extends State<RestaurantsMenu> {
  var result;
  var identifier = new Map();
  @override
  void initState() {
    super.initState();
    print(identifier.runtimeType);
    result.then((rep) {
      identifier = rep;
    });
    print(identifier.runtimeType);
  }

  _RestaurantsMenuState(this.result);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Text('${identifier['Plat']['Plat Escalope']}')
      ],
    ));
  }
}
