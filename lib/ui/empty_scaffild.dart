import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_world/models/list_of_command.dart';
import 'package:hello_world/services/memory_storage.dart';
import 'package:hello_world/ui/delv_home.dart';
import 'package:hello_world/ui/list_of_food.dart';
import 'package:hello_world/ui/order_information_conf.dart';
import 'package:hello_world/ui/page_view_widget.dart';
import 'package:flutter/scheduler.dart';
import 'package:hello_world/functions/return_total_amount.dart';
import 'bottum_navigation_bar.dart';

class EmptyScaffold extends StatefulWidget {
  static const String id = 'Empty-Scaffold';
  EmptyScaffold({Key key}) : super(key: key);
  static Directory dir;
  static Directory userdir;
  static File jsonFile1;
  static File userjsonFile1;
  static bool existing;
  static bool userexisting;
  static List listing;
  static String ido;
  static String amount;
  static String photR;
  static String nomR;
  static var totalamount;
  static var totalamount2;
  static List list3 = [];

  @override
  _EmptyScaffoldState createState() => _EmptyScaffoldState();
}

class _EmptyScaffoldState extends State<EmptyScaffold> {
  verifying(BuildContext context) async {
    var exist;
    var userexist;
    exist = await MemoryStorage().getLocalPath("myJSONFile.json");
    userexist = await MemoryStorage().getLocalPath('userJSONFile.json');
  
    setState(() {
      //for user info
      EmptyScaffold.userexisting = userexist[2];
       EmptyScaffold.userdir = userexist[1];
      EmptyScaffold.userjsonFile1 = userexist[0];
     
      //for data
      EmptyScaffold.dir = exist[1];
      EmptyScaffold.jsonFile1 = exist[0];
      EmptyScaffold.existing = exist[2];
    });
 //   print(userexist);
   // print(exist[3]==null);

    if (userexist[2]) {
      if (userexist[3]['type'] == 'Deliverer') {
        if (exist[3] != null) {
        if (exist[3]['order'] != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => OrderInformationConf(
                    exist[3]['order'],
                    exist[3]['myLocation']),
              ),
            );
          });
        } }else {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(DeleveryHomePage.id);
          });
        }
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if((exist[3] != null)){
          if (exist[3]["My Food"] != null) {
            setState(() {
             EmptyScaffold.list3 = myFood(exist[3]["My Food"]);
            });
          }
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
    return Scaffold();
  }

  List myFood(var myfood) {
    ListOfCommand listOfCommand;
    RegExp re = new RegExp(r'commande');
    List _lista = [];
    List<ListOfFood> k = [];
    ListOfCommand l = ListOfCommand();
    for (var i in myfood.keys) {
      for (var j in myfood[i].keys) {
        if ((re.matchAsPrefix(j)) != null) {
          k.add(myOldListOfFood2(myfood[i][j]));
        }
      }
      listOfCommand = ListOfCommand(
        amount: ReturnTotalAmount().returnTotalAmount(
            k, myfood[i]["totalamount"], myfood[i]["totalamount2"]),
        ido: myfood[i]['id'],
        listOfFoods: k,
        nomr: myfood[i]["nomR"],
        photor: myfood[i]["photoR"]
      );
      var a = l.addCommade(listOfCommand);

      _lista.add(a);
      k = [];
      l.removeAll(a);
    }
    return _lista;
  }

  myOldListOfFood2(var myfoodij) {
    ListOfFood list;

    list = ListOfFood(
      id: myfoodij["id"],
      nom: myfoodij["nom"],
      image: myfoodij["image"],
      prix: myfoodij["prix"],
      quantity: myfoodij["quantity"],
    );

    return list;
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
