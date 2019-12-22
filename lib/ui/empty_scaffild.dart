import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_world/services/memory_storage.dart';
import 'package:hello_world/ui/delv_home.dart';
import 'package:hello_world/ui/order_information_conf.dart';
import 'package:hello_world/ui/page_view_widget.dart';
import 'package:flutter/scheduler.dart';

import 'home.dart';

class EmptyScaffold extends StatefulWidget {
  static const String id = 'Empty-Scaffold';
  EmptyScaffold({Key key}) : super(key: key);
  static Directory dir;
  static File jsonFile1;
  static bool existing;
  @override
  _EmptyScaffoldState createState() => _EmptyScaffoldState();
}

class _EmptyScaffoldState extends State<EmptyScaffold> {
  verifying(BuildContext context) async {
    var exist;
    exist = await MemoryStorage().getLocalPath();
    setState(() {
      EmptyScaffold.dir = exist[1];
      EmptyScaffold.jsonFile1 = exist[0];
      EmptyScaffold.existing = exist[2];
    });
    // print(exist[3]['order']['id']);
    if (exist[2]) {
      if (exist[3]['type'] == 'Deliverer') {
        if (exist[3]['order'] != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => OrderInformationConf(
                    exist[3]['order'], exist[3]['order']['id']),
              ),
            );
          });
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(DeleveryHomePage.id);
          });
        }
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Home.id);
        });
      }
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(PageViewWidget.id);
      });
    }
  }

  @override
  void initState() {
    verifying(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
