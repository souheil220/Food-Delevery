import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';


class DeleveryHomePage extends StatelessWidget {
  static const String id = 'Home-Page-Delev';
  const DeleveryHomePage({Key key}) : super(key: key);
  @override
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().orders,
      child: Scaffold(
        body: BrewList(),
      ),
    );
  }
}
