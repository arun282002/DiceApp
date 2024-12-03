import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Events_Details.dart'; // Ensure you import the updated EventsDetails

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<Map<String, dynamic>> eventData = [];
  bool isloading=false;

  Future<void> loadEvents() async {
    var response = await rootBundle.loadString("Asserts/Files/event.json");
    print("Response");
    print(response);
    Map<String, dynamic> result = json.decode(response);
    print("Result");
    print(result);

    setState(() {
      eventData = List<Map<String, dynamic>>.from(result['event_data']);
      isloading=false;
    });
    print("length");
    print(eventData.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadEvents();
    setState(() {
      isloading=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Text("Events"),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:isloading?Center(child: CircularProgressIndicator(),): Container(
        child: eventData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: eventData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 5, left: 15, right: 15),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return EventsDetails(
                            eventData: eventData[index]);
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                        ),
                      ],
                      color: Color(0xfffbbf50),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Color(0xff966303), width: 3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${eventData[index]['event_date']}",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "Asserts/right_arrow.png"),fit: BoxFit.cover)),
                        )
                      ],
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
