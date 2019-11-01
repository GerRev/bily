import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_demo/business.dart';
import 'user_data.dart';
import 'auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {




  final myController = TextEditingController();
  bool visible= false;


  void onPhonePressed(String value) {
    var userData = AuthProvider.of(context).userData;

    setState(() {
      userData.phoneNumber = value;

      userData.syncDataUp();


    });
  }
  

  

  Widget _buildDropdownItem(Country country) => Container(
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8.0,
        ),
        Text("+${country.phoneCode}(${country.isoCode})"),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Hero(
              tag: 'logo',
              child: Image.asset(
                'images/logo.png',
                //width: 10,
                color: Theme.of(context).primaryColor,
                //height: 100,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top:40),
              child: Column(
                  children:[ Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[ CountryPickerDropdown(
                        initialValue: 'ie',
                        itemBuilder: _buildDropdownItem,
                        onValuePicked: (Country country) {
                          print("${country.name}");
                        },
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              visible=true;
                            });
                            print("First text field: $text");
                          },

                          controller: myController,
                          decoration: new InputDecoration(labelText: "Enter your number"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      ]
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Padding(
                      padding: const EdgeInsets.only(top:32.0),
                      child: Visibility(
                        visible: visible,
                        child: IconButton(

                            icon: Icon(Icons.arrow_forward,size: 32,),
                            onPressed:(){
                              String value= Text(myController.text).data;
                              if(value==null || value==''){
                                Fluttertoast.showToast(
                                    msg: 'You need to enter a number ',
                                    backgroundColor: Theme.of(context).primaryColor);

                              }

                              else {
                              onPhonePressed(value);
                              print("########################### Adding Phone number $value ");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Business()),
                              );
                            }}),
                      ),

                    ),
            ]
                  )
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myController.addListener(_printLatestValue);

  }
  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }
}

