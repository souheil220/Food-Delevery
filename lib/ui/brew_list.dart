import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/functions/ask_permission.dart';
import 'package:hello_world/services/currentLocation.dart';
import 'package:hello_world/ui/no_order.dart';
import 'package:provider/provider.dart';
import 'my_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class BrewList extends StatefulWidget {
  static var currentLocation;
  static var lat;
  static var long;

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  var _permission;
  bool _allowed = false;
  final FirebaseMessaging _messaging = FirebaseMessaging();

  askUserPermission() async {
    _permission = await AskPermission().askForPermission();

    setState(() {
      _allowed = _permission;
      if (_allowed) {
        try {
          BrewList.currentLocation = CurrentLocation().getLocation();
          BrewList.currentLocation.then((value) {
            BrewList.lat = value.latitude;
            BrewList.long = value.longitude;
          
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }

  @override
  void initState() {
    askUserPermission();

    super.initState();
    _messaging.getToken().then((onValue) {
      // print(onValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<QuerySnapshot>(context);

    return _allowed
        ? Scaffold(
            body: Center(
              child: Container(
                child: orders == null
                    ? NoOrder()
                    : (orders.documents.isEmpty)
                        ? NoOrder()
                        : ListView(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              for (var order in orders.documents)
                                MyCard(order.data),
                            ],
                          ),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
