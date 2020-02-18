import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/functions/notification.dart';
import 'package:hello_world/ui/empty_scaffild.dart';
import 'package:hello_world/ui/my_card.dart';

import 'memory_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');
  final CollectionReference pushToken =
      Firestore.instance.collection('pushToken');
  final CollectionReference orderTakenCollection =
      Firestore.instance.collection('orders Taken');
  final CollectionReference messagesCollection =
      Firestore.instance.collection('messages');
  final databaseReference = Firestore.instance;

  Future updateUserData(
      String name, String typeOfUser, String email, String useruid) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'role': typeOfUser,
      'uid': useruid,
      'email': email,
    });
  }

  getEtat(var id) {
   print(id);
    return orderTakenCollection.document(id.toString()).snapshots();
  }

  verifyIfDelevrer(
      BuildContext context, var typeOfUser, var page, String email) async {
    await FirebaseAuth.instance.currentUser().then((user) {
      userCollection
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if ((docs.documents[0].data['role'] == typeOfUser)) {
            if (typeOfUser == 'Deliverer') {
              NotificationUser().subscribeToTopic();
            }
            Navigator.pushNamed(context, page);
            
            MemoryStorage().writeToFile(
                {"email": email, 'type': typeOfUser},
                EmptyScaffold.userdir,
                'userJSONFile.json',
                EmptyScaffold.userjsonFile1,
                EmptyScaffold.userexisting);
            MemoryStorage().writeToFile(
                {'My Food': {}},
                EmptyScaffold.dir,
                'myJSONFile.json',
                EmptyScaffold.jsonFile1,
                EmptyScaffold.existing);
          } else {
            print("Acaount doesn't exist");
          }
        }
      });
    });
  }

  Future saveToken(var token) async {
    var id = orderCollection.document().documentID;
    MyCard.id = id;
    await pushToken.document(orderCollection.document(id).documentID).setData(
      {'devtoken': token},
    );
  }

  Future orderData(
    var namer,
    var photor,
    var listoffood,
    var location,
    var totalAmount,
  ) async {
   
    var id = orderCollection.document().documentID;
    FirebaseUser user = await FirebaseAuth.instance.currentUser(); 
    await orderCollection
        .document(orderCollection.document(id).documentID)
        .setData(
      {
        for (int i = 0; i < listoffood.length; i++)
          'order $i': {
            'nom': listoffood[i].nom,
            'quantite': listoffood[i].quantity,
            'image': listoffood[i].image,
          },
        'location': {
          'Latitude': location.latitude,
          'Longitude': location.longitude,
        },
        'Total': totalAmount,
        'Etat': 'waiting',
        'name': namer,
        'photo': photor,
        'ConsumerId' : user.uid,
        'id': id,
      },
    );

    return id;
  }

//creat collection of order taken
  Future orderTaken(var id) async {
     FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await orderTakenCollection
        .document(orderTakenCollection.document(id).documentID)
        .setData(
      {
        'Taken by' : user.uid,
        'id': id,
        'Etat': "Pris en charge",
      },
    );

    return id;
  }

  //get orders stream
  Stream<QuerySnapshot> get orders {
    return orderCollection.snapshots();
  }

//delete document
  void deleteData(var id, String colection) {
    try {
      print(id);
      databaseReference.collection(colection).document(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
