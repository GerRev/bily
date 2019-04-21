import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_demo/business.dart';
import 'user_data.dart';
import 'auth_provider.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {


  final myController = TextEditingController();


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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top:100),
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
                    child: InkWell(

                        child: Text('Next',style: TextStyle(color: Color(0xff7D9EE9),fontSize: 22),),
                        onTap:(){
                          var value= Text(myController.text).data;
                          onPhonePressed(value);
                          print("########################### Adding Phone number $value ");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Business()),
                          );
                        }),

                  ),
          ]
                )
                ]
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

