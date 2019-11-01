import 'package:flutter/material.dart';
import 'header.dart';
import 'events_tab.dart';
import 'videoTab.dart';
import 'calendar_tab.dart';


class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColorDark
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text('MY PAGE',style: Theme.of(context).textTheme.title,),
              bottom: TabBar(
          tabs: [
          Tab(icon: Icon(Icons.landscape,color: Color(0xff212121),)),
        Tab(icon: Icon(Icons.event,color: Color(0xff212121))),
        Tab(icon: Icon(Icons.video_library,color: Color(0xff212121))),
        ],
        ),

          ),
  body:TabBarView(
        children: [
        Header(),
        EventsTab(),
        VideoTab(),

        ],
      ),
        ),
      ),
    );
  }
}
