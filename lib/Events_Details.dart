import 'package:flutter/material.dart';

class EventsDetails extends StatelessWidget {
  final Map<String, dynamic> eventData;

  const EventsDetails({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Text("Event Details"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xff966303),
                      width: 5
                    )
                  )
                ),
                child: Text(
                  eventData['event_date'],
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff966303),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Tournaments :",
                style: TextStyle(
                  fontSize: 23,
                  color: Color(0xff966303),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: List.generate(
                  eventData['tournaments'].length,
                  (index) {
                    var tournament = eventData['tournaments'][index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tournament['description'],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          ...tournament['t_data'].map<Widget>((tData) {
                            return Text(
                              "${tData['name']} at ${tData['time']}",
                              style: TextStyle(fontSize: 14),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Special Event :",
                style: TextStyle(
                  fontSize: 23,
                  color: Color(0xff966303),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: List.generate(
                  eventData['special_events'].length,
                  (index) {
                    var events = eventData['special_events'][index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          events['description'],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ...events['se_data'].map<Widget>((seData) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
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
                                      color: Color(0xff966303), width: 3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor:Color(0xfffde4b4),
                                        child: Image.network(
                                          seData['image'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            seData['name'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            seData['start_time'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            seData['end_date'],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: List.generate(
                    eventData['event_images'].length,
                    (index) {
                      var img = eventData['event_images'][index];
                      return Container(
                        height: 400.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xff966303),
                              blurRadius: 3,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(img,
                              fit: BoxFit.cover, height: 150.0, width: 100.0),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
