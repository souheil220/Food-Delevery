import 'package:flutter/material.dart';
import 'my_orders.dart';
import 'my_location.dart';

class MyCard extends StatelessWidget {
  var order;

  MyCard(this.order);

  @override
  Widget build(BuildContext context) {
    //RegExp re = new RegExp(r'[0-9]');

   // print(order);
    return Container(
      child: coolOrders(order, MyOrders(order),
          Text('Total : ${order['Total']}'), MyLocation()),
      /*decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 5.0, // has the effect of extending the shadow
            offset: Offset(
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          for (var ordre in (order.data.keys))
            if ((ordre.toString()) == 'order 0' ||
                (ordre.toString()) == 'order 1' )
              MyOrders(order.data[ordre.toString()])
            else if ((ordre.toString()) == 'Etat')
              Text(ordre + ":" + order.data[ordre].toString())
            else if ((ordre.toString()) == 'Total')
              Text(ordre + ":" + order.data[ordre].toString())
            else
              MyLocation(order.data[ordre.toString()]),
        ],
      ),*/
    );
  }

  Widget coolOrders(var order, Widget myorder, Text total, Widget location) {
    //String str1 = "order";

//Match str1Match = re.matchAsPrefix(str1);
    return Column(
      children: <Widget>[
        myorder,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            total,
            SizedBox(
              width: 20,
            ),
            location
          ],
        )
      ],
    );
  }

  String theKey(var order) {
    String thekey;
    RegExp re = new RegExp(r'order');
    for (var ordre in order.keys)
      if ((re.matchAsPrefix(ordre)) != null) {
        thekey = ordre.toString();
      }
    

    return thekey;
  }
}
