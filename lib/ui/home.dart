import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'item_container.dart';

class Home extends StatefulWidget {
  static const String id = 'Home-Page';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showSpinner = false;
  var _data = [];
  final databaseReference = FirebaseDatabase.instance.reference();

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      _data = snapshot.value;
      setState(() {
        showSpinner = true;
        print(showSpinner);
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showSpinner
          ? ListView(
              children: <Widget>[
                for (var restaurant in _data)
                  ItemContainer(
                    restaurant: restaurant,
                  )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
