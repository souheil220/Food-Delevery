import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/ui/restaurants_menu.dart';
import 'restaurant.dart';

class ItemContainer extends StatelessWidget {
  final databaseReference = Firestore();
  var restaurant;
  ItemContainer({this.restaurant});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => RestaurantsMenu(
              result: getData(),
            ),
          ),
        );
      },
      child: Restauurant(
          imgUrl: restaurant['image'],
          name: restaurant['nom'],
          leftAligned: (restaurant['id'] % 2 == 0) ? true : false),
    );
  }

  Future<Map<String, dynamic>> getData() async {
    var result;
    await Firestore.instance
        .collection('restaurant')
        .document('${restaurant['nom']}')
        .get()
        .then((DocumentSnapshot snapshot) async {
      // print(DocumentSnapshot.data.toString());
       result = snapshot.data;
      //var name = result['Plat']['']['nom'];
      //print(result['Plat'].keys);
    });
   // print(result);
    return result;
  }
}
