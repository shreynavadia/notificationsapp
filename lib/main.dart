import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationApp(),
    );
  }
}

class NotificationApp extends StatefulWidget {
  const NotificationApp({Key? key}) : super(key: key);

  @override
  _NotificationAppState createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  List<bool> _selections = [true, false];

  late FlutterLocalNotificationsPlugin localNotification;
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "Local Notification",
        channelDescription: "Notification Successfully Generated!!");
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(android: androidDetails, iOS: iosDetails);
    if (_selections[0] == true) {
      await localNotification.show(0, "Success",
          "Notification Successfully Generated!!", generalNotificationDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Click the button to receive a Notification",
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          ToggleButtons(
            children: [
              Icon(Icons.notifications_active),
              Icon(Icons.notifications_off),
            ],
            isSelected: _selections,
            onPressed: (int index) {
              int otherIndex = (index + 1) % 2;
              setState(() {
                _selections[index] = !_selections[index];
                _selections[otherIndex] = !_selections[otherIndex];
              });
            },
            borderWidth: 2.0,
            renderBorder: false,
            borderRadius: BorderRadius.circular(10.0),
            borderColor: Colors.blue,
            selectedBorderColor: Colors.blue,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.notifications),
        onPressed: _showNotification,
      ),
    );
  }
}
