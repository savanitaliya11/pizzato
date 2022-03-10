// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_returning_null_for_void

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizzato/providers/loginsignin.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Constant/constant.dart';
import 'package:pizzato/Constant/utility.dart';
import 'package:pizzato/Helpers/generateMaps.dart';
import 'package:pizzato/Helpers/payment_helper.dart';

import 'package:pizzato/MiniViews/area.dart';
import 'package:pizzato/Services/managedata.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Razorpay? razorpay;
  LatLng? currentPostion;

  dynamic total = 0.0;

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
      Utility.latLng = currentPostion!;
    });
    var address =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = address[0];
    dynamic mainAdd = '${place.street},${place.subLocality}, ${place.locality}';
    finalAdd = mainAdd;
  }

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        Provider.of<PaymentHelper>(context, listen: false).handlPaymentSuccess);

    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR,
        Provider.of<PaymentHelper>(context, listen: false).handlPaymentError);

    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET,
        Provider.of<PaymentHelper>(context, listen: false).handlExternalWaller);
    _getUserLocation();
    super.initState();
  }

  Future checkMeOut() async {
    var options = {
      'key': 'rzp_test_K4ZHnLrH5PdeTc',
      'amount': total,
      'name': Provider.of<Auth>(context, listen: false).getmailId,
      'description': 'payment',
      'prefill': {
        'contact': '1234567890',
        'email': Provider.of<Auth>(context, listen: false).getmailId,
      },
      'external': {
        'wallet': ['paytm']
      }
    };
    try {
      razorpay!.open(options);
    } catch (e) {
      print('ERROE===>>>${e.toString()}');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(context),
              header(context),
              cart(context),
              // shippingDetails(context),
              billingData(context),
            ],
          ),
        ),
      ),
    );
  }

  Row purchasedView(DocumentSnapshot<Object?> documentSnapshot) {
    return Row(
      children: [
        SizedBox(
            child: Image.network(
          documentSnapshot.get('image'),
          height: 200,
          width: 200,
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${documentSnapshot.get('name')}',
              style: shippindetailTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Price: ${documentSnapshot.get('price')}',
              style: shippindetailTextStyle.copyWith(
                  color: Colors.grey, fontSize: 25),
            ),
            Text(
              'Cheese: ${documentSnapshot.get('cheese')}',
              style: shippindetailTextStyle.copyWith(
                  color: Colors.grey, fontSize: 20),
            ),
            Text(
              'Beacon: ${documentSnapshot.get('beacon')}',
              style: shippindetailTextStyle.copyWith(
                  color: Colors.grey, fontSize: 20),
            ),
            Text(
              'Onion: ${documentSnapshot.get('onion')}',
              style: shippindetailTextStyle.copyWith(
                  color: Colors.grey, fontSize: 20),
            ),
            Text(
              'Size: ${documentSnapshot.get('size')}',
              style: shippindetailTextStyle.copyWith(
                  color: Colors.red, fontSize: 18),
            ),
          ],
        )
      ],
    );
  }

  Widget cart(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35.0),
                  topLeft: Radius.circular(35.0))),
          context: context,
          builder: (context) {
            return SizedBox(
              width: double.infinity,
              height: 450,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 170),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      deliveryView(context,
                          icon: FontAwesomeIcons.clock,
                          function: () =>
                              Provider.of<PaymentHelper>(context, listen: false)
                                  .selectTime(context)),
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: Area(),
                                  type:
                                      PageTransitionType.leftToRightWithFade));
                          // iconButton(context, 'map');
                        },
                        child: Icon(FontAwesomeIcons.map),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          await checkMeOut();
                        },
                        child: Icon(FontAwesomeIcons.paypal),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('adminCollections')
                              .add({
                            'username':
                                Provider.of<Auth>(context, listen: false)
                                    .getmailId,
                            'time': Provider.of<PaymentHelper>(context,
                                    listen: false)
                                .deliveryTime
                                .format(context),
                            'location': Utility.finalAdd,
                          });
                        },
                        child: Text('Place Order'),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 3)
            ]),
        height: 300,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('myOrders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Lottie.asset(
                    'assets/delivery.json',
                  )),
                ],
              );
            } else {
              return ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot documentSnapshot) {
                  return purchasedView(documentSnapshot);
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  FloatingActionButton deliveryView(BuildContext context,
      {required IconData icon, required Function function}) {
    return FloatingActionButton(
      onPressed: () {
        function();
      },
      child: Icon(icon),
    );
  }

  Widget billingData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 3)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SUBTOTAL', style: billingTextStyle),
                    Text('\$320', style: billingTextStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivery Charge', style: billingTextStyle),
                    Text('\$20', style: billingTextStyle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Total',
                      style: billingTextStyle.copyWith(color: Colors.black),
                    ),
                    Text(
                      '\$340',
                      style: billingTextStyle.copyWith(color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 123, top: 115),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(30.0)),
                height: 50,
                child: Center(
                    child: Text(
                  'Place Order',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget shippingDetails(BuildContext context) {
  //   return Container(
  //     height: 140,
  //     margin: EdgeInsets.all(10),
  //     padding: EdgeInsets.all(10),
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(30),
  //         boxShadow: [
  //           BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 3)
  //         ]),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         addressView(context),
  //         timeView(context),
  //       ],
  //     ),
  //   );
  // }

  // Row timeView(BuildContext context) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Icon(FontAwesomeIcons.clock),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 10.0),
  //         child: Text('6AM - 7PM', style: shippindetailTextStyle),
  //       ),
  //       Spacer(),
  //       iconButton(context, 'time'),
  //     ],
  //   );
  // }

  // Row addressView(BuildContext context) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Icon(FontAwesomeIcons.locationArrow),
  //       SizedBox(
  //         width: 10,
  //       ),
  //       Expanded(
  //           child: Text("${Utility.finalAdd}", style: shippindetailTextStyle)),
  //       iconButton(context, 'map'),
  //     ],
  //   );
  // }

  // IconButton iconButton(BuildContext context, String onNavigation) {
  //   return IconButton(
  //       alignment: Alignment.topCenter,
  //       padding: EdgeInsets.zero,
  //       onPressed: () {
  //         if (onNavigation == 'map') {
  //           Navigator.pushReplacement(
  //               context,
  //               PageTransition(
  //                   child: Area(),
  //                   type: PageTransitionType.leftToRightWithFade));
  //         }
  //       },
  //       icon: Icon(EvaIcons.edit));
  // }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Your',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(
            'Cart',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 43),
          ),
        ],
      ),
    );
  }

  Widget AppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: HomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            )),
        IconButton(
          onPressed: () {
            Provider.of<ManageData>(context, listen: false).deleteData(context);
          },
          icon: Icon(
            FontAwesomeIcons.trash,
            size: 30,
          ),
          color: Colors.redAccent,
        ),
      ],
    );
  }
}

mixin JSONObject {}
