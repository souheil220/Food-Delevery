import 'package:flutter/material.dart';
import 'login_page.dart';
import 'delv_home.dart';

class LoginRegisterDelev extends StatelessWidget {
   static const String id = 'Login-Page-Delev';
  const LoginRegisterDelev({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginPage(DeleveryHomePage.id,'Deliverer'),
    );
  }
}