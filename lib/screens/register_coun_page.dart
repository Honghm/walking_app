import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkingapp/config/initialization.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/screens/login_page.dart';
import 'package:walkingapp/widgets/loading.dart';

class Gender {
  const Gender(this.gender);

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

  Gender selectedGender;
  List<Gender> genders = <Gender>[const Gender('Nam'), const Gender('Nữ')];

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
                        //----------Giới tính---------------
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 30, bottom: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                )),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Gender>(
                                hint: Text("Giới tính"),
                                value: selectedGender,
                                //items: _dropdownMenuItems,
                                onChanged: //onChangeDropdownItem,
                                    (Gender Value) {
                                  setState(() {
                                    selectedGender = Value;
                                  });
                                },
                                items: genders.map((Gender gender) {
                                  return DropdownMenuItem<Gender>(
                                    value: gender,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(
                                            gender.gender,
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                          ),
                        ),

                        //----------Cân nặng------------
                        TextField(
                          controller: _weightController,
                          style: TextStyle(
                              fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Cân nặng",
                              prefixIcon: Container(
                                  width: 50,
                                  child: Icon(Icons.accessibility)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(6)))),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextField(
                            controller: _heightController,
                            style: TextStyle(
                                fontSize: 16, color: Colors.black),
                            decoration: InputDecoration(
                                labelText: "Chiều cao",
                                prefixIcon: Container(
                                    width: 50,
                                    child: Icon(Icons.nature_people)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffCED0D2),
                                        width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(6)))),
                          ),
                        ),

                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0, 30, 0, 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: RaisedButton(
                              onPressed: () async {
                                print(selectedGender.gender);
                                if (user.loginGoogle==true)
                                  user.signUp_Google(
                                      widget._name,
                                      widget._email,
                                      widget._phone,
                                      _weightController.text,
                                      _heightController.text,
                                      selectedGender.gender);
                                else {
                                  if (!await user.signUp(
                                      widget._name,
                                      widget._email,
                                      widget._pass,
                                      widget._phone,
                                      _weightController.text,
                                      _heightController.text,
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
