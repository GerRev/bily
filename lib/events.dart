import 'package:cloud_firestore/cloud_firestore.dart';


class Events {
  String location;
  String event= '';
  DateTime date;
  String service;
  String id;
  String bandId;


  Events({
    this.location, this.event, this.date, this.service, this.id,this.bandId});

  Events.from(DocumentSnapshot snapshot):

  id = snapshot.documentID,
  event= snapshot['event'],
  date= snapshot['date'],
  service= snapshot['service'],
  location= snapshot['location'],
  bandId= snapshot['bandId'];


  Map<String,dynamic> toJson() {

    return {
      'event': event,
      'date': date,
      'bandId': bandId,
      'service': service,
      'location':location,

    };
  }
}