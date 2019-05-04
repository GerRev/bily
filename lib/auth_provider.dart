import 'package:flutter/material.dart';
import 'auth.dart';
import 'user_data.dart';
import 'package:flutter_chat_demo/events.dart';

class AppStateContainer extends StatefulWidget {
  final BaseAuth auth;
  final UserData userData;


  final Widget child;

  AppStateContainer({
    @required this.child,
    this.auth,
    this.userData,

  });

  @override
  _AppStateContainerState createState() => new _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer>{
  @override
  Widget build(BuildContext context) {

    return new AuthProvider(
      appRootState: this,
      auth: widget.auth,
      userData: widget.userData,
      child: widget.child,
    );
  }


}

class AuthProvider extends InheritedWidget {

  AuthProvider({
    Key key,
    Widget child,
    this.auth,
    this.userData,
    this.appRootState
  }) : super(key: key, child: child);

  final _AppStateContainerState appRootState;

  final BaseAuth auth;
  final UserData userData;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  static AuthProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AuthProvider) as AuthProvider);
  }


  refresh() {
    appRootState.setState(() {});
  }


}
