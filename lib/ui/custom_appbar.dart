import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/list_of_food.dart';
import '../bloc/cartListBloc.dart';
import 'cart.dart';

class CustomAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.arrow_back),
            StreamBuilder(
              stream: bloc.listStream,
              builder: (context, snapshot) {
                List<ListOfFood> listOfFood = snapshot.data;
                int length = listOfFood != null ? listOfFood.length : 0;
                return buildGestureDetector(length, context, listOfFood);
              },
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<ListOfFood> listOfFood) {
    return GestureDetector(
      onTap: () {
        if (length > 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: Text(length.toString()),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
