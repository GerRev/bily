import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/login_signup_page.dart';
import 'auth.dart';
import 'homepage.dart';
import 'auth_provider.dart';
import 'login_page.dart';
import 'phone.dart';
import 'login_signup_page.dart';



class RootPage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() => new _RootPageState();
}


enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}



class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void initState() {
    super.initState();
  }



  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _signedIn(FirebaseUser user) {
    var provider = AuthProvider.of(context);
    provider.userData.initData(user, provider);

           print('@@@@@@@@@ after user data syncDown....');
        setState(() {
          authStatus = AuthStatus.signedIn;
        });
  }

  @override
  Widget build(BuildContext context) {
    var userData = AuthProvider.of(context).userData;

    print('initial authStatus: $authStatus');
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();

      case AuthStatus.notSignedIn:
        return LoginPage(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn: {
        print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        if(userData.services.length == 0) {
          print(userData.services.length);
          return Phone();


        } else {
          return
            BottomNavigationBarRecipe();
        }

      } break;
    }
    return null;
  }

  @override
  void didChangeDependencies() {
    var provider = AuthProvider.of(context);

    Future currentUserFuture = provider.auth.currentUser();


    currentUserFuture.then( (user) {
//      String userId = result[2];
      String userId = user?.uid;

      provider.userData.initData(user, provider);
      print('didChangeDependencies #################USERID: $userId');


     // Future.wait([dictFuture, programsFuture]).then((result) {
        provider.userData.syncDataDown(() {
          setState(() {
            print('setting state: didChangeDependencies...');
            authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
          });
        });
      });
  }


  }
