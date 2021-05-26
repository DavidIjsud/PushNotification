
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;


  initNotifications() {
    
     

    _firebaseMessaging.requestPermission(); 


    _firebaseMessaging.getToken().then( (token) {


      print('El token');
      print( token );
      // fMKLkNe9I24:APA91bGRdrUxRhYoTDlzYW0vzjsv-ebKLyfYX7u1RahKyn_1hUfOWeQmYqEZ6qFlQ25blXtkE3VSqNgnec4KpqqiTy5zDWd-VsaUz6l2jT6G7mCChcoNNezjElv2Wpkh5qd0jfZ4zmGo
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        
        this._mensajesStreamController.sink.add(message.notification.body);
      } catch (e) {
        print(e);
      }
    }); 
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      try {
        this._mensajesStreamController.sink.add(message.notification.body);
      } catch (e) {
        print(e);
      }
    });


    


  }


  dispose() {
    _mensajesStreamController?.close();
  }

}