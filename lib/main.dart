import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkingapp/provider/chart_provider.dart';
import 'package:walkingapp/provider/home_provider.dart';
import 'package:walkingapp/provider/timer_provider.dart';
import 'package:walkingapp/provider/user_provider.dart';
import 'package:walkingapp/screens/home_page.dart';
import 'package:walkingapp/screens/intro_page.dart';
import 'package:walkingapp/screens/login_page.dart';
import 'package:walkingapp/screens/main_page.dart';
import 'package:walkingapp/screens/profile_page.dart';
//import 'package:runningapp/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: TimerProvider()),
    ChangeNotifierProvider.value(value: HomeProvider()),
    ChangeNotifierProvider.value(value: ChartProvider()),
  ], child: MyApp()));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/intro',
      routes: {
        '/intro':(context)=>IntroPage(),
        '/main':(context)=>MainPage(),
        '/login':(context)=>LoginPage(),
        '/profile': (context)=>ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
