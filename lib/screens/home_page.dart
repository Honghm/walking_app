import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:walkingapp/provider/home_provider.dart';
import 'package:walkingapp/provider/timer_provider.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/widgets/chart_view.dart';
import 'package:walkingapp/widgets/count_view.dart';
import 'package:walkingapp/widgets/google_map.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isStarting = false;
  bool isPausing = false;
  bool isStopping = true;
  bool isHomePageSelected = true;
  bool isProfilePageSelected = false;


  @override
  Widget build(BuildContext context) {
    final time = Provider.of<TimerProvider>(context);
    final home = Provider.of<HomeProvider>(context);
    final user = Provider.of<UserProvider>(context);
    home.initializing();
    ResponsiveWidgets.init(context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    home.height = double.parse(user.userData.height);
    home.weight = double.parse(user.userData.weight);
    home.foot_step = double.parse(user.userData.foot_step);
    return Column(
      children: <Widget>[
        //---------------Map View------------------------
        MapView(),

        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.blueGrey,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,

              )),
          child: Column(
            children: <Widget>[
              //----------Button điều khiển------------------
              ContainerResponsive(
                height: ScreenUtil().setHeight(250),
                padding: EdgeInsetsResponsive.fromLTRB(40, 20, 40, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    //-------------Button Pause-------------
                    ContainerResponsive(
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: isStarting
                              ? Colors.lightBlueAccent
                              : Colors.transparent),
                      child: IconButton(
                        onPressed: isStarting ? () {
                          setState(() {
                            isPausing = !isPausing;
                          });
                          if (isPausing == true) {
                            time.pauseStopwatch();
                            home.stopListeningStep();
                          } else {
                            time.startStopwatch();
                            home.startListeningStep();
                          }
                        } : null,
                        icon: Icon(
                          isPausing ? Icons.play_arrow : Icons.pause,
                          color: isStarting ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),

                    //------------Button Start-----------------
                    ContainerResponsive(
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:
                          isStopping ? Colors.green : Colors.transparent),
                      child: IconButton(
                        onPressed: isStarting ? null : () {
                          //home.showNotifications();
                          setState(() {
                            isStarting = true;
                            isStopping = false;
                          });
                          if (isStarting == true) {
                            //home.notification();

                            time.startStopwatch();
                            home.dispose();
                            home.getCurrentLocation(context: context, Case: 1);
                            home.startListeningStep();
                          }
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: isStarting ? Colors.transparent : Colors.white,
                        ),
                      ),
                    ),

                    //--------------Button Stop-----------------
                    ContainerResponsive(
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: isStarting ? Colors.red : Colors.transparent),
                      child: IconButton(
                        onPressed: isStarting ? () {
                          setState(() {
                            isStopping = true;
                            isStarting = false;
                          });
                          time.pauseStopwatch();
                          user.setDataCount(user.userData.id, home.stepCount, home.distance, home.caloriesBurned,time.timeDisplay, DateTime.now().toString());
                          time.resetStopwatch();
                          home.stopListeningStep();
                          home.resetStep();
                          home.dispose();

                        } : null,
                        icon: Icon(
                          Icons.stop,
                          color: isStarting ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //-----------Count View-----------------------
              Padding(
                padding: EdgeInsetsResponsive.only(top: 80),
                child: ContainerResponsive(
                  height: ScreenUtil().setHeight(850),
                    child: CountView()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
