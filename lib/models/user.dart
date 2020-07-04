import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static const ID = 'uid';
  static const NAME = 'name';
  static const ACCOUNT = 'account';
  static const PHONE = 'phone';
  static const PASS = 'pass';
  static const HEIGHT = 'height';
  static const WEIGHT = 'weight';
  static const FOOT_STEP = 'footstep';
  static const URL_AVT = 'url_avt';
  static const URL_COVER = 'url_cover';
  String _id;
  String _name;
  String _account;
  String _phone;
  String _pass;
  String _weight;
  String _height;
  String _urlAvt;
  String _urlCover;
  String _foot_step;

  String get foot_step => _foot_step;

  set foot_step(String value) {
    _foot_step = value;
  }

  String get urlCover => _urlCover;

  set urlCover(String value) {
    _urlCover = value;
  }

  String get urlAvt => _urlAvt;

  set urlAvt(String value) {
    _urlAvt = value;
  }

  String get weight => _weight;

  set weight(String value) {
    _weight = value;
  }

  String get pass => _pass;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  String get name => _name;


  String get phone => _phone;

  String get height => _height;

  UserData.formSnapShot(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    _id = data[ID];
    _name = data[NAME];
    _account = data[ACCOUNT];
    _phone = data[PHONE];
    _weight = data[WEIGHT];
    _height = data[HEIGHT];
    _urlAvt = data[URL_AVT];
    _urlCover = data[URL_COVER];
    _foot_step = data[FOOT_STEP];
  }


  String get account => _account;

  set account(String value) {
    _account = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set pass(String value) {
    _pass = value;
  }

  set height(String value) {
    _height = value;
  }
}
