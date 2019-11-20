import 'package:flutter/material.dart';
import 'package:hello_world/ui/cart_body.dart';
import 'package:hello_world/ui/list_of_food.dart';
import 'package:hello_world/ui/restaurants_menu.dart';

class BottomBar extends StatefulWidget {
  final List<ListOfFood> listOfFoods;

  BottomBar(this.listOfFoods);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  RestaurantsMenu restau = RestaurantsMenu();
  var totalamount = CartBody.totalAmount;
  var totalamount2 = RestaurantsMenu.deleveryPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(widget.listOfFoods),
          Divider(
            height: 1,
          ),
          nextButtonBar(),
        ],
      ),
    );
  }

  Container nextButtonBar() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color(0xfffeb324),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Passer la Commande !",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Container totalAmount(List<ListOfFood> listOfFood) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            "Total : ",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          ),
          Text(
            "DA ${widget.listOfFoods.length > 0 ?returnTotalAmount(widget.listOfFoods):0}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }

  String returnTotalAmount(List<ListOfFood> listOfFoods) {
    double totalAmount = totalamount2;
    for (int i = 0; i < listOfFoods.length; i++) {
      totalAmount = totalAmount + listOfFoods[i].prix * listOfFoods[i].quantity;
    }
    return totalAmount.toStringAsFixed(0);
  }
}
