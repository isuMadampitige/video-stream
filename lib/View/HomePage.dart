import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:video_stream/View/notificationScreen.dart';

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

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
  }

  _initFirebaseMessaging() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("recieved msggg");
      if (message != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          //  TODO
          //  Do any logic, for example dialog
        }
      }
    });
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
        //Here we can navigate any screen of the app
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationScreen(
                      title: title,
                      body: body,
                    )));
      }
    });
    // FirebaseMessaging?.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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
