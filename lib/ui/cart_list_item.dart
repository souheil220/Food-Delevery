import 'package:flutter/material.dart';
import 'package:hello_world/ui/list_of_food.dart';
import 'item_content.dart';

class CartListItem extends StatelessWidget {
  final ListOfFood listOfFood;
  CartListItem({@required this.listOfFood});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(listOfFood:listOfFood),
    );
  }
}
