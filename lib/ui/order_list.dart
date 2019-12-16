import 'package:flutter/material.dart';
import 'package:hello_world/ui/my_order.dart';

class OrderList extends StatefulWidget {
  var amount;
  var listOfFoods;
  var ido;
  OrderList(this.amount, this.listOfFoods, this.ido);

  static final id = 'order-list-page';

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    
    return MyOrder(widget.amount, widget.listOfFoods,widget.ido);
  }
}
