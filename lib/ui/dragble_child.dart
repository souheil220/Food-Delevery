import 'package:flutter/material.dart';
import 'item_content.dart';
import 'list_of_food.dart';

class DragbleChild extends StatelessWidget {
  const DragbleChild({
    Key key,
    @required this.listOfFood,
  }) : super(key: key);

  final ListOfFood listOfFood;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(listOfFood:listOfFood),
    );
  }
}
