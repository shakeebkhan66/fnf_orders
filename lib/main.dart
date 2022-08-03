import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/shared_class.dart';
import 'login_page.dart';

// TODO Receive Message when app is in the background solution for on message
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  debugPrint("Firebase Messaging firebase is initialized");
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //   FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  //
  //   if (notification != null && android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //           channel.id,
  //           channel.name,
  //         )));
  //   }
  // });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("message recieved");
    //   print(event.notification!.body);
    //   print(event.notification!.title);
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('Message clicked!');
    // });
    //
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("message recieved");
    //   print(event.notification!.body);
    //   print(event.notification!.title);
    // });

  Constants.preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FnF Orders',
      // home: Constants.preferences?.getBool("loggedIn") == true
      //     ? OrdersList()
      //     : LoginPage(),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  // initialize() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage event) {
  //     print("message recieved");
  //     print(event.notification!.body);
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     print('Message clicked!');
  //   });
  //
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage event) {
  //     print("message recieved");
  //     print(event.notification!.body);
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text("Notification"),
  //             content: Text(event.notification!.title! + " " + event.notification!.body!),
  //             actions: [
  //               TextButton(
  //                 child: Text("Ok"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               )
  //             ],
  //           );
  //         });
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   initialize();
  // }


  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

