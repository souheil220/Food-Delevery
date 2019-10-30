import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'item_container.dart';

class Home extends StatefulWidget {
  static const String id = 'Home-Page';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showSpinner = true;
  var _data =[];
  final databaseReference = FirebaseDatabase.instance.reference();

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      setState(() {
        _data = snapshot.value;
        showSpinner = false;
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child:ListView(
          children: <Widget>[
            for(var restaurant in _data)
             ItemContainer(restaurant: restaurant,)
          ],
        )
      ),
    );
  }
}
