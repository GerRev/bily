import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentService{

  addCard(token){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('stripe_customers').document(user.uid).collection('tokens').add({'pushId': token}).then((val){
        print('saved');

      });

    });

  }
}
