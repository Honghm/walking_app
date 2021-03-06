import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:walkingapp/config/initialization.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/screens/register_coun_page.dart';
import 'package:walkingapp/widgets/loading.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _rePassController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            Form(
              key: _formKey,
              child: ContainerResponsive(
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
                  child: ContainerResponsive(
                    color: Colors.white.withOpacity(0.4),
                    child: SingleChildScrollView(
                      child: ContainerResponsive(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                                "XIN CH??O!",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(90),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextResponsive(
                              "????ng k?? t??i kho???n m???i",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(60), color: Colors.white),
                            ),

                            //----------T??i kho???n---------------
                            Padding(
                              padding: EdgeInsetsResponsive.fromLTRB(0, 30, 0, 30),
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value){
                                  if (value.isEmpty) {
                                    return 'Y??u c???u nh???p t??i kho???n';
                                  }
                                  if(value.isNotEmpty){
                                   if(user.checkAccount(value)==false){
                                     return 'T??i kho???n ???? t???n t???i';
                                   }
                                  }
                                  return null;
                                },
                                style:
                                TextStyle(fontSize: 16, color: Colors.black),
                                decoration: InputDecoration(
                                    labelText: "T??i kho???n",
                                    prefixIcon: ContainerResponsive(
                                        width: ScreenUtil().setWidth(100), child: Icon(Icons.account_circle)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)))),
                              ),
                            ),

                            //----------M???t kh???u------------
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
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: "M???t kh???u",
                                  prefixIcon: ContainerResponsive(
                                      width: ScreenUtil().setWidth(100), child: Icon(Icons.vpn_key)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffCED0D2), width: 1),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                            ),

                            //----------Nh???p l???i m???t kh???u------------
                            Padding(
                              padding: EdgeInsetsResponsive.fromLTRB(0, 30, 0, 0),
                              child: TextFormField(
                                controller: _rePassController,
                                validator: (value){
                                 if(value.compareTo(_passController.text) != 0){
                                   return "Kh??ng tr??ng v???i m???t kh???u b???n ???? nh???p";
                                 }
                                 if(value.isEmpty){
                                   return "Nh???p l???i m???t kh???u c???a b???n";
                                 }
                                 return null;
                                },
                                style: TextStyle(fontSize: 18, color: Colors.black),
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Nh???p l???i m???t kh???u",
                                    prefixIcon: ContainerResponsive(
                                        width: ScreenUtil().setWidth(100), child: Icon(Icons.vpn_key)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                              ),
                            ),

                            //-----------H??? t??n----------------
                            Padding(
                              padding: EdgeInsetsResponsive.fromLTRB(0, 30, 0, 30),
                              child: TextFormField(
                                controller: _nameController,
                                validator: (value){
                                  if(value.isEmpty)
                                    return "Nh???p h??? t??n c???a b???n";
                                  return null;
                                },
                                style:
                                TextStyle(fontSize: 16, color: Colors.black),
                                decoration: InputDecoration(
                                    labelText: "H??? t??n",
                                    prefixIcon: Container(
                                        width: 50, child: Icon(Icons.person)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)))),
                              ),
                            ),

                            //----------S??? ??i???n tho???i--------
                            TextFormField(
                              controller: _phoneController,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "S??? ??i???n tho???i",
                                  prefixIcon: ContainerResponsive(
                                      width: ScreenUtil().setWidth(100), child: Icon(Icons.phone)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffCED0D2), width: 1),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                            ),

                            Padding(
                              padding: EdgeInsetsResponsive.fromLTRB(0, 30, 0, 20),
                              child: SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: RaisedButton(
                                  onPressed: () async {
                                    await user.getListUser();
                                    if(_formKey.currentState.validate()){
                                      user.loginGoogle = false;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  RegisterPageCoun(_nameController.text,
                                                      _emailController.text,
                                                      _passController.text,
                                                      _phoneController.text)
                                          )
                                      );
                                    }
                                    },
                                  child: TextResponsive(
                                    "Ti???p t???c",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: ScreenUtil().setSp(70)),
                                  ),
                                  color: Color(0xff3277D8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsResponsive.fromLTRB(0, 0, 0, 20),
                              child: RichText(
                                text: TextSpan(
                                    text: "B???n ???? c?? t??i kho???n? ",
                                    style: TextStyle(
                                        color: Color(0xff606470), fontSize: 16),
                                    children: <TextSpan>[
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(context,'/login');
                                            },
                                          text: "????ng nh???p ngay",
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
            ),
          ],
        ),
      ),
    );
  }
}
