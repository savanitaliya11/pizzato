// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Services/managedata.dart';
import 'package:pizzato/Views/detailScreen.dart';
import 'package:provider/provider.dart';

class MiddleHelper extends ChangeNotifier {
  Widget textFav() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        text: TextSpan(
            text: 'Favourite',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              shadows: [BoxShadow(color: Colors.black, blurRadius: 1)],
            ),
            children: <TextSpan>[
              TextSpan(
                  text: ' dishes?',
                  style: TextStyle(
                      shadows: [BoxShadow(blurRadius: 0)],
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.grey))
            ]),
      ),
    );
  }

  Widget dataFav(BuildContext context, String collection) {
    return SizedBox(
      height: 300,
      child: FutureBuilder(
        future: Provider.of<ManageData>(context).fetchData(collection),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Lottie.asset('assets/delivery.json');
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: DetailScreen(
                          queryDocumentSnapshot: snapshot.data[index],
                        ),
                        type: PageTransitionType.topToBottom),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.grey.shade500,
                              spreadRadius: 3)
                        ],
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              child: Center(
                                child: Image.network(
                                  '${snapshot.data[index].data()['image']}',
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 105,
                                left: 148.0,
                                child: IconButton(
                                  icon: Icon(
                                    EvaIcons.heart,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 6),
                          child: Text(
                            '${snapshot.data[index].data()['name']}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            '${snapshot.data[index].data()['category']}',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    '${snapshot.data[index].data()['ratings']}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${snapshot.data[index].data()['price']}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget textBusiness() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        text: TextSpan(
            text: 'Business',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              shadows: [BoxShadow(color: Colors.black, blurRadius: 1)],
            ),
            children: <TextSpan>[
              TextSpan(
                  text: ' dishes?',
                  style: TextStyle(
                      shadows: [BoxShadow(blurRadius: 0)],
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.grey))
            ]),
      ),
    );
  }

  Widget dataBusiness(BuildContext context, String collection) {
    return FutureBuilder(
      future: Provider.of<ManageData>(context).fetchData(collection),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Lottie.asset('assets/delivery.json');
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: DetailScreen(
                        queryDocumentSnapshot: snapshot.data[index],
                      ),
                      type: PageTransitionType.topToBottom),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey.shade500,
                            spreadRadius: 3)
                      ],
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data[index].data()['name']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${snapshot.data[index].data()['oldprice']}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '${snapshot.data[index].data()['price']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
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
                                  '${snapshot.data[index].data()['ratings']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.network(
                          '${snapshot.data[index].data()['image']}',
                          height: 150,
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
