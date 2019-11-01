import 'package:flutter/material.dart';
import 'const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_data.dart';
import 'homepage.dart';
import 'auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PickServices extends StatefulWidget {
  @override
  _PickServicesState createState() => _PickServicesState();
}

class _PickServicesState extends State<PickServices> {

 /* SharedPreferences prefs;

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();
  }*/

  bool visible= false;



  void onServicePressed(String value) {
    var userData = AuthProvider.of(context).userData;

    setState(() {
      userData.services.add(value);

      userData.syncDataUp();
    });
  }


  @override
  Widget build(BuildContext context) {
    //handleSignIn();
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
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.only(top:20,bottom: 20),
              child: Text('So.. What do you do?',style: TextStyle(fontSize: 25),),
            ),
            Table(
              children: [
                TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Venue').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Venue Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.home, size: 30, color:Theme.of(context).primaryColor),
                                    Text('VENUE', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Band').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Band Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.music_note, size: 30, color: Theme.of(context).primaryColor),
                                    Text('BAND', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Photographer').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Photographer Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.camera, size: 30, color: Theme.of(context).primaryColor),
                                    Text('PhOTOGRAPHER', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Videographer').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Videographer Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.videocam, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('VIDEOGRAPHER', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('DJ').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'DJ Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.album, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('DJ', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Celebrant').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Celebrant Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.child_care, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('CELEBRANT', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Entertainment').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Entertainment Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.cake, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('ENTERTAINMENT', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('transport').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Transport Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.airport_shuttle, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('TRANSPORT', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Hair and Makeup').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Hair and Make up Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.brush, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('HAIR & MAKEUP', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Catering').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Catering Selected',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.restaurant, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('CATERING', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    var value= Text('Activities').data;
                                    print('££££££££££££££££££££££££ $value');
                                    onServicePressed(value);
                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Activites Selected',
                                    fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);

                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.rowing, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('ACTIVITIES', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                              width: 30,


                              height: 80,


                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {

                                    visible=true;
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        msg:'Not Implemented',
                                        fontSize: 14,
                                        backgroundColor: Theme.of(context).primaryColorDark,
                                        textColor: Colors.white);


                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.add, size: 30, color: Theme.of(context).primaryColor,),
                                    Text('OTHER', style: TextStyle(fontSize: 10, ),),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                    ]
                ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[ Visibility(
                  visible: visible,
                  child: IconButton(
                      icon: Icon(Icons.arrow_forward,size: 32,color: Theme.of(context).primaryColorDark,),
                      onPressed: (){

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ( BottomNavigationBarRecipe())),
                        );

                      }),
                ),
      ]
              ),
            )

          ],
        ),
      ),
    );
  }
}