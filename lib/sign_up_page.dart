import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Full Name can\'t be empty' : null;
  }
}

class EmailFieldValidator {
  static String validate(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter valid email';
    else
      return null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm(this.signupCallback);
  final signupCallback;

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  bool _showMessage = false;
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;

  bool validateAndSave() {
    print('validateAndSave...');
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {

    print('validating...');
    if (validateAndSave()) {
      print('signing up');
      try {
        print('@@@@@@@@@@@@@');
        var auth = AuthProvider.of(context).auth;
        FirebaseUser user = await auth.createUserWithEmailAndPassword(_email, _password);
        print('Signed up: ${user.uid}');
        Navigator.popUntil(
            context, ModalRoute.withName('/'));
        widget.signupCallback(user);
      } catch (exception) {
        print('Error:$exception ');

        setState(() {
          _showMessage = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(

                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                ),

              ),
              Container(
//                height: MediaQuery.of(context).size.height - 180,
                  padding: EdgeInsets.only(top: 130, left: 20, right: 20, bottom: 10),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          key: Key('firstname'),
                          decoration: new InputDecoration(
                            labelStyle: TextStyle(
                              color: const Color(0xFF424242)),
                            hintText: 'Your Full Name',
                          //  border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 16, color: Color.fromRGBO(170, 170, 170, 1)),
                          validator: NameFieldValidator.validate,
                          onSaved: (value) => _name = value,

                        ),
                        SizedBox(
                            height: 20
                        ),


                        TextFormField(
                          key: Key('email'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            labelStyle: TextStyle(
                                color: const Color(0xFF424242)),
                            hintText: 'Email',
                          //  border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 16, color: Color.fromRGBO(170, 170, 170, 1)),
                          validator: EmailFieldValidator.validate,
                          onSaved: (value) => _email = value,
                        ),
                        SizedBox(
                            height: 20
                        ),


                        TextFormField(
                          key: Key('password'),
                          decoration: new InputDecoration(
                            labelStyle: TextStyle(
                                color: const Color(0xFF424242)),
                            hintText: 'Password',
                           // border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 16, color: Color.fromRGBO(170, 170, 170, 1)),
                          obscureText: true,
                          validator: PasswordFieldValidator.validate,
                          onSaved: (value) => _password = value,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        RaisedButton(
                            color: Color(0xff7D9EE9),
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: new Text('Sign Up',
                                style: new TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                    color: Colors.white)),
                           onPressed: validateAndSubmit,

                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Opacity(
                              opacity: _showMessage ? 1 : 0,
                              child: Center(
                                child: Text('This account already exists. Have you logged in previously with Google or Facebook?', style:Theme.of(context).textTheme.body2),
                              )),
                        ),

                      ]
                  )

              )
            ],
          ),
        ),
      );

  }
  void onPhonePressed(String value) {
    var userData = AuthProvider.of(context).userData;

    setState(() {
      userData.name = value;

      userData.syncDataUp();
    });
  }
}

class SignUpPage extends MaterialPageRoute<Null> {
  SignUpPage(signupCallback) :super(builder: (BuildContext ctx) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SignUpForm(signupCallback),
      ),
    );
  });
}