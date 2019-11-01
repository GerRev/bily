import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/add_event.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'custom_card.dart';
import 'auth_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class EventsTab extends StatefulWidget {
  @override
  _EventsTabState createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  String identifier;

  @override
  void didChangeDependencies() {
    identifier = AuthProvider.of(context).userData.userId;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DateAndTimePickerDemo()));
          }),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Events')
            .where("bandId", isEqualTo: identifier)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
            print('code here is being executed 1');
            return Column(
              children:[ Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: FlareActor(

                    "images/bear.flr",
                    animation: "fail",

                  ),
                ),
              ),
                SizedBox(height: 20,),
                FadeAnimatedTextKit(

                    text: [
                      "No Events"
                    ],
                    textStyle: TextStyle(fontSize: 22),

                    //textAlign: TextAlign.start,
                    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
           ] );


          }

          else {
            print('Code here is being executed');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                        child: Center(child: Icon(Icons.delete,color: Colors.white,)),
                      ),
                      key: new Key(document.documentID),
                      onDismissed: (direction) {
                        Firestore.instance.runTransaction((transaction) async {
                          DocumentSnapshot snapshot =
                              await transaction.get(document.reference);
                          await transaction.delete(snapshot.reference);
                        });
                        Fluttertoast.showToast(msg: "Event Deleted",backgroundColor: Theme.of(context).primaryColorDark,
                            textColor: Colors.white,fontSize: 14);
                      },
                      child: CustomCard(
                        event: document['event'],
                        location: document['location'],
                        service: document['service'],
                        date: document['date'].toDate(),
                      ),
                    );
                  }).toList(),
                );
            }
          }
        },
      ),
    );
  }
}
