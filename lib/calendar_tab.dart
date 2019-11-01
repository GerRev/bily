import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class CalendarPage2 extends StatefulWidget {
  @override
  _CalendarPage2State createState() => new _CalendarPage2State();
}

List<DateTime> presentDates = [];

class _CalendarPage2State extends State<CalendarPage2> {
  String identifier;

  Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  getCalendarEventList() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('availableDates')
          .where('bandId', isEqualTo: user.uid)
          .snapshots()
          .listen((data) => data.documents.forEach((doc) => setState((){
        _markedDateMap.add(
            doc['availableDates'].toDate(),
            Event(
                date: doc['availableDates'].toDate(),
                title: 'hello',
                icon: _presentIcon(
                    doc['availableDates'].toDate().day.toString())));


      })
      ));

    }).catchError((onError) {});
  }

  @override
  void initState() {
    getCalendarEventList();
    super.initState();
    print(_markedDateMap);
  }

  Widget _presentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(1000),
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorDark, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Hero(
              tag: 'logo',
              child: Image.asset(
                'images/logo.png',
                //width: 10,
                color: Theme.of(context).primaryColor,
                //height: 100,
              )),
        ),
        body: _calendarCarouselNoHeader = CalendarCarousel<Event>(
          thisMonthDayBorderColor: Theme.of(context).primaryColorDark,
          //todayBorderColor: Colors.red,
          headerText: Text('dates'),
          todayButtonColor: Theme.of(context).accentColor,
          headerTextStyle:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
          iconColor: Theme.of(context).primaryColor,
          prevMonthDayBorderColor: Theme.of(context).primaryColor,
          nextMonthDayBorderColor: Theme.of(context).primaryColor,
          showOnlyCurrentMonthDate: true,
          daysTextStyle: TextStyle(color: Theme.of(context).primaryColorDark),
          weekdayTextStyle: TextStyle(color: Colors.black),

          weekendTextStyle: TextStyle(
            color: Theme.of(context).accentColor,
          ),

          markedDatesMap: _markedDateMap,
          markedDateShowIcon: true,
          markedDateIconMaxShown: 1,
          markedDateMoreShowTotal:
              null, // null for not showing hidden events indicator
          markedDateIconBuilder: (event) {
            return event.icon;
          },
          onDayPressed: (DateTime date, List<Event> events) {
            this.setState(() => refresh(date));
          },
        ),
      ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        // radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }

  refresh(DateTime date) async {
    if (_markedDateMap.getEvents(date).isEmpty) {
      await FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('availableDates')
            .add({'availableDates': date, 'bandId': user.uid});
        print('££££ $identifier ££££');
        setState(() {
          _markedDateMap.add(
              date,
              Event(
                  date: date,
                  title: '',
                  icon: _presentIcon(date.day.toString())));
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_SHORT,
              msg: DateFormat('dd MMM')
                  .format(date) + ' Added to schedule',




              fontSize: 14,
              backgroundColor: Theme.of(context).primaryColorDark,
              textColor: Colors.white);
        });
      });
    } else {
      print('Events exist here');

      setState(() {
        Firestore.instance
            .collection('availableDates')
            .where('availableDates', isEqualTo: date)
            .getDocuments()
            .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.documents) {
            ds.reference.delete();
            Fluttertoast.showToast(
                toastLength: Toast.LENGTH_SHORT,
                msg: DateFormat('dd MMM')
                    .format(date) + ' Removed from schedule',

                fontSize: 14,
                backgroundColor: Theme.of(context).primaryColorDark,
                textColor: Colors.white);
          }
        });
        _markedDateMap.removeAll(date);
      });
    }
  }
}
