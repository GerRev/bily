import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/account_page.dart';
import 'payment_page.dart';



class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            tabs: [
              Text('Account Details'),
              Text('Payment Details')
            ],
          ),
          title: Text('My Details',style: TextStyle(color: Colors.black, fontSize: 24)),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
          //  AccountPage(),
            PaymentPage(),
          ],
    ),
    ),
    );

  }
}


