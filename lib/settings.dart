import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/account_page.dart';
import 'payment_page.dart';
import 'add_card.dart';



class SettingTabs extends StatefulWidget {
  @override
  _SettingTabsState createState() => _SettingTabsState();
}

class _SettingTabsState extends State<SettingTabs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColorDark, //change your color here
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              tabs: [
                Text('Account Details',style: Theme.of(context).textTheme.subhead,),
                Text('Payment Details',style: Theme.of(context).textTheme.subhead,)
              ],
            ),

            title: Text('MY DETAILS',style: Theme.of(context).textTheme.title),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Settings(),
              AddCard(),
            ],
      ),
      ),
      ),
    );

  }
}


