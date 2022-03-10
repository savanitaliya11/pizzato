// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Views/home_screen.dart';
import 'package:pizzato/Views/my_cart.dart';
import 'package:pizzato/providers/calculations.dart';
import 'package:pizzato/providers/loginsignin.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  late final QueryDocumentSnapshot queryDocumentSnapshot;
  DetailScreen({required this.queryDocumentSnapshot});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

int Cheese = 0;
int Onion = 0;
int Beacon = 0;
int cartdata = 0;

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(context),
            PizzaImage(context),
            middleData(context),
            fotterDetail(context)
          ],
        ),
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
            Provider.of<Calculation>(context, listen: false).removeAllData();
          },
          icon: Icon(
            FontAwesomeIcons.trash,
            size: 30,
          ),
          color: Colors.red,
        ),
      ],
    );
  }

  Widget PizzaImage(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Center(
        child: Image.network(
          widget.queryDocumentSnapshot['image'],
          height: 250,
          width: 250,
        ),
      ),
    );
  }

  Widget middleData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star,
                  size: 30,
                  color: Colors.yellow,
                )),
            Text(
              widget.queryDocumentSnapshot['ratings'],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 10),
              child: Text(
                widget.queryDocumentSnapshot['name'],
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, right: 10),
              child: Text(
                widget.queryDocumentSnapshot['price'],
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget fotterDetail(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Stack(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 15),
                    child: Text(
                      'Add More Stuff',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cheese',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 25),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Provider.of<Calculation>(context, listen: false)
                                  .addCheese();
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            Provider.of<Calculation>(context, listen: true)
                                .getChesseValue
                                .toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<Calculation>(context, listen: false)
                                  .minusCheese();
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Beacon',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 25),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Provider.of<Calculation>(context, listen: false)
                                  .addBeacon();
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            Provider.of<Calculation>(context, listen: true)
                                .getBeaconValue
                                .toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<Calculation>(context, listen: false)
                                  .minusBeacon();
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Onion',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 25),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Provider.of<Calculation>(context, listen: false)
                                  .addOnion();
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            Provider.of<Calculation>(context, listen: true)
                                .getOnionValue
                                .toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<Calculation>(context, listen: false)
                                  .minusOnion();
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<Calculation>(context, listen: false)
                        .selectSmallSize();
                  },
                  child: Container(
                    height: 30,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent),
                      color: Provider.of<Calculation>(context, listen: true)
                              .smallSelected
                          ? Colors.red
                          : Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      'S',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Calculation>(context, listen: false)
                        .selectMediumSize();
                  },
                  child: Container(
                    height: 30,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent),
                      color: Provider.of<Calculation>(context, listen: true)
                              .mediumSelected
                          ? Colors.red
                          : Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      'M',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Calculation>(context, listen: false)
                        .selectLargeSize();
                  },
                  child: Container(
                    height: 30,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent),
                      color: Provider.of<Calculation>(context, listen: true)
                              .largeSelected
                          ? Colors.red
                          : Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      'L',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget floatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 130),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<Calculation>(context, listen: false)
                  .addToCart(context, {
                'image': widget.queryDocumentSnapshot['image'],
                'name': widget.queryDocumentSnapshot['name'],
                'price': widget.queryDocumentSnapshot['price'],
                'ratings': widget.queryDocumentSnapshot['ratings'],
                'onion': Provider.of<Calculation>(context, listen: false)
                    .getOnionValue,
                'beacon': Provider.of<Calculation>(context, listen: false)
                    .getBeaconValue,
                'cheese': Provider.of<Calculation>(context, listen: false)
                    .getChesseValue,
                'size':
                    Provider.of<Calculation>(context, listen: false).getSize,
                'Uid': Provider.of<Auth>(context, listen: false).getuId,
                'datetime': DateTime.now()
              });
            },
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(30.0)),
              height: 50,
              child: Center(
                  child: Text(
                'Add To Cart',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: MyCart(),
                            type: PageTransitionType.bottomToTop));
                  },
                  child: Icon(
                    Icons.shopping_basket,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                right: 1,
                bottom: 35,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 10,
                  child: Center(
                    child: Text(
                      '${Provider.of<Calculation>(context, listen: false).cartData}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
