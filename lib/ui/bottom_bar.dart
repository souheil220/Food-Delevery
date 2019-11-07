import 'package:flutter/material.dart';
import 'package:hello_world/ui/cart_body.dart';
import 'package:hello_world/ui/list_of_food.dart';

class BottomBar extends StatelessWidget {
  final List<ListOfFood> listOfFoods;
  var totalamount = CartBody.totalAmount;
  
  BottomBar(this.listOfFoods);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(listOfFoods),
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
            "DA ${returnTotalAmount(listOfFoods)}",
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
    double totalAmount = totalamount;
    for (int i = 0; i < listOfFoods.length; i++) {
      totalAmount = totalAmount + listOfFoods[i].prix * listOfFoods[i].quantity;
    }
    return totalAmount.toStringAsFixed(0);
  }
}
