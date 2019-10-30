import 'package:flutter/material.dart';

import 'items.dart';


class ItemContainer extends StatelessWidget {
   var restaurant;
  ItemContainer({this.restaurant});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Items(
        imgUrl : restaurant['image'],
        name : restaurant['nom'], 
        leftAligned: (restaurant['id'] % 2 == 0) ? true : false
      ),
    );
  }
}
