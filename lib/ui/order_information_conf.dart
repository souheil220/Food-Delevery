import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/ui/chat.dart';

import 'my_location.dart';
import 'my_orders.dart';
import 'page_view_widget.dart';

class OrderInformationConf extends StatefulWidget {
  static const id = 'order-Info-after-confirm';
  var order;

  var myLocation;
  OrderInformationConf(this.order, this.myLocation);

  @override
  _OrderInformationConfState createState() => _OrderInformationConfState();
}

class _OrderInformationConfState extends State<OrderInformationConf> {
  @override
  Widget build(BuildContext context) {
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
                child: coolOrders(
                    MyOrders(widget.order),
                    Text('Bénéfice : ${widget.order['Total']}'),
                    MyLocation(widget.myLocation, widget.order)),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Container(
                    alignment: new FractionalOffset(0.0, 0.5),
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.order['photo'],
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

  Widget coolOrders(Widget myorder, Text total, Widget location) {
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
                location,
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    child: Icon(Icons.message),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Chat(peerId: widget.order['ConsumerId'], peerAvatar: null),
                        ),
                      );
                    }),
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
                  onPressed: () {
                    final AuthService _auth = AuthService();
                    _auth.logOut();
                    Navigator.of(context).pushNamed(PageViewWidget.id);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
