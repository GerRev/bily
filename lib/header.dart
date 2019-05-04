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


class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
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
  @override
  void initState() {
    super.initState();
    headerImage = 'https://imgplaceholder.com/640x360';


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
            Fluttertoast.showToast(msg: "Header Image Updated");
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





  

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt,color: Colors.white,),
        onPressed: getImage,),
      body: Container(
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
                        return  Padding(
                          padding: const EdgeInsets.only(top:20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new CachedNetworkImageProvider(userDocument['headerImage']),
                              ),
                            ),
                          ),
                        );
                      }),
                ]),







          ],
        ),
      ),
    );
  }
}
