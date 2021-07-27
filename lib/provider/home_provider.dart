import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:pedometer/pedometer.dart';


class HomeProvider with ChangeNotifier {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;



  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('step');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }


  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'Channel body',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Chúc mừng', 'Bạn đã hoàn thành mục tiêu', notificationDetails);
  }
  void showNotifications() async {
    await notification();
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
  Location _locationTracker = Location();
  LocationData _locationData;
  GoogleMapController _controller;
  set controller(GoogleMapController value) {
    _controller = value;
    notifyListeners();
  }
 bool isSetTarget = false;
  List<LatLng> latlngs = []; //mảng lưu vị trí
  LocationData get locationData => _locationData;
  // ignore: sdk_version_set_literal
  Set<Polyline> polylines = {};
  Marker marker;
  BuildContext _context;
  double _height;
  double _weight;
  double _foot_step;

  double get foot_step => _foot_step;

  set foot_step(double value) {
    _foot_step = value;
  } //Step Provider
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  int _stepCountCurrent = 0;
  int _stepCount = 0;
  double _distance = 0;

  set height(double value) {
    _height = value;
  }

  double get height => _height;
  double _caloriesBurned = 0;
  double get caloriesBurned => _caloriesBurned;

  //-------------------- Map Provider-----------------------
  //-------------Cập nhật lại Map khi có sự thay đổi vị trí -----------------
  void updateMap(LocationData newLocalData, BuildContext context) async {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);

    marker = Marker(
      
        markerId: MarkerId("home"),
        position: latlng,
        rotation: newLocalData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: await BitmapDescriptor.fromAssetImage(
            createLocalImageConfiguration(context), 'assets/pngwave.png'));
    notifyListeners();

    if (latlngs.length >= 2) {
      polylines.add(Polyline(
        polylineId: PolylineId("poly"),
        visible: true,
        width: 5,
        points: latlngs,
        color: Colors.red,
      ));
      notifyListeners();
    }
  }

  //----------Lấy vị trí hiện tại của thiết bị---------------
  void getCurrentLocation({BuildContext context, int Case}) async {
    if (context != null) {
      _context = context;
    }
    try {
      var location = await _locationTracker.getLocation();
      var lat = num.parse(location.latitude.toStringAsFixed(6));
      var long = num.parse(location.longitude.toStringAsFixed(6));
      if (Case == 1) {
        latlngs.add(LatLng(lat, long));
      }
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(lat, long),
              tilt: 0,
              zoom: 18.00)));

      if (context == null)
        updateMap(location, _context);
      else
        updateMap(location, context);

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }

  }

  void dispose() {
    polylines.clear();
    latlngs.clear();
    notifyListeners();
  }

  // Step Provider
  double get distance => _distance;

  //-----------Tạo sự kiện lắng nghe bước chân-----------------
  void startListeningStep() {
    _pedometer = new Pedometer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void stopListeningStep() {
    _subscription.pause();
  }

  void _onData(int stepCountValue) async {
    int preStep;
    preStep = _stepCountCurrent;
    if (preStep == 0) {
      _stepCountCurrent = stepCountValue;
    }
    if (preStep != 0 && stepCountValue > preStep) {
      _stepCount++;
      _stepCountCurrent = stepCountValue;
      notifyListeners();
      if ((_stepCount % 5) == 0 && _stepCount > 0) {
        getCurrentLocation(Case: 1);
        notifyListeners();
      }
    }
    _countDistance(_stepCount);
    if(isSetTarget == true){
      if(_stepCount==_stepTarget||caloriesBurned == caloriesTarget)
        showNotifications();
    }
  }

  int get stepCount => _stepCount;
  void resetStep() {
    _stepCount = 0;
    _stepCountCurrent = 0;
    _caloriesBurned = 0;
    _distance = 0;
    notifyListeners();
  }
  void _onDone() {}
  void _onError(error) => print("Flutter Pedometer Error: $error");

  //-------------Tính quãng đường---------------------
  void _countDistance(int step) {
    _distance = (step * foot_step*0.01);
    _distance = num.parse(_distance.toStringAsFixed(2));
    notifyListeners();
    _countCalories(_distance);
  }


  //--------------Tính lượng kalo được đốt cháy-------------------
  void _countCalories(double distance) {
    _caloriesBurned = 0.5 * (_weight * 2.20462) * 1.60934 * distance;
    _caloriesBurned = num.parse(_caloriesBurned.toStringAsFixed(2));
    notifyListeners();
  }

  set weight(double value) {
    _weight = value;
  }

  int _stepTarget = 1000;
  double _distanceTarget = 1000;
  int _timeTarget = 30;
  double _caloriesTarget = 300;
  int _stepTemp = 1000;
  double _distanceTemp = 1000;
  int _timeTemp = 30;
  double _caloriesTemp = 300;

  int get stepTemp => _stepTemp;

  set stepTemp(int value) {
    _stepTemp = value;
    notifyListeners();
  }

  int get stepTarget => _stepTarget;

  double get distanceTarget => _distanceTarget;

  int get timeTarget => _timeTarget;


  double get caloriesTarget => _caloriesTarget;

void followStep(int step){
  _distanceTemp = (step * _foot_step*0.01);
  _distanceTemp = num.parse(_distanceTemp.toStringAsFixed(2));
  notifyListeners();
  _caloriesTemp = 0.5 * (_weight * 2.20462) * 1.60934 * _distanceTemp;
  _caloriesTemp = num.parse(_caloriesTemp.toStringAsFixed(2));
  notifyListeners();
  _timeTemp = (_distanceTemp*0.012).round();
  notifyListeners();
}


  void folowDistance(double distances){
    _stepTemp = (distances/(_foot_step*0.01)).round();
    notifyListeners();
    _caloriesTemp = 0.5 * (_weight * 2.20462) * 1.60934 * distances;
    _caloriesTemp = num.parse(_caloriesTemp.toStringAsFixed(2));
    notifyListeners();
    _timeTemp = (distances*0.012).round();
    notifyListeners();
  }

  void folowCalories(double calories){
    _distanceTemp = calories/(0.5 * (_weight * 2.20462) * 1.60934);
    _distanceTemp = num.parse(_distanceTemp.toStringAsFixed(2));
    notifyListeners();
    _stepTemp = (_distanceTemp/(_foot_step*0.01)).round();
    notifyListeners();
    _timeTemp = (_distanceTemp*0.012).round();
    notifyListeners();
  }
void folowTime(int time){
  _distanceTemp = time*83.3;
  _distanceTemp = num.parse(_distanceTemp.toStringAsFixed(2));
  notifyListeners();
  folowDistance(_distanceTemp);
}
  double get distanceTemp => _distanceTemp;

  set distanceTemp(double value) {
    _distanceTemp = num.parse(value.toStringAsFixed(2));
    notifyListeners();
  }

  int get timeTemp => _timeTemp;

  set timeTemp(int value) {
    _timeTemp = value;
    notifyListeners();
  }

  double get caloriesTemp => _caloriesTemp;

  set caloriesTemp(double value) {
    _caloriesTemp = value;
    notifyListeners();
  }
  void setTarget(){
    isSetTarget = true;
    notifyListeners();
    _stepTarget = _stepTemp;
    _distanceTarget = _distanceTemp;
    _caloriesTarget = _caloriesTemp;
    _timeTarget = _timeTemp;
    notifyListeners();
  }
  void reTarget(){
    isSetTarget = false;
    notifyListeners();
   _stepTemp = _stepTarget;
   _distanceTemp =_distanceTarget;
   _caloriesTemp = _caloriesTarget;
   _timeTemp =_timeTarget;
    notifyListeners();
  }
}
