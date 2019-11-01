import 'package:flutter/material.dart';
import 'auth.dart';
import 'root.dart';
import 'package:flutter_chat_demo/auth_provider.dart';
import 'user_data.dart';
import 'events.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  void callback(params) {
    setState(() {
      print('@###@! MAIN callback... $params');
    });
  }
  @override
  Widget build(BuildContext context) {
   return AppStateContainer(
        auth: Auth(),
    userData: UserData(),

    child: MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(button: TextStyle(color: Color(0xffFFFFFF),letterSpacing: .75, fontSize: 14, fontWeight: FontWeight.w500),subhead: TextStyle(color: Color(0xff212121),letterSpacing: 0, fontSize: 16, fontWeight: FontWeight.w500),
        subtitle: TextStyle(color: Color(0xFF757575), letterSpacing: 0, fontSize: 14, fontWeight: FontWeight.w500)
        ,display1: TextStyle(color: Color(0xFF212121),letterSpacing: 0,fontSize: 34,fontWeight: FontWeight.normal),
        title: TextStyle(color: Color(0xff212121),fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0 )),


      primaryColor:Color(0xff2196F3),
    primaryColorDark: Color(0xFF1976D2),
    primaryColorLight: Color(0xFFBBDEFB),
    accentColor: Color(0xFF9E9E9E),
   hintColor: Color(0xff757575),
      ),
    debugShowCheckedModeBanner: false,

//          home: new RootPage(),
    routes: {

    '/': (context) => RootPage(),
    },
    ),
   );

  }
}