import 'package:flutter/material.dart';
import 'package:hello_world/ui/empty_scaffild.dart';

class NoInternet extends StatelessWidget {
  static const String id = 'no_internet';
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/img/wifi.png'),
              height: 150,
              width: 150,
            ),
            RaisedButton(
              child: Text('Reesseyer'),
              onPressed: () =>
                  Navigator.of(context).pushNamed(EmptyScaffold.id),
            )
          ],
        ),
      ),
    );
  }
}
