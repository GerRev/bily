import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/my_flutter_app_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth_provider.dart';
import 'package:flutter_chat_demo/account_page.dart';
import 'settings.dart';
import 'my_page.dart';
import 'package:flutter_chat_demo/tabs.dart';

class BottomNavigationBarRecipe extends StatefulWidget {
  final String title;

  BottomNavigationBarRecipe({Key key, this.title}) : super(key: key);

  @override
  _BottomNavigationBarRecipeState createState() =>
      _BottomNavigationBarRecipeState();
}

class _BottomNavigationBarRecipeState extends State<BottomNavigationBarRecipe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Inbox",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
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
                            backgroundColor: Colors.blue);
                      },
                      child: Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text('Today'),
                Center(
                    child: Icon(
                  Icons.landscape,
                  size: 400,
                  color: Colors.grey,
                ))
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
          const ListTile(
            //Add menu item to add a new item
            leading: const Icon(Icons.book, color: Colors.orange, size: 26),
            title: const Text('Bookings'),
          ),
          const ListTile(
            //Add menu item to add a new item
            leading: const Icon(Icons.calendar_today, color: Colors.blue, size: 26),
            title: const Text('Calendar'),
          ),
          FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));

            },
            child: const ListTile(
              //Add menu item to add a new item
              leading: const Icon(Icons.settings, color: Colors.grey, size: 26),
              title: const Text('Settings'),
            ),
          ),

        ],
      ),
    );
  }
}
