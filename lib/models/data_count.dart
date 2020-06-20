import 'package:cloud_firestore/cloud_firestore.dart';

class DataCount{
  static const ID_USER = 'uid';
  static const STEP = 'step';
  static const DISTANCE = 'distance';
  static const CALORIES = 'calories';
  static const TIME = 'time';
  static const DATE = 'date';

  String _uid;
  String _step;
  String _distance;
  String _calories;
  String _time;
  String _date;

  String get date => _date;

  set date(String value) {
    _date = value;
  }
  String get uid => _uid;

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get calories => _calories;

  set calories(String value) {
    _calories = value;
  }

  String get distance => _distance;

  set distance(String value) {
    _distance = value;
  }

  String get step => _step;

  set step(String value) {
    _step = value;
  }

  set uid(String value) {
    _uid = value;
  }
  DataCount.formSnapShot(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    _uid = data[ID_USER];
    _step = data[STEP];
    _distance = data[DISTANCE];
    _time = data[TIME];
    _calories = data[CALORIES];
    _date = data[DATE];
  }

}