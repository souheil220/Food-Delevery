import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/bloc/cartListBloc.dart';
import 'package:hello_world/ui/home.dart';
import 'package:hello_world/ui/restaurants_menu.dart';
import 'ui/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => CartListBloc()),
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
