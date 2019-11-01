import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:flutter/services.dart';



class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => new _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  initState() {
    super.initState();

    StripeSource.setPublishableKey("pk_test");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: RaisedButton(
            child: Text("Add Card"),
            onPressed: () {
              print("Ready: ${StripeSource.ready}");
              StripeSource.addSource().then((String token) {
                _addSource(token);
              });
            },
          ),
        ),
      ),
    );
  }

  void _addSource(String token) {
    print("Token => $token");
  }
}