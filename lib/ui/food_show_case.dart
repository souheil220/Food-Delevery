import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'list_of_food.dart';
import 'package:hello_world/bloc/cartListBloc.dart';

class FoodShowCase extends StatelessWidget {
  ListOfFood listOfFood;
  Map map;
  String tabofnow;
  FoodShowCase({@required this.map, @required this.tabofnow, this.listOfFood});

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(ListOfFood listOfFood) {
    bloc.addToList(listOfFood);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var element in map[tabofnow].keys)
            GestureDetector(
              child: ListOfFood(
                nom: map[tabofnow][element]['nom'],
                image: map[tabofnow][element]['image'],
                prix: map[tabofnow][element]['prix'],
                adding: () {
                  listOfFood = ListOfFood(
                    nom: map[tabofnow][element]['nom'],
                    image: map[tabofnow][element]['image'],
                    prix: map[tabofnow][element]['prix'],
                  );

                  addToCart(listOfFood);
                  final snackbar = SnackBar(
                    content: Text('${listOfFood.prix} added to Cart'),
                    duration: Duration(milliseconds: 550),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                  print(map[tabofnow][element]['nom'].runtimeType);
                },
              ),
            ),
        ],
      ),
    );
  }
}
