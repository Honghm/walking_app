import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:walkingapp/config/initialization.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/screens/login_page.dart';
import 'package:walkingapp/widgets/loading.dart';

class Gender {
  const Gender(this.icon, this.gender);

  final Icon icon;
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
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  String Gender_text;
  TabController tb;
  int inte = 45;
  int integer = 30;
  int decal = 5;
  double weight = 0;
  int height1 = 0;
  int height2 = 1;
  int footstep =0;
  String height = '0m';
  Gender selectedGender;
  List<Gender> genders = <Gender>[
    const Gender(
        Icon(
          Icons.people,
          color: Colors.black45,
        ),
        'Nam'),
    const Gender(
        Icon(
          Icons.people,
          color: Colors.black45,
        ),
        'Nữ')
  ];

  final _key = GlobalKey<ScaffoldState>();

  //final AuthService _auth = AuthService();
  String _uid;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
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
                    )),
                    constraints: BoxConstraints.expand(),
                    child: Container(
                      color: Colors.white.withOpacity(0.4),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 80,
                              ),
                              Container(
                                height: 80.0,
                                width: 80.0,
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
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Text(
                                  "XIN CHÀO!",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "Đăng ký tài khoản mới",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              Container(

                                child: Column(children: <Widget>[Padding(
                                  //----------Giới tính---------------
                                  padding: const EdgeInsets.fromLTRB(0,50,0,10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.people,
                                            color: Colors.black45,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10),
                                            child: Text(
                                              "Giới tính",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black45),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 150,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black45),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(6),
                                            )),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Gender>(
                                            hint: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      "Nữ",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black45),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            value: selectedGender,
                                            //items: _dropdownMenuItems,
                                            onChanged: //onChangeDropdownItem,
                                                (Gender Value) {
                                              setState(() {
                                                selectedGender = Value;
                                                footstep = 30;
                                                if (selectedGender.gender == 'Nữ') {
                                                  weight = 45; height='1m60';
                                                } else {
                                                  weight = 60; height='1m80';
                                                }
                                              });
                                            },
                                            items: genders.map((Gender gender) {
                                              return DropdownMenuItem<Gender>(
                                                value: gender,
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15),
                                                      child: gender.icon,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        gender.gender,
                                                        style: TextStyle(
                                                            color: Colors.black45,
                                                            fontSize: 18),
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
                                          Icon(
                                            Icons.people,
                                            color: Colors.black45,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Cân Nặng",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black45),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          width: 150,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              border:
                                              Border.all(color: Colors.black45),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(6),
                                              )),
                                          child: MaterialButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return new AlertDialog(
                                                      title: Text(
                                                        "Cân nặng cơ thể",
                                                        style:
                                                        TextStyle(fontSize: 18),
                                                      ),
                                                      content: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: <Widget>[
                                                          NumberPicker.integer(
                                                              initialValue: inte,
                                                              minValue: 10,
                                                              maxValue: 100,
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  inte = val;
                                                                });
                                                              }),
                                                          Text(
                                                            ",",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          NumberPicker.integer(
                                                              initialValue: decal,
                                                              minValue: 1,
                                                              maxValue: 9,
                                                              onChanged: (val1) {
                                                                setState(() {
                                                                  decal = val1;
                                                                });
                                                              })
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        SizedBox(
                                                          width: 80,
                                                          height: 52,
                                                          child: RaisedButton(
                                                            onPressed: () {
                                                              weight = inte +
                                                                  decal * 0.1;
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text("OK",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black45,
                                                                  fontSize: 18,
                                                                )),
                                                            color:
                                                            Color(0xffffffff),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    6))),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            textColor: Colors.black45,
                                            elevation: 0.1,
                                            child: Text(
                                              "$weight kg",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ))
                                    ],
                                  ),
                                  //----------Chiều cao------------
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.people,
                                              color: Colors.black45,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Chiều cao",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black45),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            width: 150,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                border:
                                                Border.all(color: Colors.black45),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(6),
                                                )),
                                            child: MaterialButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return new AlertDialog(
                                                        title: Text(
                                                          "Chiều cao cơ thể",
                                                          style:
                                                          TextStyle(fontSize: 18),
                                                        ),
                                                        content: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            NumberPicker.integer(
                                                                initialValue: height1,
                                                                minValue: 0,
                                                                maxValue: 2,
                                                                onChanged: (val2) {
                                                                  setState(() {
                                                                    height1 = val2;
                                                                  });
                                                                }),
                                                            Text(
                                                              "m",
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            NumberPicker.integer(
                                                                initialValue: height2,
                                                                minValue: 1,
                                                                maxValue: 99,
                                                                onChanged: (val3) {
                                                                  setState(() {
                                                                    height2 = val3;
                                                                  });
                                                                })
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          SizedBox(
                                                            width: 80,
                                                            height: 52,
                                                            child: RaisedButton(
                                                              onPressed: () {
                                                                height = '$height1 m $height2';
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("OK",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .black45,
                                                                    fontSize: 18,
                                                                  )),
                                                              color:
                                                              Color(0xffffffff),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                      .circular(
                                                                      6))),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              textColor: Colors.black45,
                                              elevation: 0.1,
                                              child: Text(
                                                "$height",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.normal),
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
                                          Icon(
                                            Icons.people,
                                            color: Colors.black45,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Độ dài bước chân",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black45),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          width: 150,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              border:
                                              Border.all(color: Colors.black45),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(6),
                                              )),
                                          child: MaterialButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return new AlertDialog(
                                                      title: Text(
                                                        "Cân nặng cơ thể",
                                                        style:
                                                        TextStyle(fontSize: 18),
                                                      ),
                                                      content: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          NumberPicker.integer(
                                                              initialValue: integer,
                                                              minValue: 10,
                                                              maxValue: 80,
                                                              onChanged: (val6) {
                                                                setState(() {
                                                                  integer = val6;
                                                                });
                                                              }),
                                                          Text(
                                                            ",",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),

                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        SizedBox(
                                                          width: 80,
                                                          height: 52,
                                                          child: RaisedButton(
                                                            onPressed: () {
                                                             footstep = integer;
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text("OK",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black45,
                                                                  fontSize: 18,
                                                                )),
                                                            color:
                                                            Color(0xffffffff),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    6))),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            textColor: Colors.black45,
                                            elevation: 0.1,
                                            child: Text(
                                              "$footstep cm",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                                ),

                              ),



                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 30, 0, 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      print(selectedGender.gender);
                                      if (user.loginGoogle == true)
                                        user.signUp_Google(
                                            widget._name,
                                            widget._email,
                                            widget._phone,
                                            weight.toString(),
                                            height,
                                            selectedGender.gender);
                                      else {
                                        if (!await user.signUp(
                                            widget._name,
                                            widget._email,
                                            widget._pass,
                                            widget._phone,
                                            weight.toString(),
                                            height,
                                            selectedGender.gender)) {
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Đăng ký thất bại")));
                                          return;
                                        }
                                      }
                                      changeScreenReplacement(
                                          context, LoginPage());
                                    },
                                    child: Text(
                                      "Đăng ký",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    color: Color(0xff3277D8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
    );
  }

  void changeScreenReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }
}
