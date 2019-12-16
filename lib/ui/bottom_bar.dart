import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello_world/services/database.dart';
import 'package:hello_world/ui/cart_body.dart';
import 'package:hello_world/ui/item_container.dart';
import 'package:hello_world/ui/list_of_food.dart';
import 'package:hello_world/ui/order_list.dart';
import 'package:hello_world/ui/restaurants_menu.dart';

class BottomBar extends StatefulWidget {
  final List<ListOfFood> listOfFoods;

  BottomBar(this.listOfFoods);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var id;
  var location;
  RestaurantsMenu restau = RestaurantsMenu();
  var totalamount = CartBody.totalAmount;
  var totalamount2 = RestaurantsMenu.deleveryPrice;
  @override
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
      height: 60.0,
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xfffeb324),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
              child: Text(
                "Passer la Commande !",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              onPressed: () async {
                var listoffood = widget.listOfFoods;

                try {
                  location = await getLocation();
                  var value = await DatabaseService(uid: '1').orderData(
                      ItemContainer.nom,
                      ItemContainer.photo,
                      listoffood,
                      location,
                      returnBenifice(widget.listOfFoods));
                  
                    setState(() {
                      id = value;
                    });
                   
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => OrderList(
                          returnTotalAmount(widget.listOfFoods),
                          widget.listOfFoods,id),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              }),
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
            "DA ${widget.listOfFoods.length > 0 ? returnTotalAmount(widget.listOfFoods) : 0}",
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
    totalamount = totalamount2;

    for (int i = 0; i < listOfFoods.length; i++) {
      totalamount = totalamount + listOfFoods[i].prix * listOfFoods[i].quantity;
    }

    return totalamount.toStringAsFixed(0);
  }

  String returnBenifice(List<ListOfFood> listOfFoods) {
    double benefice = 0;
    setState(() {
      for (int i = 0; i < listOfFoods.length; i++) {
        benefice = benefice + listOfFoods[i].prix * listOfFoods[i].quantity;
      }
    });
    return (totalamount - benefice).toStringAsFixed(0);
  }

  Future getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    return (position);
  }
}
