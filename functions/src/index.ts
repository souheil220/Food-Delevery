import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const fcm = admin.messaging();

export const sendToTopic = functions.firestore
  .document('orders/{ordersId}')
  .onCreate(async snapshot => {
    const order = snapshot.data();
    let nom;
  
    if (order != null) {
      nom = order.name;

    }

    //: admin.messaging.MessagingPayload = 

    const payload = {
      notification: {
        title: 'New Order!',
        body: `Chez ${nom}`,
        sound: 'default',
        click_action: 'FLUTTER_NOTIFICATION_CLICK' // required only for onResume or onLaunch callbacks
      },
    };


    return fcm.sendToTopic('orders', payload)
  });