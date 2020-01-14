import 'package:flutter/material.dart';
import 'package:hello_world/ui/bottum_navigation_bar.dart';
import 'package:hello_world/ui/login_page.dart';

class LoginRegisterUser extends StatelessWidget {
  static const String id = 'Login-Register-user';
  const LoginRegisterUser({Key key}) : super(key: key);

   static const Color loginGradientStart = const Color(0xFFfbab61);
  static const Color loginGradientEnd = const Color(0xFFf7418c);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginPage(BottomNavigationBarre.id,'Consumer',loginGradientStart,loginGradientEnd),
    );
  }
}