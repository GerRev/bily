import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/my_flutter_app_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth_provider.dart';
import 'package:flutter_chat_demo/account_page.dart';
import 'settings.dart';
import 'my_page.dart';
import 'package:flutter_chat_demo/tabs.dart';
import 'add_card.dart';
import 'calendar_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart';

class BottomNavigationBarRecipe extends StatefulWidget {
  final String title;
  final String currentUserId;

  BottomNavigationBarRecipe({Key key, this.title,@required this.currentUserId}) : super(key: key);

  @override
  _BottomNavigationBarRecipeState createState() =>
      _BottomNavigationBarRecipeState();
}

class _BottomNavigationBarRecipeState extends State<BottomNavigationBarRecipe> {

  FirebaseMessaging _messaging= FirebaseMessaging();
  String currentUserId;
  String token;


  @override
  void didChangeDependencies() {
    currentUserId=AuthProvider.of(context).userData.userId;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inbox",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'filters not implemented yet',
                              textColor: Colors.white,
                              backgroundColor: Colors.blue);
                        },
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'filters not implemented yet',
                              textColor: Colors.white,
                              backgroundColor: Colors.blue);
                        },
                        child: Icon(
                          Icons.event_available,
                          color: Colors.grey,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.pink,
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'filters not implemented yet',
                              textColor: Colors.white,
                              backgroundColor: Colors.blue);
                        },
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                      ),
                      InkWell(
                        //highlightColor: Colors.yellow,
                        splashColor: Colors.yellow,
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'filters not implemented yet',
                              textColor: Colors.white,
                              backgroundColor: Colors.blue);
                        },
                        child: Icon(
                          Icons.file_download,
                          color: Colors.grey,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.orange,
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'filters not implemented yet',
                              textColor: Colors.white,
                              backgroundColor: Colors.white);
                        },
                        child: Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Text('Today'),
                  SizedBox(
                    height: 300,
                    child: Container(
                      child: StreamBuilder(
                        stream: Firestore.instance.collection('customers').where("sender1", arrayContains: currentUserId).orderBy('timestamp',descending: true).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
                            return Column(
                              children: [Center(
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: FlareActor(
                                    "images/bear.flr", animation:"fail",
                                  ),
                                ),
                              ),
                                SizedBox(height: 20,),
                                FadeAnimatedTextKit(

                                    text: [
                                      "Inbox Empty"
                                    ],
                                    textStyle: TextStyle(fontSize: 22),

                                    //textAlign: TextAlign.start,
                                    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                                ),
                            ]);
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.all(10.0),
                              itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
                              itemCount: snapshot.data.documents.length,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Bottom that pops up from the bottom of the screen.
              IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                onPressed: () {
                  showModalBottomSheet<Null>(
                    context: context,
                    builder: (BuildContext context) => openBottomDrawerDetails(),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                ),
                onPressed: () {
                  showModalBottomSheet<Null>(
                    context: context,
                    builder: (BuildContext context) => openBottomDrawerBookings(),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: 'Clicked on Search menu action.',
                      backgroundColor: Colors.blue,
                      textColor: Colors.white);
                },
              ),
            ],
          )),
        ),
      ),
    );
  }

  //This drawer is opened in modal bottom sheet
  Widget openBottomDrawerBookings() {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),

          //Add menu item to edit
          const ListTile(
            leading: const Icon(
              MyFlutterApp.fire,
              color: Colors.blue,
              size: 28,
            ),
            title: const Text('Add new lead'),
          ),
          const ListTile(
            //Add menu item to add a new item
            leading: const Icon(Icons.book, color: Colors.green, size: 28),
            title: const Text('Generate Confirmed Booking'),
          ),
          const ListTile(
            //Add menu item to add a new item
            leading: const Icon(Icons.book, color: Colors.orange, size: 28),
            title: const Text('Generate Provisional Booking'),
          ),
          const ListTile(
            //Add menu item to add a new item
            leading: const Icon(Icons.gavel, color: Colors.purple, size: 28),
            title: const Text('Generate Quote'),
          ),
        ],
      ),
    );
  }

  Widget openBottomDrawerDetails() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 10),
                decoration: AuthProvider.of(context).userData.avatarUrl != null
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              AuthProvider.of(context).userData.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )
                    : null,
                child: AuthProvider.of(context).userData.avatarUrl != null
                    ? null
                    : Icon(Icons.account_circle),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                AuthProvider.of(context).userData.name,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'admin',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ]),
          ]),

          //Add menu item to edit
          const ListTile(
            leading: const Icon(
              Icons.inbox,
              color: Colors.blue,
              size: 28,
            ),
            title: const Text('Inbox'),
          ),
          FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Tabs()));
            },
            child: const ListTile(
              //Add menu item to add a new item
              leading:
                  const Icon(Icons.account_box, color: Colors.green, size: 26),
              title: const Text('My Page'),
            ),
          ),

          FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage2()));

            },
            child: const ListTile(
              //Add menu item to add a new item
              leading: const Icon(Icons.calendar_today, color: Colors.blue, size: 26),
              title: const Text('Calendar'),
            ),
          ),
          FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingTabs()));

            },
            child: const ListTile(
              //Add menu item to add a new item
              leading: const Icon(Icons.details, color: Colors.grey, size: 26),
              title: const Text('Details'),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document['userId'] == currentUserId) {
      print('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW $currentUserId');
      return Container();
    } else {
      print('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW $currentUserId');
      return GestureDetector(

        onTap: () {




          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat(
                    peerId: document.documentID,
                    peerAvatar: document['avatarUrl']
                  )));
        },

        child: Container(
          padding: EdgeInsets.all(0),
          width: double.maxFinite,
          height: 98,
          child: Column(
            children:[ Row(
              children: <Widget>[
                Material(
                  child: CachedNetworkImage(
                    
                    placeholder: (context, url) => Container(
                      padding: EdgeInsets.all(0),
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ),
                      width: 50.0,
                      height: 50.0,
                    ),
                    imageUrl: document['avatarUrl'],
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  clipBehavior: Clip.hardEdge,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${document['name']}',
                      style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        'About me: ${document['aboutMe'] ?? 'Not available'}',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    ),
                  ],
                ),
                Spacer(),

                Text(
                  DateFormat('dd MMM kk:mm')
                      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document['timestamp']))),
                  style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 12.0, fontStyle: FontStyle.italic),
                ),


              ],

            ),

                ]
          ),
         // margin: EdgeInsets.only(bottom: 10.0,),
        ),
      );
    }
  }
  void addToken(String registrationTokens) async{
    var userData = AuthProvider.of(context).userData;


      userData.registrationTokens = await registrationTokens;

      userData.syncDataUp();


  }

  @override
  void initState() {
    onLaunch: (Map<String, dynamic> message) async {
      print("££££££££££££££££££££££££onLaunch: $message");
    };

    _messaging.configure();

    _messaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _messaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _messaging.getToken().then((registrationTokens){

      addToken(registrationTokens);

    });



  }


}
