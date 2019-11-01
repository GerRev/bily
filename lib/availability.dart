import 'package:cloud_firestore/cloud_firestore.dart';


class Availabilty {
  List availableDates = [];
  String bandId;
  String id;

  Availabilty({this.availableDates, this.bandId});


  Availabilty.from(DocumentSnapshot snapshot)
      :

        id = snapshot.documentID,
        availableDates= snapshot['availableDates'],
        bandId= snapshot['bandId'];


  Map<String, dynamic> toJson() {
    return {
      'availableDates': availableDates,
      'bandId': bandId,
    };
  }
}
