// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  dynamic error;
  dynamic get getErrormessage => error;
  dynamic? userid;
  dynamic? getmailId;
  String? get getuId => userid;
  String? get getmail => getmailId;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginUser({String? email, String? password}) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email!, password: password!);

    User? user = userCredential.user;
    userid = user?.uid;
    getmailId = user?.email;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('uqid', userid);
    sharedPreferences.setString('getmail', getmailId);
    log('LOGIN======>>>>>${userid}');
    log('LOGIN======>>>>>${getmailId}');
    notifyListeners();
  }

  Future singinUser({String? email, String? password}) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email!, password: password!);

    User? user = userCredential.user;
    userid = user?.uid;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('uqid', userid);
    sharedPreferences.setString('getmail', getmailId);
    log('SIGNIN======>>>>>${userid}');
    log('SIGNIN======>>>>>${getmailId}');
    notifyListeners();
  }
}
