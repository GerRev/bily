import 'package:flutter/material.dart';
import 'auth.dart';
import 'root.dart';
import 'package:flutter_chat_demo/auth_provider.dart';
import 'user_data.dart';

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
      primaryColor:Color(0xff7D9EE9),
    accentColor: Colors.orange,
    hintColor: Color(0xff7D9EE9),
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