import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Views/my_cart.dart';

class Fotters extends ChangeNotifier {
  Widget flotingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.redAccent,
      onPressed: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: MyCart(), type: PageTransitionType.bottomToTop));
      },
      child: Icon(
        Icons.shopping_bag_outlined,
        color: Colors.black,
      ),
    );
  }
}
