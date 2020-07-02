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
  double weight = 0.0;
  double height = 0.0;
  int footstep = 0;
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
                                child: Column(
                                  children: <Widget>[
                                    //----------Giới tính---------------
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB( 0, 50, 0, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.people,
                                                color: Colors.black45,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
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
                                            width: 140,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black45),
                                                borderRadius: BorderRadius.all(Radius.circular(6),)),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<Gender>(
                                                hint: Padding(
                                                  padding:const EdgeInsets.only(left: 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:const EdgeInsets.only(left: 10),
                                                        child: Text(
                                                          "Nam/Nữ",style: TextStyle(fontSize: 18,color: Colors.black45),
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
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: Container(
                                                              height: 25,
                                                              child: Image.asset(gender.icon)),
                                                        ),
                                                        Padding(
                                                          padding:const EdgeInsets.only(left: 20),
                                                          child: Text(
                                                            gender.gender,
                                                            style: TextStyle(color: Colors.black45,fontSize: 18),
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
                                        //NumberPicker.integer(initialValue: _integer, minValue: 0, maxValue: 100, onChanged: (val)=>setState(()=>_integer = val)),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                                width: 25,
                                                child: Image.asset("assets/images/icon_weight.png")),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Text("Cân Nặng",
                                                style: TextStyle(fontSize: 18,color: Colors.black45),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            width: 140,
                                            height: 60,
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
                                                          NumberPickerDialog.decimal(title: Text("Cân nặng"),minValue: 10, maxValue: 100, initialDoubleValue: weight,decimalPlaces: 2,),
                                                          Padding(
                                                            padding: const EdgeInsets.only(bottom: 15),
                                                              child:Icon(Icons.brightness_1,size: 5,)
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
                                              child: Text(
                                                "$weight kg",
                                                style: TextStyle(fontSize: 18,fontWeight:FontWeight.normal),
                                              ),
                                            ))
                                      ],
                                    ),
                                    //----------Chiều cao------------
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  width: 25,
                                                  child: Image.asset("assets/images/icon_height.png")),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8),
                                                child: Text(
                                                  "Chiều cao",
                                                  style: TextStyle(fontSize: 18, color: Colors.black45),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              width: 140,
                                              height: 60,
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
                                                            NumberPickerDialog.decimal(title: Text("Chiều cao"),minValue: 0, maxValue: 3, initialDoubleValue: height,decimalPlaces: 2,),
                                                            Padding(
                                                                padding: const EdgeInsets.only(bottom: 15),
                                                                child:Icon(Icons.brightness_1,size: 5,)
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
                                                child: Text(
                                                  "$height m",
                                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),
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
                                            Container(
                                                width: 25,
                                                child: Image.asset("assets/images/icon1.png")),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
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
                                            width: 140,
                                            height: 60,
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
                                                      return NumberPickerDialog.integer(title: Text("Độ dài bước chân"),minValue: 10, maxValue: 80, initialIntegerValue:integer);
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
                                              child: Text(
                                                "$footstep cm",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ))
                                      ],
                                    ),
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
    );
  }
}
