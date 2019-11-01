import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/service_type_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class Business extends StatefulWidget {
  @override
  _BusinessState createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  bool visible= false;
  //SharedPreferences prefs;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              FadeAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "This is important",
                    "Your business name cannot be changed",
                    "please enter the name twice"
                  ],
                  textStyle: TextStyle(fontSize: 26),

                  //textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
                SizedBox(height: 60),


                TextField(
                  decoration:
                  new InputDecoration(labelText: "Enter your business name"),
                  controller: myController1,

                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      visible=true;
                    });
                    print("First text field: $text");
                  },
                  decoration:
                  new InputDecoration(labelText: "Repeat business name"),
                  controller: myController2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top:30.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Visibility(
                        visible: visible,

                        child: IconButton(

                            icon: Icon(
                              Icons.arrow_forward,size: 32),
                            onPressed:() {
                              if(myController1.text.isEmpty)
                                Fluttertoast.showToast(
                                    msg: "Business name can't be empty",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    fontSize: 16.0
                                );

                              if(myController1.text==myController2.text){
                                // inputData();
                                var value= Text(myController1.text).data;
                                onBusinessPressed(value);
                                print("########################### Adding BusinessName  $value ");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PickServices()),
                                );

                              } else{
                                Fluttertoast.showToast(
                                    msg: "Fields must be the same",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    fontSize: 16.0
                                );
                              }
                            }),
                      ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  void onBusinessPressed(String value) {
    var userData = AuthProvider.of(context).userData;

    setState(() {
      userData.businessName = value;

      userData.syncDataUp();
    });
  }



}

