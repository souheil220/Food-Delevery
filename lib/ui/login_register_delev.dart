import 'package:flutter/material.dart';
import 'login_page.dart';
import 'delv_home.dart';

class LoginRegisterDelev extends StatelessWidget {
   static const String id = 'Login-Page-Delev';
  const LoginRegisterDelev({Key key}) : super(key: key);
  static const Color loginGradientStart = const Color(0xFF00ab61);
  static const Color loginGradientEnd = const Color(0xFFf7418c);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginPage(DeleveryHomePage.id,'Deliverer',loginGradientStart,loginGradientEnd),
    );
  }
}