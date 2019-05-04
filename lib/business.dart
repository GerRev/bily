import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/service_type_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth_provider.dart';

class Business extends StatefulWidget {
  @override
  _BusinessState createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  SharedPreferences prefs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('What is your business name?'),
              Text(
                "IMPOTANT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  'Be careful with the spelling as once your profile is created the business name cannot be changed'),

              TextField(
                decoration:
                    new InputDecoration(labelText: "Enter your business name"),
                controller: myController1,

              ),
              TextField(
                decoration:
                    new InputDecoration(labelText: "Repeat business name"),
                controller: myController2,
              ),
              Padding(
                padding: const EdgeInsets.only(top:30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [InkWell(
                      child: Text(
                        'NEXT',
                  style: TextStyle(color: Color(0xff7D9EE9),fontSize: 22),),
                      onTap:() {
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
          ]
                ),
              ),
            ],
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


  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    Firestore.instance
        .collection('users')
        .document(uid)
        .updateData({'businessName': myController1.text});
    final QuerySnapshot result =
    await Firestore.instance.collection('users').where('id', isEqualTo: user.uid).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    prefs.setString('businessName', documents[0]['businessName']);
    // here you write the codes to input the data into firestore
  }
}
