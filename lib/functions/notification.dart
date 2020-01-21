import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationUser {
  NotificationUser();

  FirebaseMessaging _messaging = FirebaseMessaging();

  getUserToken() {
    var token = _messaging.getToken();
    return token;
  }

  subscribeToTopic() {
    try {
      _messaging.subscribeToTopic('orders');
      print("subscribed to topic Orders");
    } catch (e) {
      print("didn't sub");
    }
  }

  unSubscribeFromTopic() {
    try {
      _messaging.unsubscribeFromTopic('orders');
      print("unsubscribed from topic Orders");
    } catch (e) {
      print("didn't unsub");
    }
  }
}
