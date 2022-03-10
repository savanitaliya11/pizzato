// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzato/Constant/constant.dart';
import 'package:pizzato/Services/managedata.dart';
import 'package:pizzato/Views/splash_screen.dart';
import 'package:provider/provider.dart';

class Calculation with ChangeNotifier {
  int cheeseValue = 0, beaconValue = 0, onionValue = 0, cartData = 0;
  String? size;
  String? get getSize => size;

  bool isSelected = false;
  bool smallSelected = false;
  bool mediumSelected = false;
  bool largeSelected = false;
  bool selected = false;

  int get getChesseValue => cheeseValue;
  int get getBeaconValue => beaconValue;
  int get getOnionValue => onionValue;
  int get getCartValue => cartData;
  bool get getSelected => selected;

  addCheese() {
    cheeseValue++;
    notifyListeners();
  }

  addBeacon() {
    beaconValue++;
    notifyListeners();
  }

  addOnion() {
    onionValue++;
    notifyListeners();
  }

  minusCheese() {
    if (cheeseValue > 0) {
      cheeseValue--;
    }

    notifyListeners();
  }

  minusBeacon() {
    if (beaconValue > 0) {
      beaconValue--;
    }
    notifyListeners();
  }

  minusOnion() {
    if (onionValue > 0) {
      onionValue--;
    }
    notifyListeners();
  }

  selectSmallSize() {
    smallSelected = true;
    size = 'S';
    notifyListeners();
  }

  selectMediumSize() {
    mediumSelected = true;
    size = 'M';
    notifyListeners();
  }

  selectLargeSize() {
    largeSelected = true;
    size = 'L';
    notifyListeners();
  }

  removeAllData() {
    cheeseValue = 0;
    beaconValue = 0;
    onionValue = 0;
    mediumSelected = false;
    largeSelected = false;
    smallSelected = false;
    notifyListeners();
  }

  addToCart(BuildContext context, dynamic data) {
    if (smallSelected != false ||
        largeSelected != false ||
        mediumSelected != false) {
      cartData++;
      Provider.of<ManageData>(context, listen: false)
          .submitData(context, data)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Ordered',
                style: shippindetailTextStyle.copyWith(
                    color: Colors.black, fontSize: 30),
              ))));
      notifyListeners();
    } else {
      showModalBottomSheet(
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                'Please select Size',
                style: shippindetailTextStyle,
              ),
            );
          },
          context: context);
    }
  }

  delData(BuildContext context, d) {
    Provider.of<ManageData>(context, listen: false).getUid() == null
        ? cartData = 0
        : null;
    notifyListeners();
  }
}
