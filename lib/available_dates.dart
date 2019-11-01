import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableDates {
  DateTime availableDates;


  AvailableDates({
    this.availableDates,
  });

  AvailableDates.from(DocumentSnapshot snapshot)
      : availableDates = snapshot['availableDates'];

  Map<String, dynamic> toJson() {
    return {'availableDates': availableDates};
  }
}
