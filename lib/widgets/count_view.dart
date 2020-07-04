import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:walkingapp/provider/home_provider.dart';
import 'package:walkingapp/provider/timer_provider.dart';

class CountView extends StatefulWidget {
  @override
  _CountViewState createState() => _CountViewState();
}

class _CountViewState extends State<CountView> {


  @override
  Widget build(BuildContext context) {
    final time = Provider.of<TimerProvider>(context);
    final home = Provider.of<HomeProvider>(context);
    ResponsiveWidgets.init(context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ContainerResponsive(
              width: ScreenUtil().setWidth(600),
              height: ScreenUtil().setHeight(270),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading:Icon(Icons.directions_walk, size: 30, color: Colors.white,),
                title: TextResponsive(home.stepCount.toString(), style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(70)),),
                subtitle: TextResponsive("Số bước",style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(50),fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child:  ContainerResponsive(
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(270),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.red, width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading:Icon(Icons.timer, size: 30, color: Colors.white,),
                  title: TextResponsive(time.timeDisplay.toString(), style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(70)),),
                  subtitle: TextResponsive("Thời gian",style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(50),fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 23,),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ContainerResponsive(
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(270),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Container(
                      width: 35,
                      height: 35,
                      child: Image.asset('assets/images/distance.png',fit: BoxFit.fill,)),
                  title: TextResponsive(home.distance.toString() + " km", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(70)),),
                  subtitle: TextResponsive("Q.đường",style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(50),fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child:  ContainerResponsive(
                  width: ScreenUtil().setWidth(600),
                  height: ScreenUtil().setHeight(270),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.orange, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/images/burnedx.png',fit: BoxFit.fill,)),
                    title: TextResponsive(home.caloriesBurned.toString(), style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(70)),),
                    subtitle: TextResponsive("Calo",style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(50),fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
