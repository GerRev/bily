import 'package:flutter/material.dart';
import 'const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_data.dart';
import 'homepage.dart';

class PickServices extends StatefulWidget {
  @override
  _PickServicesState createState() => _PickServicesState();
}

class _PickServicesState extends State<PickServices> {

  SharedPreferences prefs;

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool visible= false;


  @override
  Widget build(BuildContext context) {
    handleSignIn();
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Padding(
            padding: const EdgeInsets.only(top:100,bottom: 40),
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
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.home, size: 30, color:Color(0xff7D9EE9)),
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
                                  visible=true;

                                });

                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.music_note, size: 30, color: Color(0xff7D9EE9)),
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
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.camera, size: 30, color: Color(0xff7D9EE9)),
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
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.videocam, size: 30, color: Color(0xff7D9EE9),),
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
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.album, size: 30, color: Color(0xff7D9EE9),),
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
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.child_care, size: 30, color: Color(0xff7D9EE9),),
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
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.cake, size: 30, color: Color(0xff7D9EE9),),
                                  Text('ENTERTAINMENTS', style: TextStyle(fontSize: 10, ),),
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

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.airport_shuttle, size: 30, color: Color(0xff7D9EE9),),
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
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.brush, size: 30, color: Color(0xff7D9EE9),),
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
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.restaurant, size: 30, color: Color(0xff7D9EE9),),
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
                                  visible=true;

                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.rowing, size: 30, color: Color(0xff7D9EE9),),
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


                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.add, size: 30, color: Color(0xff7D9EE9),),
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
                child: InkWell(
                    child: Text('NEXT', style: TextStyle(color: Color(0xff7D9EE9),fontSize: 22,),),
                    onTap: (){

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
    );
  }
}