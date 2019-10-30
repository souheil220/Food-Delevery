import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'items.dart';

class ItemContainer extends StatelessWidget {
  final databaseReference = Firestore();
  var restaurant;
  ItemContainer({this.restaurant});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getData();
      },
      child: Items(
          imgUrl: restaurant['image'],
          name: restaurant['nom'],
          leftAligned: (restaurant['id'] % 2 == 0) ? true : false),
    );
  }

  void getData() async{
Firestore.instance.collection('restaurant').document('${restaurant['nom']}')
.get().then((DocumentSnapshot) =>
      print(DocumentSnapshot.data.toString())
);
}
}
