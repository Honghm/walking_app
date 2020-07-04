
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:walkingapp/provider/user_provider.dart';
class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    ResponsiveWidgets.init(context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    return Drawer(
      child: ListView(
        children: <Widget>[
          //Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black54,
                    Colors.blue,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
            ),
            accountName: TextResponsive(
              user.userData.name,
              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(70), fontWeight: FontWeight.bold),
            ),
            accountEmail: TextResponsive(user.userData.account, style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(50), fontWeight: FontWeight.normal)),
            currentAccountPicture: GestureDetector(
              child: ClipOval(
                child: SizedBoxResponsive(
                  width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setHeight(300),
                    child: Image.network(user.userData.urlAvt, fit: BoxFit.fill,))
              ),
            ),

          ),

          InkWell(
            onTap: () {
            Navigator.pushNamed(context, '/profile');
            },
            child: ListTile(
              leading: ContainerResponsive(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(50),
                child: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ),
              title: TextResponsive(
                "Thông tin cá nhân",
                style: TextStyle(fontSize: ScreenUtil().setSp(70), color: Color(0xff323643)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(context: context,
                  builder: (context){
                return AlertDialog(
                  title: ContainerResponsive(
                    child: Row(
                      children: <Widget>[
                        ContainerResponsive(
                          width: ScreenUtil().setWidth(300),
                          height: ScreenUtil().setHeight(300),
                          child: Image.asset('assets/images/step.png', fit: BoxFit.fill,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('Walking App \n 1.0'),
                        ),
                      ],
                    )
                  ),
                  content: ContainerResponsive(
                    height: ScreenUtil().setHeight(300),
                    child: Column(
                      children: <Widget>[
                        Text("Thông tin liên hệ:", style: TextStyle(fontSize: 18),),
                        Text("17520526@gm.uit.edu.vn\n18520155@gm.uit.edu.vn", style: TextStyle(fontSize: 18),),
                      ],
                    ),

                  ),
                  actions: <Widget>[
                    MaterialButton(onPressed: (){
                      Navigator.of(context).pop(context);
                    },
                      child: Text("Đóng",
                        style: TextStyle(color: Colors.blue),
                      ),)
                  ],
                );
                  });
            },
            child: ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.blue,
              ),
              title: TextResponsive(
                "Trợ giúp & Liên hệ",
                style: TextStyle(fontSize: ScreenUtil().setSp(70), color: Color(0xff323643)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              user.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.blue,
              ),
              title: TextResponsive(
                "Đăng xuất",
                style: TextStyle(fontSize: ScreenUtil().setSp(70), color: Color(0xff323643)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
