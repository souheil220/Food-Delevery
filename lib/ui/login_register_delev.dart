import 'package:flutter/material.dart';
import 'package:hello_world/ui/login_register_user.dart';
import 'package:hello_world/ui/page_view_widget.dart';
import 'login_page.dart';
import 'delv_home.dart';

class LoginRegisterDelev extends StatefulWidget {
  static const String id = 'Login-Page-Delev';
  const LoginRegisterDelev({Key key}) : super(key: key);
  static const Color loginGradientStart = const Color(0xFF00ab61);
  static const Color loginGradientEnd = const Color(0xFFf7418c);
  static double opacity = 1;

  @override
  _LoginRegisterDelevState createState() => _LoginRegisterDelevState();
}

class _LoginRegisterDelevState extends State<LoginRegisterDelev> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: LoginPage(DeleveryHomePage.id, 'Deliverer', LoginRegisterDelev.loginGradientStart,
              LoginRegisterDelev.loginGradientEnd,'delivere'),
        ),
        Positioned(
          right: 5,
          top: 30,
          child: AnimatedOpacity(
opacity: LoginRegisterDelev.opacity,
 duration: Duration(microseconds: 10),
                      child: FloatingActionButton(
              child: Icon(Icons.arrow_forward),
              onPressed: () {
                if ((PageViewWidget.controler).hasClients) {
                  setState(() {
                      LoginRegisterUser.opacity=1;
                LoginRegisterDelev.opacity =0;
                  });
                  PageViewWidget.controler.animateToPage(
                    1,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut
                  );
                }
              
              },
            ),
          ),
        ),
      ],
    );
  }
}
