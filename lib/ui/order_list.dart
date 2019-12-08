import 'package:flutter/material.dart';
import 'package:hello_world/models/orders.dart';
import 'package:hello_world/ui/my_order.dart';

class OrderList extends StatelessWidget {
  Orders order = Orders(
    name:"Sandwich",
    etat: "En attente",
    prix: '250',
  );
  static final id = 'order-list-page';
  @override
  Widget build(BuildContext context) {
    return MyOrder(order);
  }
}
