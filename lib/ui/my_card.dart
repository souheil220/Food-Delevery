import 'package:flutter/material.dart';
import '../services/database.dart';
import 'package:hello_world/ui/order_information_conf.dart';

class MyCard extends StatelessWidget {
  var order;
  var orderId;

  MyCard(this.order, this.orderId);

  @override
  Widget build(BuildContext context) {
    print(order);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Hero(
            tag: (order['id']).toString(),
            child: test(context, (order['photo']), Text(order['name']),
                Text('Bénéfice : ${order['Total']}')),
          )
          //SizedBox(height: 10,)
        ],
      ),
    );
  }

  Widget test(
    BuildContext context,
    String image,
    Text text,
    Text text1,
  ) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(image),
                    //image: image,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 72.0, right: 24.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  color: Color(0xFF8685E5),
                ),
                child: Column(
                  children: <Widget>[
                    text,
                    text1,
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.check),
                textColor: Colors.green,
                onPressed: () {
                  DatabaseService(uid: '1').deleteData(order['id']);
                  DatabaseService(uid: '1').orderTaken(order['id']);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          OrderInformationConf(order, order['id']),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
