import 'dart:async';

import 'package:diceapp/HomePage.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Homepage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffde9f2b ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Asserts/splashimg1.png")),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    child: Text(
                  "Welcome to Daily Dice Rewards",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                      textAlign: TextAlign.center,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
