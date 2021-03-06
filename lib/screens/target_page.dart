import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:walkingapp/provider/home_provider.dart';
class TargetPage extends StatefulWidget {
  @override
  _TargetPageState createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  final TextEditingController _stepController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChange = false;
  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    _stepController.text = home.stepTemp.toString();
    _distanceController.text = home.distanceTemp.toString();
    _timeController.text = home.timeTemp.toString();
    _caloriesController.text = home.caloriesTemp.toString();
    ResponsiveWidgets.init(context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    return Form(
      key: _formKey,
      child: Stack(
        children: <Widget>[
          ContainerResponsive(
            width: double.infinity,
            height: ScreenUtil().setHeight(2500),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black54,
                    Colors.blue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
          ),
          Padding(
            padding: EdgeInsetsResponsive.fromLTRB(30, 150, 30, 0),
            child: Column(
              children: <Widget>[
                SizedBoxResponsive(height: ScreenUtil().setHeight(20),),
                ContainerResponsive(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: ScreenUtil().setHeight(1900),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsResponsive.only(right: 0),
                        child: TextResponsive("?????t m???c ti??u", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(100), fontWeight: FontWeight.bold),),
                      ),

                      //-----------Step target--------------------
                      Padding(
                        padding: EdgeInsetsResponsive.fromLTRB(30, 30, 30, 30),
                        child: ContainerResponsive(
                          height: ScreenUtil().setHeight(270),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.remove), iconSize: ScreenUtil().setSp(80), onPressed: (home.stepTemp <= 1000) ? null : (){
                                home.stepTemp -= 100;
                                home.followStep( home.stepTemp);
                                setState(() {
                                  isChange = true;
                                });
                              }),
                              ContainerResponsive(
                                child: InkWell(
                                  onTap: (){
//                                    showDialog(context: context,
//                                        builder: (context){
//                                          return AlertDialog(
//                                            title: Text("S??? b?????c"),
//                                            content: TextFormField(
//                                              controller: _stepController,
//                                              keyboardType: TextInputType.number,
//                                              validator: (value){
//                                                if(value.isNotEmpty){
//                                                  print(value);
//                                                  if(int.parse(value)<1000)
//                                                    return "S??? b?????c ch??n ph???i l???n h??n 1000 b?????c";
//                                                }
//                                                return null;
//                                              },
//                                            ),
//                                            actions: <Widget>[
//                                              MaterialButton(
//                                                onPressed: (){
//                                                  if(_formKey.currentState.validate()){
//                                                    setState(() {
//                                                      isChange = true;
//                                                    });
//                                                    home.stepTemp = int.parse(_stepController.text);
//                                                    home.followStep( home.stepTemp);
//
//                                                    Navigator.of(context).pop(context);
//                                                  }
//                                                },
//                                                child: Text("L??u",
//                                                  style: TextStyle(color: Colors.blue),
//                                                ),
//                                              ),
//                                              MaterialButton(
//                                                onPressed: (){
//                                                  _stepController.text = home.stepTemp.toString();
//                                                  Navigator.of(context).pop(context);
//                                                },
//                                                child: Text("Tho??t",
//                                                  style: TextStyle(color: Colors.blue),
//                                                ),
//                                              )
//                                            ],
//                                          );
//                                        });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextResponsive(home.stepTemp.toString(), style: TextStyle(fontSize: ScreenUtil().setSp(110), color: Colors.green, fontWeight: FontWeight.bold),),
                                      TextResponsive("S??? b?????c",style: TextStyle(fontSize: ScreenUtil().setSp(70)),)
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(icon: Icon(Icons.add), iconSize: ScreenUtil().setSp(80), onPressed: (){
                                home.stepTemp += 100;
                                setState(() {
                                  isChange = true;
                                });
                                home.followStep( home.stepTemp);

                              }),
                            ],
                          ),
                        ),
                      ),

                      //-----------Distance target--------------------
                      Padding(
                        padding:  EdgeInsetsResponsive.only(left: 30, right: 30),
                        child: ContainerResponsive(
                          height: ScreenUtil().setHeight(270),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.remove), iconSize: ScreenUtil().setSp(80), onPressed:  (home.stepTemp <= 1000) ? null :(){
                                setState(() {
                                  isChange = true;
                                });
                                home.distanceTemp -= 100;
                                home.folowDistance( home.distanceTemp);
                              }),
                              ContainerResponsive(
                                child: InkWell(
                                  onTap: (){
//                                    showDialog(context: context,
//                                        builder: (context){
//                                          return AlertDialog(
//                                            title: Text("Qu??ng ???????ng"),
//                                            content: TextFormField(
//                                              keyboardType: TextInputType.number,
//                                              controller: _distanceController,
//                                              validator: (value){
//                                                if(double.parse(value) <= 1000)
//                                                  return "Qu??ng ???????ng ph???i l???n h??n 1000m";
//                                                return null;
//                                              },
//                                            ),
//                                            actions: <Widget>[
//                                              MaterialButton(
//                                                onPressed: (){
//                                                  if(_formKey.currentState.validate()){
//                                                    home.distanceTemp = double.parse(_distanceController.text);
//                                                    home.folowDistance( home.distanceTemp);
//                                                    setState(() {
//                                                      isChange = true;
//                                                    });
//                                                    Navigator.of(context).pop(context);
//                                                  }
//
//                                                },
//                                                child: Text("L??u",
//                                                  style: TextStyle(color: Colors.blue),
//                                                ),
//                                              ),
//                                              MaterialButton(
//                                                onPressed: (){
//                                                  _distanceController.text = home.distanceTemp.toString();
//                                                  Navigator.of(context).pop(context);
//                                                },
//                                                child: Text("Tho??t",
//                                                  style: TextStyle(color: Colors.blue),
//                                                ),
//                                              )
//                                            ],
//                                          );
//                                        });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextResponsive(home.distanceTemp.toString() + " m", style: TextStyle(fontSize: ScreenUtil().setSp(110), color: Colors.green, fontWeight: FontWeight.bold),),
                                      TextResponsive("Qu??ng ???????ng",style: TextStyle(fontSize: ScreenUtil().setSp(70)),)
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(icon: Icon(Icons.add), iconSize: ScreenUtil().setSp(80), onPressed: (){
                                home.distanceTemp += 100;
                                home.folowDistance( home.distanceTemp);
                                setState(() {
                                  isChange = true;
                                });
                              }),
                            ],
                          ),
                        ),
                      ),

                      //------------- Calories Target---------------
                      Padding(
                        padding: EdgeInsetsResponsive.fromLTRB(30, 30, 30, 30),
                        child: ContainerResponsive(
                          height: ScreenUtil().setHeight(270),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.remove), iconSize: ScreenUtil().setSp(80), onPressed:  (home.stepTemp <= 1000) ? null : (){
                                home.caloriesTemp -= 10;
                                home.folowCalories( home.caloriesTemp);
                                setState(() {
                                  isChange = true;
                                });
                              }),
                              ContainerResponsive(
                                child: InkWell(
                                  onTap: (){
//                                    showDialog(context: context,
//                                        builder: (context){
//                                          return AlertDialog(
//                                            title: Text("Calo"),
//                                            content: TextFormField(
//                                              validator: (value){
//                                                if(double.parse(value)<300)
//                                                  return "L?????ng calo ph???i l???n h??n 300";
//                                                return null;
//                                              },
//                                              keyboardType: TextInputType.number,
//                                              controller: _caloriesController,
//                                            ),
//                                            actions: <Widget>[
//                                              MaterialButton(
//                                                onPressed: (){
//                                                  if(_formKey.currentState.validate()){
//                                                    home.caloriesTemp = double.parse(_caloriesController.text);
//                                                    home.folowCalories( home.caloriesTemp);
//                                                    setState(() {
//                                                      isChange = true;
//                                                    });
//                                                    Navigator.of(context).pop(context);
//                                                  }
//                                                },
//                                                child: Text("L??u",
//                                                  style: TextStyle(color: Colors.blue),
//                                                ),
//                                              ),
//                                              MaterialButton(
//                                                onPressed: (){
//                                                  _caloriesController.text = home.caloriesTemp.toString();
//                                                  Navigator.of(context).pop(context);
//                                                },
//                                                child: Text("Tho??t",
//                                                  style: TextStyle(color: Colors.blue),
//                                                ),
//                                              )
//                                            ],
//                                          );
//                                        });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextResponsive(home.caloriesTemp.toString(), style: TextStyle(fontSize: ScreenUtil().setSp(110), color: Colors.green, fontWeight: FontWeight.bold),),
                                      TextResponsive("calo",style: TextStyle(fontSize: ScreenUtil().setSp(70)),)
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(icon: Icon(Icons.add), iconSize: ScreenUtil().setSp(80), onPressed: (){
                                home.caloriesTemp += 10;
                                home.folowCalories( home.caloriesTemp);
                                setState(() {
                                  isChange = true;
                                });
                              }),
                            ],
                          ),
                        ),
                      ),

                      //------------- Time Target---------------
                      Padding(
                        padding:  EdgeInsetsResponsive.only(left: 30, right: 30),
                        child: ContainerResponsive(
                          height: ScreenUtil().setHeight(270),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: (){
//                              showDialog(context: context,
//                                  builder: (context){
//                                    return AlertDialog(
//                                      title: Text("Th???i gian (ph??t)"),
//                                      content: TextFormField(
//                                        keyboardType: TextInputType.number,
//                                        controller: _timeController,
//                                        validator: (value){
//                                          if(num.parse(value)<30)
//                                            return 'Th???i gian ?????t ra ph???i l???n h??n 30 ph??t';
//                                          else
//                                            return null;
//                                        },
//                                      ),
//                                      actions: <Widget>[
//                                        MaterialButton(
//                                          onPressed: (){
//                                            if(_formKey.currentState.validate()){
//                                              home.timeTemp = int.parse(_timeController.text);
//                                              setState(() {
//                                                isChange = true;
//                                              });
//                                              home.folowTime(home.timeTemp);
//                                              Navigator.of(context).pop(context);
//                                            }
//                                          },
//                                          child: Text("L??u",
//                                            style: TextStyle(color: Colors.blue),
//                                          ),
//                                        ),
//                                        MaterialButton(
//                                          onPressed: (){
//                                            _timeController.text = home.timeTemp.toString();
//                                            Navigator.of(context).pop(context);
//                                          },
//                                          child: Text("Tho??t",
//                                            style: TextStyle(color: Colors.blue),
//                                          ),
//                                        )
//                                      ],
//                                    );
//                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(icon: Icon(Icons.remove), iconSize: ScreenUtil().setSp(80), onPressed: (home.stepTemp <= 1000) ? null :(){
                                  home.timeTemp -= 10;
                                  setState(() {
                                    isChange = true;
                                  });
                                  home.folowTime(home.timeTemp);
                                }),
                                ContainerResponsive(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextResponsive(home.timeTemp.toString(), style: TextStyle(fontSize: ScreenUtil().setSp(110), color: Colors.green, fontWeight: FontWeight.bold),),
                                      TextResponsive("Th???i gian",style: TextStyle(fontSize: ScreenUtil().setSp(70)),)
                                    ],
                                  ),
                                ),
                                IconButton(icon: Icon(Icons.add), iconSize: ScreenUtil().setSp(80), onPressed: (){
                                  home.timeTemp += 10;
                                  setState(() {
                                    isChange = true;
                                  });
                                  home.folowTime(home.timeTemp);
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //--------BUTTON SAVE--------------
                            SizedBoxResponsive(
                              height: ScreenUtil().setHeight(200),
                              width: ScreenUtil().setWidth(550),
                              child: FloatingActionButton.extended(
                                backgroundColor: isChange== true ? Colors.green: Colors.green.withOpacity(0.5),
                                label: TextResponsive("L??U",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(80), fontWeight: FontWeight.bold),),
                                onPressed: isChange== false?null:(){
                                  home.setTarget();
                                  setState(() {
                                    isChange=false;
                                  });
                                },
                              ),
                            ),

                            //---------BUTTON CANCEL------------
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SizedBoxResponsive(
                                height: ScreenUtil().setHeight(200),
                                width: ScreenUtil().setWidth(550),
                                child:  FloatingActionButton.extended(
                                  backgroundColor: isChange==true? Colors.red:Colors.red.withOpacity(0.5),
                                  label: TextResponsive("H???Y",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(80), fontWeight: FontWeight.bold),),
                                  onPressed: isChange==false?null:(){
                                    setState(() {
                                      isChange = false;
                                      home.reTarget();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
