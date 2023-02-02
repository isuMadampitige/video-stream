import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? title;
  String? body;
  String? image;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _initFirebaseMessaging();
    });
  }

  _initFirebaseMessaging() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message recieved");
      print(message.notification!.body);
      body = message.notification!.body;
      title = message.notification!.title;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
        body = message.notification!.body;
        title = message.notification!.title;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomePageScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Stream"),
        centerTitle: true,
      ),
      body: const Center(
          child: Text(
        "Hello user to Video stream app",
        style: TextStyle(fontSize: 22),
      )),
    );
  }
}
