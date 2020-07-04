import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//class NotificationMessages extends StatefulWidget {
//  final String title = 'Notification';
//  @override
//  _NotificationMessagesState createState() => _NotificationMessagesState();
//}
//Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//  if (message.containsKey('data')) {
//    // Handle data message
//    final dynamic data = message['data'];
//  }
//
//  if (message.containsKey('notification')) {
//    // Handle notification message
//    final dynamic notification = message['notification'];
//  }
//
//  // Or do other work.
//}
//class _NotificationMessagesState extends State<NotificationMessages> {
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  _getToken() {
//    _firebaseMessaging.getToken().then((token) {
//      print("Device Token: $token");
//    });
//  }
//  List<Message> _message;
//
//  _configureFirebaseListeners() {
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print('onMessage: $message');
//        _setMessage(message);
//      },
//      onBackgroundMessage: myBackgroundMessageHandler,
//      onLaunch: (Map<String, dynamic> message) async {
//        print('onLaunch: $message');
//        _setMessage(message);
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print('onResume: $message');
//        _setMessage(message);
//      },
//    );
//    _firebaseMessaging.requestNotificationPermissions(
//      const IosNotificationSettings(sound: true, badge: true, alert: true),
//    );
//  }
//
//  _setMessage(Map<String, dynamic> message) {
//    final notification = message['notification'];
//    final data = message['data'];
//    final String title = notification['title'];
//    final String body = notification['body'];
//    String mMessage = data['message'];
//    print("Title: $title, body: $body, message: $mMessage");
//    setState(() {
//      Message msg = Message(title, body, mMessage);
//      _message.add(msg);
//    });
//  }
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _message = List<Message>();
//    _getToken();
//    _configureFirebaseListeners();
//
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: ListView.builder(
//        itemCount: null == _message ? 0 : _message.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Card(
//            child: Padding(
//              padding: EdgeInsets.all(10.0),
//              child: Text(
//                _message[index].message,
//                style: TextStyle(
//                  fontSize: 16.0,
//                  color: Colors.black,
//                ),
//              ),
//            ),
//          );
//        },
//      ),
//    );
//  }
//}
//class Message {
//  String title;
//  String body;
//  String message;
//  Message(title, body, message) {
//    this.title = title;
//    this.body = body;
//    this.message = message;
//  }
//}


class LocalNotifications extends StatefulWidget {
  @override
  _LocalNotificationsState createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<LocalNotifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('assets/images/icon.png');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await notification();
  }

  void _showNotificationsAfterSecond() async {
    await notificationAfterSec();
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'channel body',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Hello there', 'please subscribe my channel', notificationDetails);
  }

  Future<void> notificationAfterSec() async {
    var timeDelayed = DateTime.now().add(Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'second channel ID', 'second Channel title', 'second channel body',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(1, 'Hello there',
        'please subscribe my channel', timeDelayed, notificationDetails);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              onPressed: _showNotifications,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Show Notification",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: _showNotificationsAfterSecond,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Show Notification after few sec",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}