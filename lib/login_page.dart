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
      SafeArea(
        child: Scaffold(
         // backgroundColor: Colors.transparent,
          body: Stack(
            //alignment: AlignmentDirectional.centerS,
              children:
              [
                Center(
                  child: Opacity(
                    opacity: _showProgressIndicator ? 1 : 0,
                    child: CircularProgressIndicator()
              ),
                ),Padding(
                padding: const EdgeInsets.only(top:80),
                child: Column(
                  children:[ Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        SizedBox(height:60),


                        Hero(tag:'logo',child: Image.asset('images/logo.png',width: 10,color: Theme.of(context).primaryColor,height: 100,)),

                        SizedBox(height: 100,),
                        Container(
                          child: RaisedButton(
                              color: Color(0xffCC0000),
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: new Text('SIGN IN WITH GOOGLE',
                                style: Theme.of(context).textTheme.button),
                            onPressed: loginWithGoogle,
                          ),
                        ),
                        SizedBox(height: 20),

                        Container(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: new Text('SIGN UP WITH EMAIL',
                                style: Theme.of(context).textTheme.button),
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
                                    style: Theme.of(context).textTheme.subtitle),
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
                ]),
              ),
              ]
          )
          ,),
      );


  }




}