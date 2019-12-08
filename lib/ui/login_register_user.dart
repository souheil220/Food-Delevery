import 'package:flutter/material.dart';
import 'package:hello_world/ui/login_page.dart';
import 'home.dart';
//import 'login_page_delev.dart';

class LoginRegisterUser extends StatelessWidget {
  static const String id = 'Login-Register-user';
  const LoginRegisterUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginPage(Home.id,'Consumer'),
    );
  }
}