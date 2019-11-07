import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/bloc/cartListBloc.dart';
import 'package:hello_world/ui/item_container.dart';
import 'package:hello_world/ui/list_of_food.dart';
import 'cart_list_item.dart';
import 'drag_target_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class CartBody extends StatefulWidget {
  final List<ListOfFood> listOfFood;
  static double totalAmount = 100.0;

  CartBody(this.listOfFood);

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  var name = int.parse(ItemContainer.name.toString());
  var long1;
  var lat1;
  var long2;
  var lat2;
  var _data;
  final databaseReference = FirebaseDatabase.instance.reference();

  void getData() async {
    await databaseReference.once().then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');

      _data = snapshot.value[name];
      lat1 = _data["Lat"];
      long1 = _data["Long:"];
      
      
    });
  }
  //ToDo try to get the lat1 and etc 
  @override
  void initState() {
    getData();
    print(lat1);
    super.initState();
    getLocation().then((rep) {
      setState(() {
        lat2 = rep.latitude;
        long2 = rep.longitude;
      
      });
    });

    if (lat1 == null || long1 == null || lat2 == null || long2 == null) {
      print("cant do anything");
    } else {
      getDistance(lat1, long1, lat2, long2).then((rep) {
        print(rep);
      });
    }
    // print(getDistance(lat1, long1, lat2, long2));
  }

  Future getDistance(plac1Lat, place1long, plac2Lat, place2long) async {
    double distanceInMeters = await Geolocator()
        .distanceBetween(plac1Lat, place1long, plac2Lat, place2long);
    return distanceInMeters;
  }

  Future getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return (position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustumAppBar(),
          title(),
          Expanded(
            flex: 1,
            child: widget.listOfFood.length > 0
                ? foodItemList()
                : noItemContaner(),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image: AssetImage('assets/img/delevry_guy.jpg'),
                width: 80.0,
                height: 100.0,
              ),
              Text("Delevery Price"),
              Text("DA ${CartBody.totalAmount.toString()}"),
            ],
          )),
        ],
      ),
    );
  }

  Container noItemContaner() {
    return Container(
      child: Center(
        child: Text(
          "No Items Left in the Cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: widget.listOfFood.length,
      itemBuilder: (BuildContext context, int index) {
        return CartListItem(
          listOfFood: widget.listOfFood[index],
        );
      },
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "My",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 35,
            ),
          ),
          Text(
            "Order",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class CustumAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
              child: Icon(
                CupertinoIcons.back,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        DragTargetWidget(),
      ],
    );
  }
}
