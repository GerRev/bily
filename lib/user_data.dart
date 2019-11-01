import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_demo/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';






class UserData {

  DocumentReference docRef;
  List services= [];
  List<DateTime> availableDates= [];
  List links;
  String userId = '';
  String registrationTokens;
  String overrideName = '';

  String avatarUrl = 'https://firebasestorage.googleapis.com/v0/b/brandio-b473a.appspot.com/o/avatar.png?alt=media&token=e6903e9f-67d3-427b-9379-c8b5a5c4fa5e';
  String name;
  String shortName;
  String email;
  String businessName;
  String phoneNumber;
  AuthProvider provider;
  String headerImage= 'https://firebasestorage.googleapis.com/v0/b/brandio-b473a.appspot.com/o/placeholder_062d68aac225efbe32050ad4dc31b60d.png?alt=media&token=e19900bc-80cc-4aba-a321-f93fca4971e9';

  void initData(FirebaseUser user, provider) {
    print('#####InitData: $user');
    this.userId = user?.uid;
    this.provider = provider;
    avatarUrl = user?.photoUrl ?? 'https://firebasestorage.googleapis.com/v0/b/brandio-b473a.appspot.com/o/avatar.png?alt=media&token=e6903e9f-67d3-427b-9379-c8b5a5c4fa5e';
    email = user?.email;
  name = overrideName != '' ? overrideName : user?.displayName;
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
      "email": email,
      'headerImage': headerImage,
      "userId" : userId,
      'availableDates': availableDates,
      'registrationTokens': registrationTokens,
      'links':links

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
       // shortName = name.split(' ')[0];
      }

      if(dataSnapshot.data.containsKey('email')) {
        email = dataSnapshot.data['email'];
      }
      if(dataSnapshot.data.containsKey('phoneNumber')) {
        phoneNumber = dataSnapshot.data['phoneNumber'];
      }
      if(dataSnapshot.data.containsKey('avatarUrl')) {
        avatarUrl = dataSnapshot.data['avatarUrl'];
      }
      if(dataSnapshot.data.containsKey('businessName')) {
        businessName = dataSnapshot.data['businessName'];
      }


      if(dataSnapshot.data.containsKey('userId')) {
        userId = dataSnapshot.data['userId'];
      }

      if(dataSnapshot.data.containsKey('headerImage')) {
        headerImage = dataSnapshot.data['headerImage'];
      }
      if(dataSnapshot.data.containsKey('links')) {
        links = dataSnapshot.data['links'];
      }
      if(dataSnapshot.data.containsKey('registrationTokens')) {
        registrationTokens= dataSnapshot.data['registrationTokens'];
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
