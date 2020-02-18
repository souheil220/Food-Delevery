import 'package:flutter/material.dart';
import 'login_register_user.dart';
import 'login_register_delev.dart';

class PageViewWidget extends StatefulWidget {
  static const String id = 'Page-View';
  PageViewWidget({Key key}) : super(key: key);
  static var controler = PageController();
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: PageView(
        controller: PageViewWidget.controler,
        children: <Widget>[
          LoginRegisterDelev(),
          LoginRegisterUser(),
        ],
      ),
    );
  }
}
