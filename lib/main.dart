import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/delv_home.dart';
import 'package:hello_world/ui/login_register_delev.dart';
import 'package:hello_world/ui/login_register_user.dart';
import 'package:hello_world/ui/order_list.dart';
import 'package:hello_world/ui/page_view_widget.dart';
import 'bloc/cartListBloc.dart';
import 'ui/home.dart';
import 'ui/restaurants_menu.dart';
import 'ui/login_page.dart';
import 'bloc/listTileColorBloc.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  var page;
  var typeOfUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => CartListBloc()),
        Bloc((i) => ColorBloc()),
      ],
      child: new MaterialApp(
        title: 'TheGorgeousLogin',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: PageViewWidget.id,
        routes: {
          OrderList.id:(context) =>OrderList(), 
          LoginRegisterUser.id: (context) => LoginRegisterUser(),
          LoginRegisterDelev.id: (context) => LoginRegisterDelev(),
          PageViewWidget.id: (context) => PageViewWidget(),
          DeleveryHomePage.id: (context) => DeleveryHomePage(),
          LoginPage.id: (context) => LoginPage(page,typeOfUser),
          Home.id: (context) => Home(),
          '/restaurant-menu': (context) => RestaurantsMenu(),
        },
      ),
    );
  }
}
