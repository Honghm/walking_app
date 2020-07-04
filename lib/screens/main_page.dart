import 'package:flutter/material.dart';
import 'package:walkingapp/screens/chart_page.dart';
import 'package:walkingapp/screens/home_page.dart';
import 'package:walkingapp/screens/target_page.dart';
import 'package:walkingapp/widgets/BottomNavigationBar/bootom_navigation_bar.dart';
import 'package:walkingapp/widgets/home_menu.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isHomePageSelected = true;
  bool isTargetPageSelected = false;
  bool isChartPageSelected = false;

  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    return ResponsiveWidgets.builder(
        height: 1520, // Optional
        width: 720, // Optional
        allowFontScaling: true, // Optional
      child:  Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.lightBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
            child: Stack(
              children: <Widget>[
                //------------Điều hướng màn hình-----------------
                Padding(
                  padding: EdgeInsetsResponsive.only(top: 170),
                  child: isHomePageSelected
                      ? HomePage()
                      : (isTargetPageSelected ? TargetPage() : ChartPage()),
                ),

                //-----App Bar----------------------
                ContainerResponsive(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black54, Colors.lightBlue],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: AppBar(
                      centerTitle: true,
                      backgroundColor: Colors.black54,
                      elevation: 5.0,
                      title: TextResponsive(
                        "Running App",
                        style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(90)),
                      ),
                      leading: FlatButton(
                          onPressed: () {
                            _scaffoldKey.currentState.openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          )),
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                            ),
                            onPressed: () {})
                      ],
                    ))
              ],
            ),
          ),
        ),
        //-----------------Bottom Bar--------------------
        bottomNavigationBar:
        CustomBottomNavigationBar(onIconPresedCallback: onBottomIconPressed),
        //----------------Drawer View--------------------
        drawer: HomeMenu(),
      )
    );

  }

  void onBottomIconPressed(int index) {
    switch (index) {
      case 0:
        setState(() {
          isHomePageSelected = false;
          isTargetPageSelected = true;
          isChartPageSelected = false;
        });
        break;
      case 1:
        setState(() {
          isHomePageSelected = true;
          isTargetPageSelected = false;
          isChartPageSelected = false;
        });
        break;
      case 2:
        setState(() {
          isHomePageSelected = false;
          isTargetPageSelected = false;
          isChartPageSelected = true;
        });
        break;
    }
  }
}
