import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Helpers/generateMaps.dart';
import 'package:pizzato/Views/my_cart.dart';
import 'package:provider/provider.dart';

class Maps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          // Provider.of<GenerateMaps>(context).fetchMaps()
          // IconButton(
          //   icon: Icon(Icons.arrow_back_ios_outlined),
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //         context,
          //         PageTransition(
          //             child: MyCart(),
          //             type: PageTransitionType.leftToRightWithFade));
          //   },
          // ),
          // Positioned(
          //   top: 20,
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.login,
          //       color: Colors.red,
          //     ),
          //     onPressed: () {
          //       Navigator.pushReplacement(
          //           context,
          //           PageTransition(
          //               child: MyCart(),
          //               type: PageTransitionType.leftToRightWithFade));
          //     },
          //   ),
          // ),
        ],
      )),
    );
  }
}
