import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/const.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_provider.dart';
import 'package:flutter_chat_demo/user_data.dart';
import 'add_event.dart';
import 'custom_card.dart';
import 'events.dart';
//import 'add_video.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String identifier;
  File _image;
  bool isLoading;
  String id = '';
  String headerImage;
  SharedPreferences prefs;

  void handleUpdateData() {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> values = new Map<String, dynamic>();
    if (headerImage?.isEmpty ?? true) values["headerImage"] = headerImage;

    AuthProvider.of(context)
        .userData
        .docRef
        .updateData(values)
        .then((data) async {
      //AuthProvider.of(context).userData.syncDataUp();

      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: err.toString());
    });
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
        print('LLLLLLLLLLLLLLLLLLLLLLLL + $_image');
        isLoading = true;
      });
    }
    uploadFile();
  }

  Future uploadFile() async {
    // String fileName = id;
    StorageReference reference =
        FirebaseStorage.instance.ref().child('headerImage');
    StorageUploadTask uploadTask = reference.putFile(_image);
    print('WWWWWWWWWWWWWWWQWWWWWWWWWWQWWWWWWW +$_image');
    StorageTaskSnapshot storageTaskSnapshot;
    uploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          headerImage = downloadUrl;

          AuthProvider.of(context)
              .userData
              .docRef
              .updateData({'headerImage': headerImage}).then((data) async {
            // AuthProvider.of(context).userData.syncDataUp();

            // Firestore.instance
            // .collection('users')
            //  .document(id)
            //  .updateData({'headerImage': headerImage}).then((data) async {

            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Upload success");
          }).catchError((err) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: err.toString());
          });
        }, onError: (err) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'This file is not an image');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'This file is not an image');
      }
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: err.toString());
    });
  }


  @override
  void initState() {
    super.initState();
    headerImage== 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPN6bha6PB4nRHeoC7p01q8MtK7veqUetykv-9Og7MLUDE2xTZ';


  }


  @override
  void didChangeDependencies() {
    String identifier= AuthProvider.of(context).userData.userId.toString();
    print('££££££££££££££££££££££££££££££££££££££££££££$identifier');


  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:20,right: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                  new StreamBuilder(
                      stream: AuthProvider.of(context).userData.docRef.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        return  Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300.0,
                          decoration: new BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor,width: 1),
                            borderRadius: new BorderRadius.circular(8.0,),
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new CachedNetworkImageProvider(userDocument['headerImage']),
                            ),
                          ),
                        );
                      }),
                  IconButton(
                    icon: Icon(Icons.camera_alt,color: Colors.white,size: 40,),
                    onPressed: getImage,
                  ),
                ]),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[ Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(right: 10),
                    decoration: AuthProvider.of(context).userData.avatarUrl != null
                        ? BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            AuthProvider.of(context).userData.avatarUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )
                        : null,
                    child: AuthProvider.of(context).userData.avatarUrl != null
                        ? null
                        : Icon(Icons.account_circle),
                  ),
                  Text(
                    AuthProvider.of(context).userData.name,
                    style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),
                  ),


    ]
                ),

                SizedBox(height: 20,),


                Row(
                  children:[ FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DateAndTimePickerDemo()));
                      },
                      child: Icon(Icons.calendar_today)),


              ]  ),




                Text('Events'),
                SizedBox(height:20),

                Container(
                  height: 400,
                   // width: 500,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('Events').where("bandId", isEqualTo:identifier ).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {

                        if (!snapshot.hasData)
                          return new Text('No Events :(',style: TextStyle(fontSize: 50, color: Colors.black),);
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            return new ListView(
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {

                                return  Dismissible(
                                  key: new Key(document.documentID),
                                  onDismissed: (direction){
                                    Firestore.instance.runTransaction((transaction) async {
                                      DocumentSnapshot snapshot=
                                          await transaction.get(document.reference);
                                          await transaction.delete(snapshot.reference);


                                    });
                                    Fluttertoast.showToast(msg: "Event Deleted");
                                  },

                                  child: CustomCard(
                                    event: document['event'],
                                    location: document['location'],
                                    service: document['service'],
                                    date: document['date'],
                                  ),
                                );
                              }).toList(),
                            );
                        }
                      },
                    )),
               SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
