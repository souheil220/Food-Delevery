import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../bloc/cartListBloc.dart';
import 'list_of_food.dart';
import 'cart_body.dart';
import 'bottom_bar.dart';

class Cart extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    List<ListOfFood> listOfFood;
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          listOfFood = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Container(child: CartBody(listOfFood)),
            ),
            bottomNavigationBar: BottomBar(listOfFood),
          );
       
        }   else{
            return Container();
          }
      },
    );
  }
}
