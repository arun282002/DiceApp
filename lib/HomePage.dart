import 'package:diceapp/Blog.dart';
import 'package:diceapp/Events.dart';
import 'package:diceapp/FAQS.dart';
import 'package:diceapp/Quiz.dart';
import 'package:diceapp/Rewards.dart';
import 'package:diceapp/Wallpaper.dart';
import 'package:diceapp/shield.dart';
import 'package:diceapp/token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> gridItems = [
    {
      'title': 'Rewards',
      'image': 'Asserts/rewards.png',
      'page': Rewards()
    },
    {
      'title': 'Events',
      'image': 'Asserts/event.png',
      'page': Events()
    },
    {
      'title': 'Token',
      'image': 'Asserts/token.png',
      'page': Token()
    },
    {
      'title': 'Shield',
      'image': 'Asserts/shield.png',
      'page': Shield()
    },
    {
      'title': 'Blogs',
      'image': 'Asserts/blog.png',
      'page': Blog()
    },
    {
      'title': 'FAQS',
      'image': 'Asserts/faqs.png',
      'page': FAQS()
    },
    {
      'title': 'Quiz',
      'image': 'Asserts/quiz.png',
      'page': Quiz()
    },
    {
      'title': 'Wallpaper',
      'image': 'Asserts/wallpaper.png',
      'page': Wallpaper()
    },
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      // appBar: AppBar(
      //   title: Text("Daily Dice Rewards", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      // ),
      body: Container(
        height: height,
        width: width,
        // color: Color(0xffeff4f8),
        // decoration: BoxDecoration(
        //   // color: Colors.white,
        //   image: DecorationImage(
        //     image: AssetImage("Asserts/background1.jpeg"), fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30),
            //   child: Text("Dice App",style: TextStyle(color: Color(0xffd3dbde),fontWeight: FontWeight.bold,fontSize: 30),),
            // ),
            // SizedBox(height: 10,),
            Container(
              height: 240,
              width: width,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Asserts/home1.png"),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 20,
                    child: Container(
                      child: Text(
                        "Dice App",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            letterSpacing: 3,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(height: 20,),
            Expanded(
              child: Container(
                // padding: EdgeInsets.all(10),
                // width: width,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12,top: 2),
                  child: GridView.builder(
                    padding: EdgeInsets.all(0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: gridItems.length,
                    itemBuilder: (context, index) {
                      final items = gridItems[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return items['page'];
                            },
                          ));
                        },

                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [new BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2
                                  ),],
                                  color: Color(0xfff2f2f2),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(5),
                                      topRight: Radius.circular(5))
                              ),

                              child: Stack(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        gridItems[index]['title'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      child: Image.asset(
                                        gridItems[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

