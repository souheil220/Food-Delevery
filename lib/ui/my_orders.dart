import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  var order;
  MyOrders(this.order);
  @override
  Widget build(BuildContext context) {
    RegExp re = new RegExp(r'order');
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          for (var cle in order.keys)
            if ((re.matchAsPrefix(cle)) != null) maCommande(cle, order)
        ],
      ),
    );
  }

  Widget maCommande(var cle, var order) {
    return Container(
      
      child: Row(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.all(5) ,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: NetworkImage(order[cle.toString()]['image']),
                fit: BoxFit.fitHeight,
                height: 55,
                width: 80,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(text: order[cle]['nom']),
                  TextSpan(text: " x "),
                  TextSpan(text: (order[cle]['quantite']).toString()),
                ]),
          )
        ],
      ),
    );
  }
}
