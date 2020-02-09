import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/functions/costum_snack.dart';
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
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
          key: _scaffoldKey,
          body: Container(
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
                      id: map[tabofnow][element]['id'],
                      nom: map[tabofnow][element]['nom'],
                      image: map[tabofnow][element]['image'],
                      prix: map[tabofnow][element]['prix'],
                    );

                    addToCart(listOfFood);
                    CustomSnack().showInSnackBar(context,'${listOfFood.nom} added to Cart', _scaffoldKey);
                   
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
