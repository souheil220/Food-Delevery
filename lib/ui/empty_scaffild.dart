import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_world/services/memory_storage.dart';
import 'package:hello_world/ui/delv_home.dart';
import 'package:hello_world/ui/list_of_food.dart';
import 'package:hello_world/ui/order_information_conf.dart';
import 'package:hello_world/ui/page_view_widget.dart';
import 'package:flutter/scheduler.dart';
import 'package:hello_world/ui/profile.dart';
import '../fonctions/return_total_amount.dart';
import 'bottum_navigation_bar.dart';
import 'home.dart';
import 'order_list.dart';

class EmptyScaffold extends StatefulWidget {
  static const String id = 'Empty-Scaffold';
  EmptyScaffold({Key key}) : super(key: key);
  static Directory dir;
  static File jsonFile1;
  static bool existing;
  static List listing;
  static String ido;
  static String amount;
  static String photR;
  static String nomR;
  static var totalamount;
  static var totalamount2;
  @override
  _EmptyScaffoldState createState() => _EmptyScaffoldState();
}

class _EmptyScaffoldState extends State<EmptyScaffold> {
  verifying(BuildContext context) async {
    var exist;
    exist = await MemoryStorage().getLocalPath();
    
    setState(() {
      EmptyScaffold.dir = exist[1];
      EmptyScaffold.jsonFile1 = exist[0];
      EmptyScaffold.existing = exist[2];
    });
    print(exist);
    if (exist[2]) {
      if (exist[3]['type'] == 'Deliverer') {
        if (exist[3]['order'] != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => OrderInformationConf(
                    exist[3]['order'], exist[3]['order']['id'],exist[3]['myLocation']),
              ),
            );
          });
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(DeleveryHomePage.id);
          });
        }
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if(exist[3]["order"]!=null){
              setState(() {
            EmptyScaffold.listing = myOldListOfFood(exist[3]["order"]);
            EmptyScaffold.ido = exist[3]["id"];
            EmptyScaffold.totalamount = exist[3]["totalamount"];
            EmptyScaffold.totalamount2 = exist[3]["totalamount2"];
            EmptyScaffold.photR = exist[3]["photoR"];
            EmptyScaffold.nomR = exist[3]["nomR"];
            EmptyScaffold.amount = ReturnTotalAmount().returnTotalAmount(
              EmptyScaffold.listing,
              EmptyScaffold.totalamount,
              EmptyScaffold.totalamount2,
            );
          });
          }
        
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigationBarre(),
          ));
        });
      }
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(PageViewWidget.id);
      });
    }
  }

  static var amount, ido, listOfFoods;

  

  @override
  void initState() {
    verifying(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }

  List<ListOfFood> myOldListOfFood(var order) {
    List<ListOfFood> lista = [];
    ListOfFood list;
    var cle = order.keys;
    for (var i in cle) {
      list = ListOfFood(
        id: order[i]["id"],
        nom: order[i]["nom"],
        image: order[i]["image"],
        prix: order[i]["prix"],
        quantity: order[i]["quantity"],
      );
      lista.add(list);
    }
    return lista;
  }
}
