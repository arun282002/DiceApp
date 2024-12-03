import 'package:diceapp/Blog.dart';
import 'package:diceapp/Events.dart';
import 'package:diceapp/FAQS.dart';
import 'package:diceapp/HomePage.dart';
import 'package:diceapp/Quiz.dart';
import 'package:diceapp/Rewards.dart';
import 'package:diceapp/SplashScreen.dart';
import 'package:diceapp/Wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {


  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xffda3748),
        hintColor: Color(0xffffffff),
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        '/Home':(context)=>Homepage(),
        '/Rewards':(context)=>Rewards(),
        '/Events': (context) => Events(),
        '/FAQS': (context) => FAQS(),
        '/Blog': (context) => Blog(),
        '/Quiz': (context) => Quiz(),
        '/Wallpaper': (context) => Wallpaper(),
      },
      home: Splashscreen(),
    );
  }
}


