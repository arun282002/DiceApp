import 'dart:convert';
import 'package:diceapp/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'globals.dart' as globals;
import 'rewards_Details.dart';

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  List APIdata = [];
  bool isloading=false;
  // List<bool> claimed = [];
  // final storage = GetStorage();
  // List<List> localListMain=[];

  // List<bool> localListSub=[];
  @override
  void initState() {
    super.initState();
    FetchAPI();
    setState(() {
      isloading=true;
    });
  }

  Future<void> FetchAPI() async {
    var url = Uri.parse('https://rbtechlab.in/Monopoly%20Go/dice.json');
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    setState(() {
      APIdata = result;
      isloading=false;
      // APIdata = result['field'];
      // int totalLinks = result.fold(0, (sum, item) => sum + item['links'].length);
      // claimed = List<bool>.filled(totalLinks, false);
      // loadClaimedStatus();
    });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Text("Rewards"),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:isloading?Center(child: CircularProgressIndicator(),): SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: APIdata.length,
            itemBuilder: (context, dateIndex) {
              final date = APIdata[dateIndex]['date'];
              final links = APIdata[dateIndex]['links'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      date.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xff966303),
                          letterSpacing: 5),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: links.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 200,
                      crossAxisCount: 1,
                    ),
                    itemBuilder: (context, linkIndex) {
                      var name = links[linkIndex]['name'];
                      var link = links[linkIndex]['link'];
                      var globalIndex = dateIndex * APIdata[0]['links'].length + linkIndex;


                      // localListMain=storage.read("localList");
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 3,
                                ),
                              ],
                              color: Color(0xfffbbf50),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Color(0xff966303), width: 3)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return RewardsDetails(
                                                  rewardsData: APIdata[dateIndex],
                                                  data: links[linkIndex],
                                                  globalINDEX:globalIndex
                                                  // dateIndex: dateIndex,linkIndex: linkIndex,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            color: Color(0xff966303),
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Image.asset("Asserts/right.png"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          AssetImage("Asserts/dice1.png"))),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
