import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  static const String id = 'Profile-Page';
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("your profile Page"),
      ),
    );
  }
}
