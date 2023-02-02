import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_stream/View/HomePage.dart';
import 'package:video_stream/models/ThemeModel.dart';

/*Created by @IsuruSampath
2023-01-28*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // const MyApp()

    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(
            create: (_) => ThemeModel(theme: ThemeModel.light)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<ThemeData> initializeApp(BuildContext context) async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("fcm-$token");

    ///Check dark mode
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = false;
    // if (prefs.containsKey('isDark')) {
    //   isDark = prefs.getBool('isDark') ?? true;
    // }

    return (isDark) ? ThemeModel.dark : ThemeModel.light;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeData>(
      future: initializeApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider<ThemeModel>(
              create: (context) => ThemeModel(theme: snapshot.data!),
              child: Consumer<ThemeModel>(
                builder: (context, themeModel, _) {
                  return MaterialApp(
                    theme: themeModel.theme,
                    debugShowCheckedModeBanner: false,
                    home: const HomePageScreen(),
                  );
                },
              ),
            );
          } else {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                ),
              ),
            );
          }
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
