import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkingapp/provider/user_provider.dart';
class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
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

                )),
            accountName: Text(
              user.userData.name,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(user.userData.email),
            currentAccountPicture: GestureDetector(
              child: ClipOval(
                child: SizedBox(
                  width: 120,
                    height: 120,
                    child: Image.network(user.userData.urlAvt, fit: BoxFit.fill,))
              ),
            ),
          ),

          InkWell(
            onTap: () {
            Navigator.pushNamed(context, '/profile');
            },
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.blue,
              ),
              title: Text(
                "Thông tin cá nhân",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.blue,
              ),
              title: Text(
                "Trợ giúp & Liên hệ",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
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
              title: Text(
                "Đăng xuất",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
