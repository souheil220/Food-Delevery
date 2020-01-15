import 'package:flutter/material.dart';
import 'package:hello_world/ui/bottum_navigation_bar.dart';
import 'package:hello_world/ui/login_page.dart';
import 'package:hello_world/ui/login_register_delev.dart';
import 'package:hello_world/ui/page_view_widget.dart';

class LoginRegisterUser extends StatefulWidget {
  static const String id = 'Login-Register-user';
  const LoginRegisterUser({Key key}) : super(key: key);

  static const Color loginGradientStart = const Color(0xFFfbab61);
  static const Color loginGradientEnd = const Color(0xFFf7418c);
  static double opacity = 1;

  @override
  _LoginRegisterUserState createState() => _LoginRegisterUserState();
}

class _LoginRegisterUserState extends State<LoginRegisterUser> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: LoginPage(BottomNavigationBarre.id, 'Consumer',
              LoginRegisterUser.loginGradientStart, LoginRegisterUser.loginGradientEnd),
        ),
        Positioned(
          top: 30,
          left: 5,
          child: AnimatedOpacity(
            child: FloatingActionButton(
              child: Icon(Icons.arrow_back),
              onPressed: () {
                if ((PageViewWidget.controler).hasClients) {
                  setState(() {
                    LoginRegisterUser.opacity = 0;
                    LoginRegisterDelev.opacity = 1;
                  });
                  
                  
                  PageViewWidget.controler.animateToPage(0,
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                }
              },
            ),
            opacity: LoginRegisterUser.opacity,
            duration: Duration(microseconds: 10),
          ),
        ),
      ],
    );
  }
}
