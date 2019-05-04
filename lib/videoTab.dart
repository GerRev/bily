import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'custom_card1.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth_provider.dart';
import 'video.dart';
class VideoTab extends StatefulWidget {


  @override
  _VideoTabState createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  TextEditingController videosTitleInputController;
  TextEditingController videosDescripInputController;
  String identifier;


  @override
  initState() {
    videosTitleInputController = new TextEditingController();
    videosDescripInputController = new TextEditingController();
    super.initState();

  }

  @override
  void didChangeDependencies() {
    identifier= AuthProvider.of(context).userData.userId;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Videos').where("bandId", isEqualTo: identifier).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {

                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {

                        return Dismissible(
                          key: new Key(document.documentID),
                          onDismissed: (direction){
                            Firestore.instance.runTransaction((transaction) async {
                              DocumentSnapshot snapshot=
                              await transaction.get(document.reference);
                              await transaction.delete(snapshot.reference);


                            });
                            Fluttertoast.showToast(msg: "Event Deleted");
                          },
                          child: new YoutubePlayer(

                            autoPlay: false,
                            videoId: document['link'],
                           context: context,
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Text("Please fill all fields to create a new video"),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Enter Youtube Link*'),
                controller: videosTitleInputController,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                videosTitleInputController.clear();
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Add'),
              onPressed: () {

                if(videosTitleInputController.text.isNotEmpty){

                  setState(() {
                    videosTitleInputController.text= YoutubePlayer.convertUrlToId(videosTitleInputController.text);

                  });


                  Firestore.instance.collection('Videos').add({'link':videosTitleInputController.text,
                    'bandId': AuthProvider.of(context).userData.userId,})
                      .then((result) =>{
                  Fluttertoast.showToast(msg: "Video Uploaded",fontSize: 24),
                  Navigator.pop(context),
                  videosDescripInputController.clear(),
                  videosTitleInputController.clear(),
                  }).catchError((err) => Fluttertoast.showToast(msg: "Update success"));





                }else{
                  Fluttertoast.showToast(msg: "All fields need to be filled out!",fontSize: 24);
                }



              })
        ],
      ),
    );
  }
}
