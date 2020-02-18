import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/bottum_navigation_bar.dart';
import 'package:hello_world/ui/chat.dart';
import 'package:hello_world/ui/chatScreen.dart';
import 'package:hello_world/ui/delv_home.dart';
import 'package:hello_world/ui/empty_scaffild.dart';
import 'package:hello_world/ui/gps_not_enabled.dart';
import 'package:hello_world/ui/login_register_delev.dart';
import 'package:hello_world/ui/login_register_user.dart';
import 'package:hello_world/ui/no_internet.dart';
import 'package:hello_world/ui/order_list.dart';
import 'package:hello_world/ui/page_view_widget.dart';
import 'package:hello_world/ui/profile.dart';
import 'bloc/cartListBloc.dart';
import 'ui/home.dart';
import 'ui/my_map.dart';
import 'ui/restaurants_menu.dart';
import 'ui/login_page.dart';
import 'bloc/listTileColorBloc.dart';
import 'ui/order_information_conf.dart';

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
        title: 'Delevery Food',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
       initialRoute: EmptyScaffold.id,
        
        routes: {
         ChatScreen.id :(context) => ChatScreen(peerAvatar: page,peerId: page,),
          '/chat':(context) => Chat(peerAvatar: null,peerId: null,),
          GpsNotEnabled.id:(context) => GpsNotEnabled(),
          Profile.id:(context) => Profile(),
          NoInternet.id:(context) => NoInternet(),
          MyMap.id:(context) => MyMap(page,page),
          '/Order-List': (context) => OrderList(page),
          '/order-after-conf': (context) => OrderInformationConf(page, page),
          LoginRegisterUser.id: (context) => LoginRegisterUser(),
          EmptyScaffold.id: (context) => EmptyScaffold(),
          LoginRegisterDelev.id: (context) => LoginRegisterDelev(),
          PageViewWidget.id: (context) => PageViewWidget(),
          DeleveryHomePage.id: (context) => DeleveryHomePage(),
          LoginPage.id: (context) => LoginPage(page, typeOfUser, page, page,page),
          Home.id: (context) => Home(),
          '/restaurant-menu': (context) => RestaurantsMenu(),
          BottomNavigationBarre.id: (context) => BottomNavigationBarre()
        },
       
      ),
    );
  }
}
