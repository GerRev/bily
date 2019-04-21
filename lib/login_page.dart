import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn});
  final onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

enum FormType {
  login,
  register,
  recover,
}

class _LoginPageState extends State<LoginPage> {
  bool _showMessage= false;
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;
  bool _showProgressIndicator = false;
  String uId = null;

  void loginWithGoogle() async {
    var auth = AuthProvider.of(context).auth;

    print('Signing up with google...');
    setState(() {
      _showProgressIndicator = true;
    });
    FirebaseUser user = await auth.signInWithGoogleAcc();
    uId = user.uid;

    if (uId != null) {
      print('Signed in: $uId');
      widget.onSignedIn(user);
    } else {
      print('google login cancelled...');
    }

//    _showAlert(context);
    setState(() {
      _showProgressIndicator = false;
    });
  }



  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        var auth = AuthProvider.of(context).auth;
        FirebaseUser user;

        if (_formType == FormType.login) {
          user = await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: ${user.uid}');
        } else {
          user = await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: ${user.uid}');
        }
        widget.onSignedIn(user);
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
       // backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Opacity(
                opacity: _showProgressIndicator ? 1 : 0,
                child: CircularProgressIndicator()
            ),Container(
              padding: EdgeInsets.only(left: 20,right: 20, top: MediaQuery.of(context).size.width-200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  SizedBox(height: 20,),
                  Container(
                    child: RaisedButton(
                        color: Color(0xffCC0000),
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      child: new Text('Sign in with Google',
                          style: new TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: Colors.white)),
                      onPressed: loginWithGoogle,
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    child: RaisedButton(
                      color: Color(0xff7D9EE9),
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      child: new Text('Sign up with Email',
                          style: new TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: Colors.white)),
                      onPressed: (){
                        Navigator.push(
                            context, SignUpPage(widget.onSignedIn));
                      }
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.only(top:32.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            child: new Text('SIGN IN',
                              style: TextStyle(color: Color(0xff7D9EE9)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context, SignInPage(widget.onSignedIn));
                            },

                          ),

                        ]),
                  ),
                ],

              ),
            ),
            ]
        )
        ,);


  }




}