import 'package:flutter/material.dart';
class CustomSnack{
  CustomSnack();
  void showInSnackBar(BuildContext context,String value,GlobalKey<ScaffoldState> _scaffoldKey) {
  //  print(_scaffoldKey==null);
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue[900],
      duration: Duration(seconds: 3),
    ));
  }
}