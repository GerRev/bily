
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'services/payment_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_provider.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    var userId = AuthProvider.of(context).userData.userId;

    return Scaffold(
      body: Container(

        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 30,),
          Text(
            'name',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10,),
          StreamBuilder(
            stream: Firestore.instance
                .collection('stripe_customers')
                .document(userId)
                .collection('sources')
                .document('source')
                .snapshots(),
            builder: (context, snapshot) {

              if(!snapshot.hasData || !snapshot.data.exists){
                print('ffffffffffffffffffffffffffffffrfrffff');
               return Container();

              }
              else{

                var userDocument = snapshot.data;
                print(snapshot);

                return new Text(userDocument["owner"]['name'].toString());
              }

            },
          ),
          SizedBox(height: 30,),
          Text('Cardholder Address',style: TextStyle(color: Colors.grey),),
          SizedBox(height: 10,),
          StreamBuilder(
            stream: Firestore.instance
                .collection('stripe_customers')
                .document(userId)
                .collection('sources')
                .document('source')
                .snapshots(),
            builder: (context, snapshot) {

    if(!snapshot.hasData || !snapshot.data.exists){
      return Container();
    }else {
      var userDocument = snapshot.data;
      print(snapshot);

      return new Text(userDocument["owner"]['address'].toString());
    }

            },

          ),
          SizedBox(height: 30,),
          Text('Last 4 digits',style: TextStyle(color: Colors.grey),),
          SizedBox(height: 10,),
          StreamBuilder(
            stream: Firestore.instance
                .collection('stripe_customers')
                .document(userId)
                .collection('sources')
                .document('source')
                .snapshots(),
            builder: (context, snapshot) {

    if(!snapshot.hasData || !snapshot.data.exists){
      return Container();
    }else {
      var userDocument = snapshot.data;
      print(snapshot);

      return new Text(userDocument["card"]['last4'].toString());
    }

            },

          ),
          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text('ADD YOUR CARD',
                    style: Theme.of(context).textTheme.button),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  print("Ready: ${StripeSource.ready}");
                  StripeSource.addSource().then((String token) {
                    print(
                        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $token");
                    PaymentService().addCard(token);
                  });
                }),
          ),
        ]),
      ),
    );
  }

  @override
  void initState() {
    StripeSource.setPublishableKey(
        'pk_live_JixeZJvUgtdRcVCTtUzZdDac00L1DfY2yw');
  }
}
