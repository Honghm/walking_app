import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkingapp/config/initialization.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/screens/register_coun_page.dart';
import 'package:walkingapp/widgets/loading.dart';

import 'main_page.dart';

class LoginWithGoogle extends StatefulWidget {
  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return user.isMailExist == true
        ? MainPage()
        : Scaffold(
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 0),
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

                                    //-----------Họ tên----------------
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: TextField(
                                        controller: _nameController,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                        decoration: InputDecoration(
                                            labelText: "Họ tên",
                                            prefixIcon: Container(
                                                width: 50,
                                                child: Icon(Icons.person)),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffCED0D2),
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)))),
                                      ),
                                    ),

                                    //----------Số điện thoại--------
                                    TextField(
                                      controller: _phoneController,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      decoration: InputDecoration(
                                          labelText: "Số điện thoại",
                                          prefixIcon: Container(
                                              width: 50,
                                              child: Icon(Icons.phone)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xffCED0D2),
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)))),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 20),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 52,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterPageCoun(
                                                            _nameController
                                                                .text,
                                                            user.account.email,
                                                            null,
                                                            _phoneController
                                                                .text)));
                                          },
                                          child: Text(
                                            "Tiếp tục",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          color: Color(0xff3277D8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: RichText(
                                        text: TextSpan(
                                            text: "Bạn đã có tài khoản? ",
                                            style: TextStyle(
                                                color: Color(0xff606470),
                                                fontSize: 16),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.pop(
                                                              context);
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
                            ),
                          )),
                    ],
                  ),
          );
  }
}
