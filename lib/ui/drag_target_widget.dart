import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/bloc/cartListBloc.dart';
import 'package:hello_world/bloc/listTileColorBloc.dart';
import 'package:hello_world/ui/list_of_food.dart';

class DragTargetWidget extends StatefulWidget {
  DragTargetWidget({Key key}) : super(key: key);

  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  final CartListBloc listBloc = BlocProvider.getBloc<CartListBloc>();
  final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DragTarget<ListOfFood>(
        onWillAccept: (ListOfFood listOfFood) {
          colorBloc.setColor(Colors.red);
          return true;
        },
        onAccept: (ListOfFood listOfFood) {
          listBloc.removeFromList(listOfFood);
          colorBloc.setColor(Colors.white);
        },
        onLeave: (ListOfFood listOfFood) {
          colorBloc.setColor(Colors.white);
        },
        builder: (context, incoming, regected) {
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              CupertinoIcons.delete,
              size: 35,
            ),
          );
        },
      ),
    );
  }
}
