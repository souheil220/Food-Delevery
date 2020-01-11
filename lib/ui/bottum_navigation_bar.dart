import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_world/ui/empty_scaffild.dart';
import 'package:hello_world/ui/home.dart';
import 'package:hello_world/ui/no_order.dart';
import 'package:hello_world/ui/order_list.dart';
import 'package:hello_world/ui/profile.dart';

class BottomNavigationBarre extends StatefulWidget {
  static const String id = 'bottom-bar';

  BottomNavigationBarre();
  @override
  _BottomNavigationBarreState createState() => _BottomNavigationBarreState();
}

class _BottomNavigationBarreState extends State<BottomNavigationBarre> {
  var amount, ido;

  int _currentIndex = 1;

  final List<Widget> _children = [
    Profile(),
    Home(),
   /* EmptyScaffold.listing == null
        ? NoOrder()
        : OrderList(
            EmptyScaffold.amount, EmptyScaffold.listing, EmptyScaffold.ido),*/NoOrder()
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
