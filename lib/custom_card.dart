import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.event, this.location, this.date, this.service});

  final event;
  final location;
  final date;
  final service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:20,right:20,top:20),
      child: Card(
        elevation: 14,
          child: Container(
            padding: EdgeInsets.all(10),
              color: Colors.white,
               height: 200,
              //padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                      Icon(
                        Icons.event_note,
                        color: Theme.of(context).primaryColor,
                      ),
                     Padding(
                       padding: const EdgeInsets.only(left:10.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Event Type",style: Theme.of(context).textTheme.subhead,),
                           Text(event,style: Theme.of(context).textTheme.subtitle,)
                         ],
                       ),
                     )
                    ]),
                    Row(children: [
                      Icon(
                        Icons.event,
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("Event Date",style: Theme.of(context).textTheme.subhead,),
                              Text(DateFormat('yyyy-MM-dd').format(date),style: Theme.of(context).textTheme.subtitle,)]),
                      )
                    ]),

                    Row(children: [
                      Icon(Icons.location_on,color:Theme.of(context).primaryColor,),
                     Padding(
                       padding: const EdgeInsets.only(left: 10),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Location',style: Theme.of(context).textTheme.subhead,),
                           Text(location,style: Theme.of(context).textTheme.subtitle,),
                         ],
                       ),
                     )
                    ]),
                    Row(
                        children: [Icon(Icons.room_service,color: Theme.of(context).primaryColor,),Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                      Text('Service',style: Theme.of(context).textTheme.subhead,),
                      Text(service,style: Theme.of(context).textTheme.subtitle,)]),
                        )]),
                  ],

                ),

              ]))),
    );
  }
}
