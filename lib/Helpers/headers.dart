// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Helpers/generateMaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzato/Views/authentication.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generateMaps.dart';

class Headers extends ChangeNotifier {
  String location = 'Null, Press Button';
  dynamic a;
  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () async {
                FirebaseAuth f = FirebaseAuth.instance;
                f.signOut();
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                        SnackBar(content: Text('Successfully LogOut')))
                    .closed
                    .then((value) => Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: Authentication())));
              },
              icon: Icon(Icons.logout)),
          Consumer<GenerateMaps>(
            builder: (BuildContext context, value, Widget? child) {
              return Row(
                children: [
                  GestureDetector(
                    child: Icon(FontAwesomeIcons.locationArrow),
                    onTap: () async {
                      Provider.of<GenerateMaps>(context, listen: false)
                          .getUserLocation();
                    },
                  ),
                  Text(
                      '${Provider.of<GenerateMaps>(context, listen: false).finalAdd}')
                ],
              );
            },
          ),
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.search)),
        ],
      ),
    );
  }

  Widget headerText() {
    return Container(
        constraints: BoxConstraints(maxWidth: 300.0),
        child: RichText(
          text: TextSpan(
              text: 'What would you like',
              style: TextStyle(color: Colors.black, fontSize: 29),
              children: <TextSpan>[
                TextSpan(
                    text: ' to eat?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: Colors.black))
              ]),
        ));
  }

  Widget headerMenu() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 45,
              width: 115,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.red)],
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey.shade100),
              child: Center(
                  child: Text(
                'All Food',
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 45,
              width: 115,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.green)],
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey.shade100),
              child: Center(
                  child: Text(
                'Pizza',
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 45,
              width: 115,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.purple)],
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey.shade100),
              child: Center(
                  child: Text(
                'Pasta',
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
