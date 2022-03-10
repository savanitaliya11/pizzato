// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Constant/constant.dart';
import 'package:pizzato/Views/home_screen.dart';
import 'package:pizzato/providers/loginsignin.dart';
import 'package:provider/provider.dart';

class Authentication extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Piz',
                  style: splashScreenlabelTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'z',
                        style: splashScreenlabelTextStyle.copyWith(
                            color: Colors.red)),
                    TextSpan(text: 'ato', style: splashScreenlabelTextStyle),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildElevatedButtonLogIn(context),
                    buildElevatedButtonSignIn(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButtonLogIn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35.0),
                    topLeft: Radius.circular(35.0))),
            builder: (BuildContext context) {
              return SizedBox(
                width: double.infinity,
                height: 450,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Enter Your Email'),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Enter Your Password'),
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              Provider.of<Auth>(context, listen: false)
                                  .loginUser(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) {
                                return Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: HomeScreen(),
                                        type: PageTransitionType.leftToRight));
                              });

                              _emailController.clear();
                              _passwordController.clear();
                            },
                            child: Text('LogIn',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25))),
                      ],
                    ),
                  ),
                ),
              );
            },
            context: context);
      },
      child: Text('Login'),
    );
  }

  ElevatedButton buildElevatedButtonSignIn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35.0),
                    topLeft: Radius.circular(35.0))),
            builder: (BuildContext context) {
              return SizedBox(
                width: double.infinity,
                height: 450,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Enter Your Email'),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Enter Your Password'),
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              Provider.of<Auth>(context, listen: false)
                                  .singinUser(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) => Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: Authentication(),
                                          type:
                                              PageTransitionType.leftToRight)));

                              _emailController.clear();
                              _passwordController.clear();
                            },
                            child: Text('SignIn',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)))
                      ],
                    ),
                  ),
                ),
              );
            },
            context: context);
      },
      child: Text('SignIn'),
    );
  }
}
