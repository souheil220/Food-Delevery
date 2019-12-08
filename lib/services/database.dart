import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  Future updateUserData(String name, String typeOfUser) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'type': typeOfUser,
    });
  }

  Future orderData(var listoffood, var location, var totalAmount) async {
    return await orderCollection.document().setData({
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
    });
  }

  //get orders stream
  Stream<QuerySnapshot> get orders {
    return orderCollection.snapshots();
  }
}
