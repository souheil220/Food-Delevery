import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/ui/page_view_widget.dart';

class Profile extends StatelessWidget {
  static const String id = 'Profile-Page';
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      body: Center(
        child: RaisedButton(child: Text("LOG OUT"), onPressed: (){
                _auth.logOut();
                Navigator.of(context).pushNamed(PageViewWidget.id);
        },),
      ),
    );
  }
}
