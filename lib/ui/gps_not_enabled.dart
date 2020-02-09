import 'package:flutter/material.dart';
import 'package:hello_world/ui/empty_scaffild.dart';

class GpsNotEnabled extends StatelessWidget {
  static const String id = 'gps-detection';
  const GpsNotEnabled({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
        Text("Please Enable your Position (GPS) and Reload!"),
        RaisedButton(child: Text('Reload'),onPressed: (){
              Navigator.of(context).pushReplacementNamed(EmptyScaffold.id);
        },)
      ],),),
    );
  }
}