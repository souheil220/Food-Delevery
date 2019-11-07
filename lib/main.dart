import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'bloc/cartListBloc.dart';
import 'ui/home.dart';
import 'ui/restaurants_menu.dart';
import 'ui/login_page.dart';
import 'bloc/listTileColorBloc.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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
        initialRoute: LoginPage.id,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          Home.id: (context) => Home(),
          '/restaurant-menu': (context) => RestaurantsMenu(),
        },
      ),
    );
  }
}
