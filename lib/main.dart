// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizzato/Helpers/footer.dart';
import 'package:pizzato/Helpers/generateMaps.dart';
import 'package:pizzato/Helpers/headers.dart';
import 'package:pizzato/Helpers/middleHelper.dart';
import 'package:pizzato/Helpers/payment_helper.dart';
import 'package:pizzato/Services/managedata.dart';
import 'package:pizzato/Views/splash_screen.dart';
import 'package:pizzato/providers/calculations.dart';
import 'package:pizzato/providers/loginsignin.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

///Hello World!!!!
//How Are You????

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Headers()),
        ChangeNotifierProvider.value(value: MiddleHelper()),
        ChangeNotifierProvider.value(value: ManageData()),
        ChangeNotifierProvider.value(value: Fotters()),
        ChangeNotifierProvider.value(value: GenerateMaps()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Calculation()),
        ChangeNotifierProvider.value(value: PaymentHelper()),
      ],
      child: MaterialApp(
        home: MyHome(),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}
