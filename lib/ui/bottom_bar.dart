import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/my_food.dart';
import '../bloc/cartListBloc.dart';
import '../models/list_of_command.dart';
import '../services/currentLocation.dart';
import '../models/commande.dart';
import '../services/database.dart';
import '../services/memory_storage.dart';
import 'cart_body.dart';
import 'empty_scaffild.dart';
import 'item_container.dart';
import 'list_of_food.dart';
import 'order_list.dart';
import 'restaurants_menu.dart';

class BottomBar extends StatefulWidget {
  List<ListOfFood> listOfFoods;
  ListOfCommand _listOfCommand = ListOfCommand();
  BottomBar(this.listOfFoods);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
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
                //   print(listoffood);
                try {
                  location = await getCurrentLocation;
                  var value = await DatabaseService(uid: '1').orderData(
                      ItemContainer.nom,
                      ItemContainer.photo,
                      listoffood,
                      location,
                      returnBenifice(widget.listOfFoods));

                  var map0 = {};
                  List _list3 = [];
                  ListOfCommand listOfCommand;
                  listOfCommand = ListOfCommand(
                      amount: returnTotalAmount(widget.listOfFoods),
                      listOfFoods: widget.listOfFoods,
                      ido: id,
                      photor: ItemContainer.photo,
                      nomr: ItemContainer.nom);
                  _list3 = widget._listOfCommand.addCommade(listOfCommand);
                  bloc.emptyAllList(widget.listOfFoods);

                  setState(() {
                    id = value;

                    List list0 = [];
                    List list1 = [];

                    //start of order
                    int j = 0;
                    for (var i in _list3) {
                      print(i.runtimeType);
                      list0.add(MyFood(i, "order $j"));
                      list1.add(i);
                      j++;
                    }

                    int i = 0;
                    print(list1[0].runtimeType);
                    list0.forEach((customer) {
                      map0[customer.commande] = ordrDetail(list1[i]);
                      i++;
                    });
                  });

                 
                  MemoryStorage().writeToFile(
                      {'My Food': map0},
                      EmptyScaffold.dir,
                      'myJSONFile.json',
                      EmptyScaffold.jsonFile1,
                      EmptyScaffold.existing);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => OrderList(_list3),
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

  var getCurrentLocation = CurrentLocation().getLocation();

  Map<dynamic, dynamic> newMap(var list) {
    var map1 = {};
    map1 = {
      'id': list.id,
      'nom': list.nom,
      'image': list.image,
      'prix': list.prix,
      'quantity': list.quantity,
    };

    return map1;
  }

  ordrDetail(ListOfCommand list) {
    List list2 = [];
    List list3 = [];
    var map2 = {};

    int j = 0;
    for (var i in list.listOfFoods) {
      list3.add(Commande(i, "commande $j"));
      list2.add(i);
      j++;
    }
    int i = 0;
    list3.forEach((customer) {
      map2[customer.commande] = newMap(list2[i]);
      i++;
    });
    map2['id'] = id;
    map2['totalamount'] = totalamount;
    map2['totalamount2'] = totalamount2;
    map2['nomR'] = ItemContainer.nom;
    map2['photoR'] = ItemContainer.photo;
    return map2;
  }
}
