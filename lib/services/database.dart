import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');
  final CollectionReference orderTakenCollection =
      Firestore.instance.collection('orders Taken');
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
    return orderTakenCollection.document(id.toString()).snapshots();
  }

  

  verifyIfDelevrer(BuildContext context, var typeOfUser, var page) async {
    await FirebaseAuth.instance.currentUser().then((user) {
      userCollection
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if ((docs.documents[0].data['role'] == typeOfUser)) {
            Navigator.pushNamed(context, page);
          } else {
            print("Acaount doesn't exist");
          }
        }
      });
    });
  }

  Future orderData(var namer, var photor, var listoffood, var location,
      var totalAmount) async {
    var id = orderCollection.document().documentID;
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
        'id': id,
      },
    );

    return id;
  }

//creat collection of order taken
  Future orderTaken(var id,) async {

    
    await orderTakenCollection
        .document(orderTakenCollection.document(id).documentID)
        .setData(
      {
      
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
  void deleteData(var id) {
    try {
      databaseReference.collection('orders').document(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
