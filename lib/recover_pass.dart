import 'package:flutter/material.dart';
import 'auth_provider.dart';

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

class RecoverPassForm extends StatefulWidget {
  @override
  RecoverPassFormState createState() => RecoverPassFormState();
}

class RecoverPassFormState extends State<RecoverPassForm> {
  var sent=true;
  String data= '';
  final _formKey = GlobalKey<FormState>();
  String _email;
  bool _emailSent = false;
  bool _showMessage= false;

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
    FocusScope.of(context).requestFocus(new FocusNode());
    print('validating...');
    if (validateAndSave()) {
      print('recovering....');
      try {
        var auth = AuthProvider.of(context).auth;
        sent = await auth.resetPassword(_email);


        setState(() {
          _emailSent = true;
          _showMessage= false;
          data= 'An email has been sent to your account';
        });


//        String userId = await auth.createUserWithEmailAndPassword(_email, _password);
//        print('Signed up: $userId');
//        Navigator.pop(context);
//        widget.signupCallback();
      } catch (e) {
        print('Error: $e');
        setState(() {
          _showMessage= true;
          _emailSent=false;
          data= 'No account with this email';
        });


      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/signin.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  title: Text("RECOVER PASSWORD"),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),


            Container(
//                height: MediaQuery.of(context).size.height - 180,
                padding: EdgeInsets.only(top: 130, left: 10, right: 10, bottom: 10),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [


                      Container(
                        height: 60,
                        padding: EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 10),
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: new Border.all(
                            color: Color.fromRGBO(204, 204, 204, 1),
                            width: 1.0,
                          ),
                        ),
                        child: TextFormField(
                          key: Key('email'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 16, color: Color.fromRGBO(170, 170, 170, 1)),
                          validator: EmailFieldValidator.validate,
                          onSaved: (value) => _email = value,
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        color: Theme.of(context).primaryColor,
                        child: Text('RECOVER PASSWORD', style: TextStyle(fontSize: 16, color: Colors.white)),
                        onPressed: validateAndSubmit,

                      ),
                      SizedBox(height: 20),
                      Center(child: Text(data , style:Theme.of(context).textTheme.body2)),



                    ]
                )

            )
          ],
        ),
      ),
    );
  }
}

class RecoverPassPage extends MaterialPageRoute<Null> {
  RecoverPassPage() : super(builder: (BuildContext ctx) {


    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,

          body: RecoverPassForm()
      ),
    );
  });
}