import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise () async{
   _fcm.configure(
     onMessage: (Map<String, dynamic> mesage) async {
       print('onMessage: $mesage');
     },
     onLaunch: (Map<String, dynamic> mesage) async {
       print('onLaunch: $mesage');
     },
     onResume: (Map<String, dynamic> mesage) async {
       print('onResume: $mesage');
     }
   );
  }
}