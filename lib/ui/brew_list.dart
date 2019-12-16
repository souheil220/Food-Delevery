import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'my_card.dart';

class BrewList extends StatefulWidget {
  BrewList({Key key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<QuerySnapshot>(context);
  return ListView(
      children: <Widget>[
        SizedBox(height: 10,),
        if (orders == null)
          Text('no order made')
        else
          for (var order in orders.documents)
               MyCard(order.data,order.documentID),
      ],
    );
  }
}
