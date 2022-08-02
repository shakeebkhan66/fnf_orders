import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token is $token");

    FirebaseMessaging.instance.onTokenRefresh.listen((event) {

    });

    // Save the initial token to the database
    // await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    // FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  @override
  void initState() {
    super.initState();
    setupToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("FCM TOKEN"),
      ),
    );
  }
}
