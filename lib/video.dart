import 'package:cloud_firestore/cloud_firestore.dart';


class Video {
  String link;
  String id;
  String bandId;


  Video({this.link, this.id, this.bandId});

  Video.from(DocumentSnapshot snapshot)
      :

        id = snapshot.documentID,
        link =snapshot['link'],
        bandId= snapshot['bandId'];


  Map<String, dynamic> toJson() {
    return {
      'bandId': bandId,
      'link': link,
      bandId: bandId,

    };
  }


}
