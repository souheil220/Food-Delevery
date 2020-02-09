import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/cart_incon.dart';
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
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
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
      child: CartIcon(length),
    );
  }
}
