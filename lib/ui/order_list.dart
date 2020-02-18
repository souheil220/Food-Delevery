import 'package:flutter/material.dart';
import '../ui/my_order.dart';

class OrderList extends StatefulWidget {
  List _lista;
  OrderList(this._lista);
  
  static final id = 'order-list-page';

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          for (var i in widget._lista)
       
           MyOrder(i.amount, i.listOfFoods, i.ido,i.photor,i.nomr)
        ],
      ),
    );
  
  }
}
