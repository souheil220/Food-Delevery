import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/services/database.dart';
import 'package:hello_world/ui/empty_scaffild.dart';
import 'package:hello_world/ui/item_container.dart';
import 'package:hello_world/ui/item_content.dart';

class MyOrder extends StatefulWidget {
  var amount;
  var listOfFoods;
  var ido;
  MyOrder(this.amount, this.listOfFoods, this.ido);
  static const TextStyle planetTitle = const TextStyle(
      color: Color(0xFFFFFFFF),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 24.0);
  static const TextStyle planetLocation = const TextStyle(
      color: Color(0x66FFFFFF),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 14.0);

  var _height = 100.0;
  var _alignement = Alignment.bottomLeft;
  var topp = 0.0;
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(EmptyScaffold.photR == null
                ? ItemContainer.photo
                : EmptyScaffold.photR),
          ),
        ),
      ),
    );

    final planetCard = new Container(
      margin: const EdgeInsets.only(left: 24.0, right: 24.0),
      decoration: new BoxDecoration(
        color: Color(0xFF8685E5),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.only(top: widget.topp),
        child: Container(
          margin: EdgeInsets.only(
            top: 10.0,
            left: 78.0,
          ),
          constraints: new BoxConstraints.expand(),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                  EmptyScaffold.nomR == null
                      ? ItemContainer.nom
                      : EmptyScaffold.nomR,
                  style: MyOrder.planetTitle),
              new Text('Cost : ' + widget.amount.toString(),
                  style: MyOrder.planetLocation),
              new Container(
                  color: const Color(0xFF00C6FF),
                  width: 24.0,
                  height: 1.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0)),
              new Row(
                children: <Widget>[
                  new Icon(Icons.location_on,
                      size: 14.0, color: Color(0x66FFFFFF)),
                  // new Text(order.etat, style: MyOrder.planetDistance),
                  new Container(width: 24.0),
                  new Icon(Icons.flight_land,
                      size: 14.0, color: Color(0x66FFFFFF)),
                  new Container(width: 24.0),
                  StreamBuilder(
                    stream: DatabaseService(uid: '1').getEtat(widget.ido),
                    builder: (context, snapshot) {
                      DocumentSnapshot dat = snapshot.data;
                      return Flexible(
                        child: Container(
                          child:
                              dat.exists ? prise(snapshot.data) : nonPrise(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    final maCommande = Container(
      margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 200.0),
      child: foodItemList(),
    );

    return new Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds: 1),
            height: widget._height,
            child: FlatButton(
              onPressed: () {
                animateContainer();
              },
              child: new Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: planetCard,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: widget._height > 100 ? maCommande : Container()),
                  AnimatedContainer(
                      duration: Duration(seconds: 1),
                      alignment: widget._alignement,
                      child: planetThumbnail),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  animateContainer() {
    setState(() {
      widget._height = widget._height == 100.0 ? 450 : 100.0;
      widget._alignement = widget._alignement == Alignment.bottomLeft
          ? Alignment.topCenter
          : Alignment.bottomLeft;
      widget.topp = widget.topp == 0.0 ? 100.0 : 0.0;
    });
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: widget.listOfFoods.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemContent(
            listOfFood: widget.listOfFoods[index],
          ),
        );
      },
    );
  }

  Text prise(var result) {
    return Text(
      result["Etat"].toString(),
      style: TextStyle(
        color: Colors.green,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
      ),
    );
  }

  Text nonPrise() {
    return Text(
      "Waiting",
      style: TextStyle(
        color: Colors.red,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
      ),
    );
  }
}
