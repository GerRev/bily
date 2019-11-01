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


class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State createState() => new SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool loggingOut = false;
  TextEditingController controllerName;
  TextEditingController controllerEmail;
  TextEditingController controllerPhoneNumber;


  SharedPreferences prefs;

  String id = '';
  String name = '';
  String email = '';
  String avatarUrl = '';
  String phoneNumber= '';

  bool isLoading = false;
  File avatarImageFile;

  final FocusNode focusName = new FocusNode();
  final FocusNode focusEmail = new FocusNode();
  final FocusNode focusPhoneNumber= new FocusNode();

  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    readLocal();

  }

  void readLocal() async {

    controllerName = new TextEditingController(text: AuthProvider.of(context).userData.name);
    print(controllerName);
    controllerEmail = new TextEditingController(text: AuthProvider.of(context).userData.email);
    avatarUrl= AuthProvider.of(context).userData.avatarUrl;
   controllerPhoneNumber= new TextEditingController(text: AuthProvider.of(context).userData.phoneNumber);

    // Force refresh input
    setState(() {});
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
    }
    uploadFile();
  }

  Future uploadFile() async {
    String fileName = id;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(avatarImageFile);
    StorageTaskSnapshot storageTaskSnapshot;
    uploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          avatarUrl = downloadUrl;

          AuthProvider.of(context).userData.docRef.updateData({'email': email,'name': name, 'avatarUrl': avatarUrl}).then((data) async {
            //await prefs.setString('avatarUrl', avatarUrl);
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
  void onNamePressed(String name) {
    var userData = AuthProvider.of(context).userData;

    setState(() {
      userData.phoneNumber = name;

      userData.syncDataUp();


    });
  }
  void handleUpdateData() {
    focusName.unfocus();
    focusEmail.unfocus();

    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> values = new Map<String,dynamic>();
    if (name?.isEmpty ?? true) values["name"] = name;
    if (email?.isEmpty ?? true) values["email"] = email;
    if(phoneNumber?.isEmpty ?? true) values["phoneNumber"]= phoneNumber;
      if (avatarUrl?.isEmpty ?? true) values["avatarUrl"] = avatarUrl;

    AuthProvider.of(context).userData.docRef.updateData(values).then((data) async {
     // await prefs.setString('name', name);
     // await prefs.setString('email', email);
     // await prefs.setString('avatartUrl', avatarUrl);
      AuthProvider.of(context).userData.syncDataUp();

      setState(() {
        isLoading = false;
        //AuthProvider.of(context).userData.name;
      });

      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: err.toString());
    });
  }

  void _signOut(BuildContext context) async {
    try {
//      Navigator.pop(context);
      loggingOut = true;

      var auth = AuthProvider.of(context).auth;
      //Future after = auth.signOut();
      //after.then((f) {
      //  widget.mainCallback({'action': 'logout'});
      // });

      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

      await auth.signOut();
      // widget.mainCallback({'action': 'logout'});
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: Column(
                children: <Widget>[
                  // Avatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: (avatarImageFile == null)
                          ? (avatarUrl != ''
                          ? Material(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                            ),
                            width: 90.0,
                            height: 90.0,
                            padding: EdgeInsets.all(20.0),
                          ),
                          imageUrl: avatarUrl,
                          width: 90.0,
                          height: 90.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        clipBehavior: Clip.hardEdge,
                      )
                          : Icon(
                        Icons.account_circle,
                        size: 90.0,
                        color: greyColor,
                      ))
                          : Material(
                        child: Image.file(
                          avatarImageFile,
                          width: 90.0,
                          height: 90.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        clipBehavior: Clip.hardEdge,
                      ),
                    ),
                  ),

                  // Input
                  Column(
                    children: <Widget>[
                      // Username


                      Theme(
                        data: Theme.of(context).copyWith(primaryColor: primaryColor),
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: greyColor),
                          ),
                          controller: controllerName,
                          onChanged: (value) {

                            AuthProvider.of(context).userData.name = value;
                            AuthProvider.of(context).userData.syncDataUp();
                          },
                          focusNode: focusName,
                        ),
                      ),
                      SizedBox(height: 30,),

                      // About me
                      Text(
                        'Email',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(primaryColor: primaryColor),
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: greyColor),
                          ),
                          controller: controllerEmail,
                          onChanged: (value) {
                            AuthProvider.of(context).userData.email = value;
                            AuthProvider.of(context).userData.syncDataUp();
                          },
                          focusNode: focusEmail,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text(
                        'Phone Number',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(primaryColor: primaryColor),
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: greyColor),
                      ),
                      controller: controllerPhoneNumber,
                      onChanged: (value) {
                        AuthProvider.of(context).userData.phoneNumber = value;
                        AuthProvider.of(context).userData.syncDataUp();
                      },
                      focusNode: focusPhoneNumber,
                    ),
                  ),
                  SizedBox(height: 30,),

                  // Button
                  Container(
                    width:MediaQuery.of(context).size.width,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: new Text('UPDATE',
                            style: Theme.of(context).textTheme.button),
                        onPressed: handleUpdateData,


                    ),

                  ),
                  SizedBox(height: 30,),
                  Container(
                    width:MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide( color: Theme.of(context).primaryColor, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 0.8,),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      child: new Text('LOGOUT',
                          style: new TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.5,
                              color: Theme.of(context).primaryColor)),
                      onPressed:() {_signOut(context);}


                    ),
                  ),
                ],
              ),
            ),
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
          ),

          // Loading
          Positioned(
            child: isLoading
                ? Container(
              child: Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
                : Container(),
          ),
        ],
      ),
    );
  }
}