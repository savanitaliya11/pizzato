// ignore_for_file: prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizzato/Views/splash_screen.dart';
import 'package:pizzato/providers/calculations.dart';
import 'package:pizzato/providers/loginsignin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageData extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  GoogleMapController? googleMapController;

  Future fetchData(String collection) async {
    QuerySnapshot querySnapshot =
        await _firebaseFirestore.collection(collection).get();
    return querySnapshot.docs;
  }

  Future submitData(BuildContext context, dynamic data) async {
    await FirebaseFirestore.instance
        .collection('myOrders')
        .doc(Provider.of<Auth>(context, listen: false).getuId)
        .set(data);
    notifyListeners();
  }

  Future deleteData(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('myOrders')
        .doc(Provider.of<Auth>(context, listen: false).getuId)
        .delete();

    notifyListeners();
  }

  Future getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dynamic a = sharedPreferences.getString('uqid');
    print('shared==>>>${a}');
  }
}
