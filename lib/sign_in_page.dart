import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'recover_pass.dart';
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

class SignInForm extends StatefulWidget {
  SignInForm(this.loginCallback);
  final loginCallback;

  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {
  String data= '';
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _showMessage=false;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (validateAndSave()) {
      try {
        var auth = AuthProvider.of(context).auth;
        FirebaseUser user =
        await auth.signInWithEmailAndPassword(_email, _password);
        print('Signed in: ${user.uid}');
        Navigator.pop(context);
        widget.loginCallback(user);

      } catch (e) {
        print('Error: $e');
        if (e.toString().contains('password')
        ){
          setState(() {
            data = 'Invalid password';
          });
        }else{
          setState(() {
            data= 'There is no user record corresponding to this email';
          });
        };

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Hero(
              tag: 'logo',
              child: Image.asset(
                'images/logo.png',
                //width: 10,
                color: Theme.of(context).primaryColor,
                //height: 100,
              )),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
//                height: MediaQuery.of(context).size.height - 180,
                      padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              key: Key('email'),
                              keyboardType: TextInputType.emailAddress,
                              decoration: new InputDecoration(
                                hintText: 'Email',
                                labelStyle: TextStyle(
                                    color: const Color(0xFF424242)
                                )
                              ),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(170, 170, 170, 1)),
                              validator: EmailFieldValidator.validate,
                              onSaved: (value) => _email = value,
                            ),
                            SizedBox(height: 20),

                                TextFormField(
                                  key: Key('password'),
                                  decoration: new InputDecoration(
                                    hintText: 'Password',fillColor: Colors.red,
                                    labelStyle: TextStyle(
                                        color: const Color(0xFF424242)
                                    )
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(170, 170, 170, 1)),
                                  obscureText: true,
                                  validator: PasswordFieldValidator.validate,
                                  onSaved: (value) => _password = value,
                                ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  child: Text('SIGN IN',style: Theme.of(context).textTheme.subhead,

                                      ),
                                  onTap: validateAndSubmit,
                                ),
                              ],
                            ),
                            SizedBox(height: 2,),


                            Padding(
                              padding: const EdgeInsets.only(top:60),
                              child: FlatButton(
                                  child: Text('RECOVER PASSWORD',
                                      style: Theme.of(context).textTheme.subtitle),
                                  onPressed: () {
                                    Navigator.push(context, RecoverPassPage());
                                  }),
                            ),
                            Center(child: Text(data,style: TextStyle(fontSize: 16, color:Color(0xff7D9EE9),fontWeight: FontWeight.bold ))),
                          ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPage extends MaterialPageRoute<Null> {
  SignInPage(loginCallback)
      : super(builder: (BuildContext ctx) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new SignInForm(loginCallback),
      ),
    );
  });
}