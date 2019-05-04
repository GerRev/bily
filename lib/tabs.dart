import 'package:flutter/material.dart';
import 'header.dart';
import 'events_tab.dart';
import 'videoTab.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('My Page'),
            bottom: TabBar(
        tabs: [
        Tab(icon: Icon(Icons.landscape)),
      Tab(icon: Icon(Icons.event)),
      Tab(icon: Icon(Icons.video_library)),
      ],
      ),

        ),
  body:TabBarView(
      children: [
      Header(),
      EventsTab(),
      VideoTab()
      ],
    ),
      ),
    );
  }
}
