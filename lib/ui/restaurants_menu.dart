import 'package:flutter/material.dart';
import 'package:hello_world/ui/food_show_case.dart';
import 'custom_appbar.dart';

class RestaurantsMenu extends StatefulWidget {
  var result;

  RestaurantsMenu({this.result});

  @override
  _RestaurantsMenuState createState() => _RestaurantsMenuState(result);
}

class _RestaurantsMenuState extends State<RestaurantsMenu> {
  var result;
  var identifier = new Map();

  @override
  void initState() {
    super.initState();
    setState(() {
      result.then((rep) {
        identifier = rep;
       // print(identifier);
      });
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
            tab(identifier, identifier.keys.length),
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
                for (var tabu in map.keys) FoodShowCase(map: identifier,tabofnow: tabu,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
