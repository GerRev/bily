import 'package:flutter/material.dart';
import 'youtube_page.dart';

class CustomCard1 extends StatelessWidget {
  CustomCard1({@required this.link, this.description});

  final link;
  final description;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                Text(link),
              ],
            )));
  }
}