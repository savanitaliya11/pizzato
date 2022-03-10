// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzato/Helpers/generateMaps.dart';

import 'package:pizzato/Helpers/headers.dart';
import 'package:pizzato/Helpers/footer.dart';
import 'package:pizzato/Helpers/middleHelper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<GenerateMaps>(context, listen: false).getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Fotters().flotingActionButton(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Headers().appBar(context),
                Headers().headerText(),
                Headers().headerMenu(),
                Divider(),
                MiddleHelper().textFav(),
                MiddleHelper().dataFav(context, 'favourite'),
                MiddleHelper().textBusiness(),
                MiddleHelper().dataBusiness(context, 'business'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
