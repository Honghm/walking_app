import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:walkingapp/config/initialization.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/widgets/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  int login;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    ResponsiveWidgets.init(context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    return ResponsiveWidgets.builder(
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true,
      child: Scaffold(
        key: _key,
        body: user.status == Status.Authenticating
            ? Loading()
            : Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/images/background.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Container(
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
              constraints: BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white.withOpacity(0.4),
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBoxResponsive(
                          height: ScreenUtil().setHeight(500),
                        ),
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
                        Padding(
                          padding: EdgeInsetsResponsive.fromLTRB(0, 60, 0, 10),
                          child: TextResponsive(
                            "XIN CH??O!",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(90),
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextResponsive(
                          "????ng nh???p t??i kho???n c???a b???n",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(60), color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsetsResponsive.fromLTRB(0, 30, 0, 30),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value){
                              if (value.isEmpty) {
                                return 'Y??u c???u nh???p t??i kho???n';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "T??i kho???n",
                              prefixIcon: ContainerResponsive(
                                  width: ScreenUtil().setWidth(100), child: Icon(Icons.account_circle)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(6)),
                              ),

                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _passController,
                          validator: (value){
                          if (value.isEmpty) {
                            return "Y??u c???u nh???p m???t kh???u";
                          } else if (value.length < 6) {
                            return "m???t kh???u ph???i l???n h??n 6 k?? t???";
                          }
                          return null;
                        },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "M???t kh???u",
                              prefixIcon: ContainerResponsive(
                                  width: ScreenUtil().setWidth(100), child: Icon(Icons.vpn_key)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6)))),
                        ),
                        Container(
                          constraints:
                          BoxConstraints.loose(Size(double.infinity, 40)),
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: EdgeInsetsResponsive.fromLTRB(0, 10, 0, 0),
                            child: TextResponsive(
                              "Qu??n m???t kh???u?",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(60), color: Color(0xff606470)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsResponsive.fromLTRB(0, 60, 0, 30),
                          child: SizedBoxResponsive(
                            width:  double.infinity,
                            height: ScreenUtil().setHeight(200),
                            child: RaisedButton(
                              onPressed: () async {
                                if(_formKey.currentState.validate()){
                                  await user.signIn(_emailController.text, _passController.text, context, _key);
                                }
                              },
                              child: TextResponsive(
                                "????ng nh???p",
                                style: TextStyle(
                                    color: Colors.white, fontSize: ScreenUtil().setSp(70), fontWeight: FontWeight.bold),
                              ),
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsResponsive.fromLTRB(0, 0, 0, 10),
                          child: SizedBoxResponsive(
                            width:  double.infinity,
                            height: ScreenUtil().setHeight(200),
                            child: RaisedButton(
                              onPressed: () async {
                                user.googleSignIn.disconnect();
                                await user.loginWithGoogle(context, _key);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ContainerResponsive(
                                    height: ScreenUtil().setHeight(150),
                                    width: ScreenUtil().setWidth(50),
                                    child: Icon(FontAwesomeIcons.google,
                                      color: Colors.blue,),
                                  ),

                                  Padding(
                                    padding: EdgeInsetsResponsive.only(left: 80),
                                    child: TextResponsive(
                                      'Sign in with Google',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: ScreenUtil().setSp(70),fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],),
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(6))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsResponsive.fromLTRB(0, 0, 0, 20),
                          child: RichText(
                            text: TextSpan(
                                text: "B???n ch??a c?? t??i kho???n? ",
                                style: TextStyle(
                                    color: Color(0xff606470), fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterPage()));
                                        },
                                      text: "????ng k?? t???i ????y",
                                      style: TextStyle(
                                          color: Color(0xff3277D8),
                                          fontSize: 16))
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
