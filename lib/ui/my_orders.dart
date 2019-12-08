import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  var order;
  MyOrders(this.order);
  @override
  Widget build(BuildContext context) {
    RegExp re = new RegExp(r'order');
    print(order.keys);
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          for (var cle in order.keys)
              if ((re.matchAsPrefix(cle)) != null)
               
                maCommande(cle,order)
        ],
      ),
    );
  }

  Widget maCommande(var cle,var order) {
    return Container(
      child: Row(
        children: <Widget>[
          Image(image: NetworkImage(order[cle.toString()]['image']),height: 100,),
          Column(children: <Widget>[
            Text(order[cle]['nom']),
            Text((order[cle]['quantite']).toString())
          ],)
        ],
      ),
    );
  }
}
