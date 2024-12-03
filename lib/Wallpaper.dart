import 'dart:convert';

import 'package:diceapp/wallpaper_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List wallpaperList = [];
  bool isloading=false;

  Future<void> fetchData() async {
    var url = Uri.parse('https://miracocopepsi.com/admin/mayur/coc/raj/ios/monopolygo/json/wallpaper.json');
    var response = await http.get(url);

    var result = jsonDecode(response.body);

    setState(() {
      wallpaperList = result;
      isloading=false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {
      isloading=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Text("Wallpaper"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body:isloading?Center(
        child: CircularProgressIndicator(),
      ):Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: wallpaperList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 8,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WallpaperDetails(wallpaper:wallpaperList[index]);
                },));
              },
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: isloading?Center(
                  child: CircularProgressIndicator(),
                ):Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff966303),
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Color(0xff966303), width: 3),
                    image: DecorationImage(
                      image: NetworkImage(wallpaperList[index]),
                      fit: BoxFit.cover,
                    ),
              
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
