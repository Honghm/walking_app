import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:walkingapp/config/initialization.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/widgets/loading.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class Gender {
  const Gender(this.icon, this.gender);

  final String icon;
  final String gender;
}

class RegisterPageCoun extends StatefulWidget {
  String _name;
  String _email;
  String _pass;
  String _phone;

  RegisterPageCoun(this._name, this._email, this._pass, this._phone);

  @override
  _RegisterPageStateCoun createState() => _RegisterPageStateCoun();
}

class _RegisterPageStateCoun extends State<RegisterPageCoun> {
  int integer = 30;
  double weight = 50.0;
  double height = 1.5;
  int footstep = 20;
  Gender selectedGender;
  List<Gender> genders = <Gender>[
    const Gender(
        "assets/images/man.png",
        'Nam'),
    const Gender(
        "assets/images/woman.png",
        'Nữ')
  ];

  final _key = GlobalKey<ScaffoldState>();

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
                  ContainerResponsive(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.blue,
                          Colors.orange.withOpacity(0.8)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                      constraints: BoxConstraints.expand(),
                      child: ContainerResponsive(
                        color: Colors.white.withOpacity(0.4),
                        child: SingleChildScrollView(
                          child: ContainerResponsive(
                            padding: EdgeInsetsResponsive.fromLTRB(30, 0, 30, 0),
                            child: Column(
                              children: <Widget>[
                                SizedBoxResponsive(
                                  height: 160,
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
                                  padding: EdgeInsetsResponsive.fromLTRB(0, 60, 0, 20),
                                  child: TextResponsive(
                                    "XIN CHÀO!",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(90),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextResponsive(
                                  "Đăng ký tài khoản mới",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(60), color: Colors.white),
                                ),
                                ContainerResponsive(
                                  child: Column(
                                    children: <Widget>[
                                      //----------Giới tính---------------
                                      Padding(
                                        padding: EdgeInsetsResponsive.fromLTRB(0, 100, 0, 30),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  height: ScreenUtil().setHeight(100),
                                                  child: Icon(
                                                    Icons.people,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsResponsive.only(left: 20),
                                                  child: TextResponsive(
                                                    "Giới tính",
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil().setSp(70),
                                                        color: Colors.black45),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ContainerResponsive(
                                              width: ScreenUtil().setWidth(540),
                                              height: ScreenUtil().setHeight(200),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black45),
                                                  borderRadius: BorderRadius.all(Radius.circular(6),)),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton<Gender>(
                                                  hint: Padding(
                                                    padding:EdgeInsetsResponsive.only(left: 20),
                                                    child: TextResponsive(
                                                      "Nam/Nữ",style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Colors.black45),
                                                    )
                                                  ),
                                                  value: selectedGender,
                                                  onChanged: //onChangeDropdownItem,
                                                      (Gender Value) {
                                                    setState(() {
                                                      selectedGender = Value;

                                                      if (selectedGender.gender =='Nữ') {
                                                        weight = 45;
                                                        height = 1.6;
                                                        footstep = 25;

                                                      } else {
                                                        weight = 60.0;
                                                        height = 1.8;
                                                        footstep = 30;
                                                      }
                                                    });
                                                  },
                                                  items: genders.map((Gender gender) {
                                                    return DropdownMenuItem<Gender>(
                                                      value: gender,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: EdgeInsetsResponsive.only(left: 20),
                                                            child: ContainerResponsive(
                                                                height:ScreenUtil().setHeight(100),
                                                                child: Image.asset(gender.icon)),
                                                          ),
                                                          Padding(
                                                            padding:EdgeInsetsResponsive.only(left: 20),
                                                            child: TextResponsive(
                                                              gender.gender,
                                                              style: TextStyle(color: Colors.black45,fontSize: ScreenUtil().setSp(70)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //----------Cân nặng------------
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              ContainerResponsive(
                                                  width: ScreenUtil().setWidth(100),
                                                  child: Image.asset("assets/images/icon_weight.png")),
                                              Padding(
                                                padding: EdgeInsetsResponsive.only(left: 20),
                                                child: TextResponsive("Cân Nặng",
                                                  style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Colors.black45),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ContainerResponsive(
                                              width: ScreenUtil().setWidth(540),
                                              height: ScreenUtil().setHeight(200),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black45),
                                                  borderRadius: BorderRadius.all(Radius.circular(6),)),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  showDialog<double>(
                                                      context: context,
                                                      builder: (context) {
                                                        return Stack(
                                                          alignment: Alignment.center,
                                                          children: <Widget>[
                                                            NumberPickerDialog.decimal(title: TextResponsive("Cân nặng",style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Colors.black) ),
                                                              minValue: 10, maxValue: 100, initialDoubleValue: weight,decimalPlaces: 2,),
                                                            Padding(
                                                              padding: EdgeInsetsResponsive.only(bottom: 30),
                                                                child:Icon(Icons.brightness_1,size: ScreenUtil().setSp(15),)
                                                            )
                                                          ],
                                                        );
                                                       }).then((double onValue){
                                                        if(onValue != null){
                                                          setState(() {
                                                            weight = onValue;
                                                          });
                                                        }
                                                  });
                                                },
                                                textColor: Colors.black45,
                                                elevation: 0.1,
                                                child: TextResponsive(
                                                  "$weight kg",
                                                  style: TextStyle(fontSize: ScreenUtil().setSp(70),fontWeight:FontWeight.normal),
                                                ),
                                              ))
                                        ],
                                      ),

                                      //----------Chiều cao------------
                                      Padding(
                                        padding: EdgeInsetsResponsive.fromLTRB(
                                            0, 30, 0, 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                ContainerResponsive(
                                                    width: ScreenUtil().setWidth(100),
                                                    child: Image.asset("assets/images/icon_height.png")),
                                                Padding(
                                                  padding: EdgeInsetsResponsive.only(left: 20),
                                                  child: TextResponsive(
                                                    "Chiều cao",
                                                    style: TextStyle(fontSize: ScreenUtil().setSp(70), color: Colors.black45),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ContainerResponsive(
                                                width: ScreenUtil().setWidth(540),
                                                height: ScreenUtil().setHeight(200),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black45),
                                                    borderRadius:BorderRadius.all(Radius.circular(6),)),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    showDialog<double>(
                                                        context: context,
                                                        builder: (context) {
                                                          return Stack(
                                                            alignment: Alignment.center,
                                                            children: <Widget>[
                                                              NumberPickerDialog.decimal(title: TextResponsive("Chiều cao",style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Colors.black)),
                                                                minValue: 0, maxValue: 3, initialDoubleValue: height,decimalPlaces: 2,),
                                                              Padding(
                                                                  padding: EdgeInsetsResponsive.only(bottom: 30),
                                                                  child:Icon(Icons.brightness_1,size: ScreenUtil().setSp(15),)
                                                              )
                                                            ],
                                                          );
                                                        }).then((double onValue){
                                                      if(onValue != null){
                                                        setState(() {
                                                          height = onValue;
                                                        });
                                                      }

                                                    });
                                                  },
                                                  textColor: Colors.black45,
                                                  elevation: 0.1,
                                                  child: TextResponsive(
                                                    "$height m",
                                                    style: TextStyle(fontSize: ScreenUtil().setSp(70),fontWeight: FontWeight.normal),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),

                                      //---------- Độ dài bước chân
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              ContainerResponsive(
                                                  width: ScreenUtil().setWidth(100),
                                                  child: Image.asset("assets/images/icon1.png")),
                                              Padding(
                                                padding: EdgeInsetsResponsive.only(left: 20),
                                                child: ContainerResponsive(
                                                  width: ScreenUtil().setWidth(550),
                                                  child:TextResponsive(
                                                    "Độ dài bước chân",
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil().setSp(70),
                                                        color: Colors.black45),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ContainerResponsive(
                                              width: ScreenUtil().setWidth(540),
                                              height: ScreenUtil().setHeight(200),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black45),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(6),
                                                  )),
                                              child: MaterialButton(
                                                onPressed: () {
                                                  showDialog<int>(
                                                      context: context,
                                                      builder: (context) {
                                                        return NumberPickerDialog.integer(title: TextResponsive("Độ dài bước chân",style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Colors.black)),
                                                            minValue: 10, maxValue: 80, initialIntegerValue:integer);
                                                      }).then((int onValue){
                                                        if(onValue!=null){
                                                          setState(() {
                                                            footstep = onValue;
                                                          });
                                                        }
                                                  });
                                                },
                                                textColor: Colors.black45,
                                                elevation: 0.1,
                                                child: TextResponsive(
                                                  "$footstep cm",
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil().setSp(70),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ))
                                        ],
                                      ),

                                      Padding(
                                        padding:EdgeInsetsResponsive.fromLTRB(0, 30, 0, 20),
                                        child: SizedBoxResponsive(
                                          width: double.infinity,
                                          height: ScreenUtil().setHeight(200),
                                          child: RaisedButton(
                                            onPressed: () async {
                                              print(selectedGender.gender);
                                              if (user.loginGoogle==true)
                                                user.signUp_Google(
                                                    widget._name,
                                                    widget._email,
                                                    widget._phone,
                                                    weight.toString(),
                                                    height.toString(),
                                                    selectedGender.gender,
                                                  footstep.toString(),
                                                );
                                              else {
                                                if (!await user.signUp(
                                                    widget._name,
                                                    widget._email,
                                                    widget._pass,
                                                    widget._phone,
                                                    weight.toString(),
                                                    height.toString(),
                                                    selectedGender.gender,
                                                    footstep.toString(),
                                                )) {
                                                  _key.currentState.showSnackBar(
                                                      SnackBar(
                                                          content: TextResponsive(
                                                              "Đăng ký thất bại", style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Colors.black))));
                                                  return;
                                                }
                                              }
                                              Navigator.pushNamed(context, '/login');
                                            },
                                            child: TextResponsive(
                                              "Đăng ký",
                                                style: TextStyle(fontSize: ScreenUtil().setSp(70),color: Colors.white)
                                            ),
                                            color: Color(0xff3277D8),
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
                                              text: "Bạn đã có tài khoản? ",
                                              style: TextStyle(
                                                  color: Color(0xff606470), fontSize: 16),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.pushNamed(context,'/login');
                                                      },
                                                    text: "Đăng nhập ngay",
                                                    style: TextStyle(
                                                        color: Color(0xff3277D8),
                                                        fontSize: 16))
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
      ),
    );
  }
}
