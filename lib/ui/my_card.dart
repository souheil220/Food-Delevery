import 'package:flutter/material.dart';
import '../functions/notification.dart';
import '../services/memory_storage.dart';
import '../ui/brew_list.dart';
import '../ui/empty_scaffild.dart';
import '../services/database.dart';
import '../ui/order_information_conf.dart';

class MyCard extends StatefulWidget {
   var order;

  MyCard(this.order);
static var id;
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
 
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
           test(
                context,
                (widget.order['photo']),
                Text(widget.order['name']),
                Text('Bénéfice : ${widget.order['Total']}')),
          
          //SizedBox(height: 10,)
        ],
      ),
    );
  }

  Widget test(
    BuildContext context,
    String image,
    Text text,
    Text text1,
  ) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(image),
                   
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 72.0, right: 24.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  color: Color(0xFF8685E5),
                ),
                child: Column(
                  children: <Widget>[
                    text,
                    text1,
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.check),
                textColor: Colors.green,
                onPressed: () {
                  NotificationUser().unSubscribeFromTopic();
                  MemoryStorage().writeToFile({
                    'order': widget.order,
                    'myLocation':{
                      'Lat':BrewList.lat,
                      'Long':BrewList.long,
                    }

                  }, EmptyScaffold.dir, 'myJSONFile.json',
                      EmptyScaffold.jsonFile1, EmptyScaffold.existing);
                //  DatabaseService(uid: '1').deleteData(MyCard.id, 'pushToken');
                  DatabaseService(uid: '1').deleteData(widget.order['id'],'orders');
                  DatabaseService(uid: '1').orderTaken(widget.order['id']);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => OrderInformationConf(
                          widget.order,
                          BrewList.currentLocation),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
