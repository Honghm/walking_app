import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/screens/login_page.dart';
import 'package:walkingapp/screens/register_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    ResponsiveWidgets.init(context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    return Center(
      child: Stack(
        children: <Widget>[

          //------------Background Image----------------
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.fill,
            ),
          ),

          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.blue,
                    Colors.orange.withOpacity(0.8)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
            ),
            padding: EdgeInsets.fromLTRB(30, 200, 30, 0),
            child: ListView(
              children: <Widget>[

                //------------Logo------------------
                ContainerResponsive(
                  height: ScreenUtil().setHeight(300),
                  width: ScreenUtil().setWidth(300),
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100.0,
                    child: Image.asset(
                      "assets/images/icon.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),

                //-----------Name App----------------
                Padding(
                  padding: EdgeInsetsResponsive.fromLTRB(0, 20, 0, 0),
                  child: Center(
                      child: TextResponsive(
                    "WALKING APP",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(120),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        inherit: false),
                  )),
                ),

                Padding(
                  padding: EdgeInsetsResponsive.fromLTRB(0, 5, 0, 40),
                  child: Center(
                      child: TextResponsive(
                        "Ph???m m???m h??? tr??? ??i b???",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(70),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            inherit: false),
                      )),
                ),

                //------------Button ????ng nh???p-------------
                SizedBoxResponsive(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(200),
                  child: ContainerResponsive(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black54,
                            Colors.blue,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      borderRadius:  BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.orange,width: 2)
                    ),
                    child: RaisedButton(
                      color: Colors.black26,
                      onPressed: () async {
                        await user.getListUser();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: TextResponsive(
                        "????ng nh???p",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(70),
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ),

                //------------Button ????ng k??----------------
                Padding(
                  padding: EdgeInsetsResponsive.only(top: 30),
                  child: SizedBoxResponsive(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(200),
                    child: ContainerResponsive(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black54,
                            Colors.blue,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:  BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.red, width: 2)
                      ),
                      child: RaisedButton(
                        onPressed: () async {
                          await user.getListUser();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: TextResponsive(
                          "????ng k??",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(70),
                              fontWeight: FontWeight.bold),
                        ),
                        color: Colors.black26,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
