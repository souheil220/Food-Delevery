import 'package:flutter/material.dart';

import 'my_location.dart';
import 'my_orders.dart';

class OrderInformationConf extends StatelessWidget {
  static const id = 'order-Info-after-confirm';
  var order;
  var orid;
  OrderInformationConf(this.order, this.orid);
  @override
  Widget build(BuildContext context) {
    print(orid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 69),
                child: coolOrders(order, MyOrders(order),
                    Text('Bénéfice : ${order['Total']}'), MyLocation()),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Hero(
                    tag: orid.toString(),
                    child: Container(
                      alignment: new FractionalOffset(0.0, 0.5),
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            order['photo'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget coolOrders(var order, Widget myorder, Text total, Widget location) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
        alignment: new FractionalOffset(0.0, 0.5),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
            )),
        child: Column(
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Annuler la livraison ?",
                  style: TextStyle(color: Colors.red),
                ),
                FlatButton(
                  child: Icon(
                    Icons.close,
                  ),
                  textColor: Colors.red,
                  onPressed: () => {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
