import 'package:flutter/material.dart';
import 'package:hello_world/ui/food_show_case.dart';
import 'custom_appbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hello_world/ui/item_container.dart';

class RestaurantsMenu extends StatefulWidget {
  var result;
  static double deleveryPrice;
  static var location;

  RestaurantsMenu({this.result});

  @override
  _RestaurantsMenuState createState() => _RestaurantsMenuState(result);
}

class _RestaurantsMenuState extends State<RestaurantsMenu> {
  bool _loaded = false;

  var result;
  var identifier = new Map();

  Future getData() async {
    await result.then((rep) {
      identifier = rep;
      setState(() {
        _loaded = true;
      });
    });
  }

  var id = int.parse(ItemContainer.idr.toString());
  var long1;
  var lat1;
  var long2;
  var lat2;
  var _data;
  final databaseReference = FirebaseDatabase.instance.reference();
  double dist;
  Future getPosition() async {
    await databaseReference.once().then((DataSnapshot snapshot) {
      _data = snapshot.value[id];
      lat1 = _data["Lat"];
      long1 = _data["Long"];
    });
    await getLocation().then((rep) {
      lat2 = rep.latitude;
      long2 = rep.longitude;
    });

    await getDistance(lat1, long1, lat2, long2).then((rep) {
    //  print(rep);
      dist = rep;
    });
    setState(() {
      RestaurantsMenu.deleveryPrice = dist * 0.005;
    });
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
  void initState() {
    super.initState();
    getPosition();
    getData();
    setState(() {
       RestaurantsMenu.location = getLocation();
    });
   
  }

  _RestaurantsMenuState(this.result);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: ListView(
          children: <Widget>[
            CustomAppBar(),
            _loaded
                ? tab(identifier, identifier.keys.length)
                : CircularProgressIndicator(),
          ],
        ),
      ),
    ));
  }

  Widget tab(Map map, int longueur) {
    return SingleChildScrollView(
      child: Container(
        height: 560,
        width: double.infinity,
        child: DefaultTabController(
          initialIndex: 0,
          length: longueur,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(65),
                child: Container(
                  color: Colors.transparent,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TabBar(
                          isScrollable: true,
                          labelPadding: EdgeInsets.only(top: 15),
                          indicatorColor: Colors.transparent,
                          labelColor: Colors.black,
                          labelStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'slabo',
                          ),
                          unselectedLabelColor: Colors.black26,
                          unselectedLabelStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'slabo',
                          ),
                          tabs: <Widget>[
                            for (var elem in map.keys)
                              Container(
                                padding: EdgeInsets.only(left: 40),
                                child: Text(elem),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                for (var tabu in map.keys)
                  FoodShowCase(
                    map: identifier,
                    tabofnow: tabu,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
