import 'package:flutter/material.dart';
import 'package:notificaciones_push/pages/home_page.dart';
import 'package:notificaciones_push/pages/mensaje_page.dart';
import 'package:notificaciones_push/providers/notifications_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pushNotifcationProvider = new PushNotificationProvider();
    pushNotifcationProvider.initNotifications();

    pushNotifcationProvider.mensajes.listen( (onData) => {
          navigatorKey.currentState.pushNamed('mensaje', arguments:  onData  )
    } );

  }
 
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Push Local',
      initialRoute: 'home',
      theme: ThemeData(
       
        primarySwatch: Colors.green,
      ),
      routes: {
        'home'    : (BuildContext context) => HomePage(),
        'mensaje' : (BuildContext context) => MensajePage(),
      },
    );
  }
}




