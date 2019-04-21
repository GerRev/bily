import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_demo/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';






class UserData {

  DocumentReference docRef;
  List services= [];
  String userId = '';
  String avatarUrl;
  String name;
  String shortName;
  String email;
  String businessName;
  String phoneNumber;
  AuthProvider provider;

  void initData(FirebaseUser user, provider) {
    print('#####InitData: $user');
    this.userId = user?.uid;
    this.provider = provider;
    avatarUrl = user?.photoUrl;
    email = user?.email;
    name = user?.displayName;
    if(name != null) shortName = name.split(' ')[0];
    else {
      name = '';
      shortName = '';
    }
  }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "phoneNumber": phoneNumber,
      "businessName": businessName ,
      "avatarUrl": avatarUrl,
      "name": name,
      "shortName": shortName,
      "services": services,

    };

    return data;
  }


  void syncDataUp() {

    if(userId == null ) {
      return;
    } else if(docRef == null){
      docRef = Firestore.instance.document("userData/$userId");
    }

    docRef.updateData(toJson()).whenComplete(() {
      print("Document Updated");
    }).catchError((e) => print(e));
  }



  void syncDataDown(callback) async {
    if(userId == null ) {
      callback();
      return;
    } else if(docRef == null){
      docRef = Firestore.instance.document("userData/$userId");
    }

    print('userId: $userId');

    DocumentSnapshot dataSnapshot = await docRef.get();

    if(dataSnapshot.exists && dataSnapshot.data['services'] != null) {
      services.clear();
      services.addAll(dataSnapshot.data['services']);



      if(dataSnapshot.data.containsKey('name')) {
        name = dataSnapshot.data['name'];
        shortName = name.split(' ')[0];
      }

      if(dataSnapshot.data.containsKey('email')) {
        email = dataSnapshot.data['email'];
      }


    } else {

      services.clear();


      docRef.setData(toJson()).whenComplete(() {
        print("Document Added");
      }).catchError((e) => print(e));
    }

    callback();
  }




}
