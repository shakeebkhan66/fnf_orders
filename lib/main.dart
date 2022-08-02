import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fnf_orders/Services/local_notification_service.dart';
import 'package:fnf_orders/orders_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/shared_class.dart';
import 'fcm_get_token.dart';
import 'login_page.dart';

// TODO Receive Message when app is in the background solution for on message
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Firebase Messaging firebase is initialized");
  await Firebase.initializeApp();
}


void main() async{
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
  });

  Constants.preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FnF Orders',
      home: Constants.preferences?.getBool("loggedIn") == true
          ? OrdersList()
          : LoginPage(),
      // home: OrdersList(),
    );
  }
}
