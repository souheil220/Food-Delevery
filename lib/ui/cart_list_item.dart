import 'package:flutter/material.dart';
import 'package:hello_world/ui/list_of_food.dart';
import 'dragble_child.dart';
import 'dragble_child_feedback.dart';

class CartListItem extends StatelessWidget {
  final ListOfFood listOfFood;
  CartListItem({@required this.listOfFood});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: listOfFood,
      maxSimultaneousDrags: 1,
      child: new DragbleChild(listOfFood: listOfFood),
      feedback: DragbleChildFeedBack(listOfFood: listOfFood,),
      childWhenDragging: listOfFood.quantity > 1 ? DragbleChild(listOfFood: listOfFood,) : Container(),
    );
  }
}
