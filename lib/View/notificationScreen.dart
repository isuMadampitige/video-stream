import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_stream/models/ThemeModel.dart';

class NotificationScreen extends StatefulWidget {
  String? title;
  String? body;
  NotificationScreen({Key? key, this.title, this.body}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(widget.title!, textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(widget.body!, textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
