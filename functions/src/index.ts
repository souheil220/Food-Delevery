import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();


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

  const db = admin.firestore();
  const fcm = admin.messaging();
  exports.sendNotification = functions.firestore
    .document('messages/{groupId1}/{groupId2}/{message}')
    .onCreate(async snapshot => {
      console.log('----------------start function--------------------')
  
      const doc = snapshot.data();
      console.log(doc)
      if (doc != null) {
        const idFrom = doc.idFrom
        const idTo = doc.idTo
        const contentMessage = doc.content
  
        // Get push token user to (receive)
        const querySnapshot = await db
          .collection('users')
          .where('uid', '==', idTo)
          .get()
          
          querySnapshot.forEach(async userTo => {
              if (userTo.data().pushToken && userTo.data().chattingWith !== idTo) {
                // Get info user from (sent)
                const querySnapshot2 = await db
                  .collection('users')
                  .where('uid', '==', idFrom)
                  .get()
              
                  
                  

                  console.log(querySnapshot.docs.map(snap => snap.id));
                  querySnapshot2.forEach(async userFrom => {
                      console.log(`Found user from: ${userFrom.data().name}`)
                      const payload : admin.messaging.MessagingPayload = { 
                        notification: {
                          title: `You have a message from "${userFrom.data().name}"`,
                          body: contentMessage,
                          badge: '1',
                          sound: 'default'
                        }
                      }
                      // Let push to the target device
                      return fcm
                        .sendToDevice(userTo.data().pushToken, payload)
                       .then(response => {
                          console.log('Successfully sent message:', response)
                        })
                        .catch(error => {
                          console.log('Error sending message:', error)
                        })
                    })
                  
              } else {
                console.log('Can not find pushToken target user')
              }
            })
          
      }
  
  
  
      
    })