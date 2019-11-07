import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/bloc/listTileColorBloc.dart';
import 'item_content.dart';
import 'list_of_food.dart';

class DragbleChildFeedBack extends StatelessWidget {
  const DragbleChildFeedBack({
    Key key,
    @required this.listOfFood,
  }) : super(key: key);

  final ListOfFood listOfFood;

  @override
  Widget build(BuildContext context) {
    final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();
    return Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder<Object>(
            stream: colorBloc.colorStream,
            builder: (context, snapshot) {
              return Container(
                margin: EdgeInsets.only(bottom: 25),
                child: ItemContent(listOfFood: listOfFood),
                decoration: BoxDecoration(
                  color: snapshot.data != null ? snapshot.data : Colors.white,
                ),
              );
            }),
      ),
    );
  }
}
