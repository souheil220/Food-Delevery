import 'package:flutter/material.dart';
import 'package:hello_world/services/location_test.dart';
import 'package:hello_world/ui/empty_scaffild.dart';
import 'package:hello_world/ui/home.dart';
import 'package:hello_world/ui/no_order.dart';
import 'package:hello_world/ui/order_list.dart';
import 'package:hello_world/ui/profile.dart';

import '../services/connection.dart';
import 'gps_not_enabled.dart';
import 'no_internet.dart';

class BottomNavigationBarre extends StatefulWidget {
  static const String id = 'bottom-bar';

  BottomNavigationBarre();
  @override
  _BottomNavigationBarreState createState() => _BottomNavigationBarreState();
}

class _BottomNavigationBarreState extends State<BottomNavigationBarre> {
bool _connected = true;
bool gpsEnable = false;
  _checkIfGpsIsEnabled()async{
      await LocationTest().checkLocation().then((value){
        setState(() {
           gpsEnable = value;
        });
        if(!gpsEnable){
          Navigator.of(context).pushReplacementNamed(GpsNotEnabled.id);
        }
    });
  }
  
  _chek() async {
    await Connection().checkInternetConnectivity().then((e) {
      _connected = e;
    });
    setState(() {
      var con = _connected;
      if (con == false) {
        Navigator.of(context).pushReplacementNamed(NoInternet.id);
      }
    });
  }
  @override
  void initState() {
    _checkIfGpsIsEnabled();
    _chek();
    super.initState();
  }
  var amount, ido;

  int _currentIndex = 1;

  static widgetReturned() {
    print(EmptyScaffold.list3);
    if (EmptyScaffold.list3.isEmpty) {
      return NoOrder();
    } else {
      for (var i in EmptyScaffold.list3) return OrderList(i);
    }
  }

  final List<Widget> _children = [
    Profile(),
    Home(),
    widgetReturned(),
  ];
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profil"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text("Orders"),
          ),
        ],
      ),
    );
  }
}
