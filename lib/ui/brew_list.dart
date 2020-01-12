import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/services/currentLocation.dart';
import 'package:provider/provider.dart';
import 'my_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class BrewList extends StatefulWidget {
  static var currentLocation;
  static var lat;
  static var long;

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  bool _allowed = false;
  PermissionStatus _status;
  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    _askForPermission();

    super.initState();
    _messaging.getToken().then((onValue) {
      // print(onValue);
    });
  }

  _askForPermission() {
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location)
        .then(_updateStatus);

    if (_status == PermissionStatus.unknown ||
        _status == PermissionStatus.denied ||
        _status == null) {
      _askPermissoon();
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<QuerySnapshot>(context);
    return _allowed
        ? ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              if (orders == null)
                Text('no order made')
              else
                for (var order in orders.documents) MyCard(order.data),
            ],
          )
        : CircularProgressIndicator();
  }

  void _askPermissoon() {
    PermissionHandler().requestPermissions([PermissionGroup.location]).then(
        _onStatusRequested);
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
        if (_status == PermissionStatus.granted) {
          _allowed = true;
          try {
            BrewList.currentLocation = CurrentLocation().getLocation();
            BrewList.currentLocation.then((value) {
               BrewList.lat = value.latitude ;
            BrewList.long = value.longitude;
            });
          } catch (e) {
            print(e);
          }
        }
      });
    }
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
  }
}
