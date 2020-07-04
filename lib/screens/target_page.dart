import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    _stepController.text = home.stepTarget.toString();
    _distanceController.text = home.distanceTarget.toString();
    _timeController.text = home.timeTarget.toString();
    _caloriesController.text = home.caloriesTarget.toString();
    ResponsiveWidgets.init(context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    return Stack(
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
                      child: TextResponsive("Đặt mục tiêu", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(100), fontWeight: FontWeight.bold),),
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
                            IconButton(icon: Icon(Icons.remove), iconSize: ScreenUtil().setSp(80), onPressed: (home.stepTarget < 1000) ? null : (){
                              home.stepTarget -= 10;
                              home.followStep( home.stepTarget);
                            }),
                            ContainerResponsive(
                              child: InkWell(
                                onTap: (){
                                  showDialog(context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          title: Text("Số bước"),
                                          content: TextField(
                                            controller: _stepController,
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: (){
                                                home.stepTarget = int.parse(_stepController.text);
                                                home.followStep( home.stepTarget);
                                                Navigator.of(context).pop(context);
                                              },
                                              child: Text("Lưu",
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: (){
                                                _stepController.text = home.stepTarget.toString();
                                                Navigator.of(context).pop(context);
                                              },
                                              child: Text("Thoát",
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextResponsive(home.stepTarget.toString(), style: TextStyle(fontSize: ScreenUtil().setSp(110), color: Colors.green, fontWeight: FontWeight.bold),),
                                    TextResponsive("Số bước",style: TextStyle(fontSize: ScreenUtil().setSp(70)),)
                                  ],
                                ),
                              ),
                            ),
                            IconButton(icon: Icon(Icons.add), iconSize: ScreenUtil().setSp(80), onPressed: (){
                              home.stepTarget += 10;
                              home.followStep( home.stepTarget);
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
                            IconButton(icon: Icon(Icons.remove), iconSize: ScreenUtil().setSp(80), onPressed:  (home.stepTarget < 1000) ? null :(){
                              home.distanceTarget -= 0.1;
                              home.folowDistance( home.distanceTarget);
                            }),
                            ContainerResponsive(
                              child: InkWell(
                                onTap: (){
                                  showDialog(context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          title: Text("Quãng đường"),
                                          content: TextField(
                                            controller: _distanceController,
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: (){
                                                home.distanceTarget = double.parse(_distanceController.text);
                                                home.folowDistance( home.distanceTarget);
                                                Navigator.of(context).pop(context);
                                              },
                                              child: Text("Lưu",
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: (){
                                                _distanceController.text = home.distanceTarget.toString();
                                                Navigator.of(context).pop(context);
                                              },
                                              child: Text("Thoát",
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextResponsive(home.distanceTarget.toString() + " km", style: TextStyle(fontSize: ScreenUtil().setSp(110), color: Colors.green, fontWeight: FontWeight.bold),),
                                    TextResponsive("Quãng đường",style: TextStyle(fontSize: ScreenUtil().setSp(70)),)
                                  ],
                                ),
                              ),
                            ),
                            IconButton(icon: Icon(Icons.add), iconSize: ScreenUtil().setSp(80), onPressed: (){
                              home.distanceTarget += 0.1;
                              home.folowDistance( home.distanceTarget);
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
                            IconButton(icon: Icon(Icons.remove), iconSize: ScreenUtil().setSp(80), onPressed:  (home.stepTarget < 1000) ? null : (){
                              home.caloriesTarget -= 1;
                              home.folowCalories( home.caloriesTarget);
                            }),
                            ContainerResponsive(
                              child: InkWell(
                                onTap: (){
                                  showDialog(context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          title: Text("Calo"),
                                          content: TextField(
                                            controller: _caloriesController,
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: (){
                                                home.caloriesTarget = double.parse(_caloriesController.text);
                                                home.folowCalories( home.caloriesTarget);
                                                Navigator.of(context).pop(context);
                                              },
                                              child: Text("Lưu",
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: (){
                                                _caloriesController.text = home.caloriesTarget.toString();
                                                Navigator.of(context).pop(context);
                                              },
                                              child: Text("Thoát",
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextResponsive(home.caloriesTarget.toString(), style: TextStyle(fontSize: ScreenUtil().setSp(110), color: Colors.green, fontWeight: FontWeight.bold),),
                                    TextResponsive("calo",style: TextStyle(fontSize: ScreenUtil().setSp(70)),)
                                  ],
                                ),
                              ),
                            ),
                            IconButton(icon: Icon(Icons.add), iconSize: ScreenUtil().setSp(80), onPressed: (){
                              home.caloriesTarget += 1;
                              home.folowCalories( home.caloriesTarget);
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
                            showDialog(context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text("Thời gian (phút)"),
                                    content: TextField(
                                      controller: _timeController,
                                    ),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: (){
                                          home.timeTarget = int.parse(_timeController.text);
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Text("Lưu",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: (){
                                          _timeController.text = home.timeTarget.toString();
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Text("Thoát",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.remove), iconSize: ScreenUtil().setSp(80), onPressed: (){
                                home.timeTarget -= 1;
                              }),
                              ContainerResponsive(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextResponsive(home.timeTarget.toString(), style: TextStyle(fontSize: ScreenUtil().setSp(110), color: Colors.green, fontWeight: FontWeight.bold),),
                                    TextResponsive("Thời gian",style: TextStyle(fontSize: ScreenUtil().setSp(70)),)
                                  ],
                                ),
                              ),
                              IconButton(icon: Icon(Icons.add), iconSize: ScreenUtil().setSp(80), onPressed: (){
                                home.timeTarget += 1;
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
                              backgroundColor: Colors.green,
                              label: TextResponsive("LƯU",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(80), fontWeight: FontWeight.bold),),
                              onPressed: (){
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
                                backgroundColor: Colors.red,
                                label: TextResponsive("HỦY",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(80), fontWeight: FontWeight.bold),),
                                onPressed: (){

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
    );
  }
}
